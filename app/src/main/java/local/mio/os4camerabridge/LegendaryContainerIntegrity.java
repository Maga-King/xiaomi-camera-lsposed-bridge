package local.mio.os4camerabridge;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NamedNodeMap;

/** Header-only repair of Xiaomi Legend containers. Never decodes image pixels. */
public final class LegendaryContainerIntegrity {
    private static final String MI = "http://ns.xiaomi.com/photos/1.0/container/item/";
    private static final String GOOGLE = "http://ns.google.com/photos/1.0/container/item/";
    private static final String CONTAINER = "http://ns.google.com/photos/1.0/container/";
    private static final String HDR = "http://ns.adobe.com/hdr-gain-map/1.0/";
    private static final String XMLNS = "http://www.w3.org/2000/xmlns/";
    private static final byte[] XMP = "http://ns.adobe.com/xap/1.0/\0".getBytes(StandardCharsets.UTF_8);

    private LegendaryContainerIntegrity() {}

    /** A complete primary JPEG may legitimately be followed by Xiaomi removal/RAW payloads. */
    public static boolean hasCompletePrimaryJpeg(byte[] input) {
        if (input == null || input.length < 4) return false;
        try {
            int[] size = JpegWatermarkMetadataPolicy.dimensions(input);
            if (size == null || size[0] <= 0 || size[1] <= 0) return false;
            headers(input);
            return jpegEnd(input, 0, input.length) > 2;
        } catch (RuntimeException invalid) { return false; }
    }

    /** Replace just the standard XMP header, keeping pixels, tails and valid MPF references. */
    public static byte[] replaceXmp(byte[] input, byte[] xml) throws Exception {
        List<Segment> all = headers(input);
        Segment found = null;
        for (Segment s : all) if (s.marker == 0xe1 && starts(input, s.start+4, XMP)) {
            if (found != null) throw new IllegalArgumentException("multiple XMP packets");
            found = s;
        }
        if (found == null) throw new IllegalArgumentException("XMP packet absent");
        int len = 2 + XMP.length + xml.length;
        if (len > 65535) throw new IllegalArgumentException("XMP header too large");
        ByteArrayOutputStream app = new ByteArrayOutputStream(len+2);
        app.write(255); app.write(225); app.write(len>>>8); app.write(len&255);
        app.write(XMP); app.write(xml);
        List<Edit> edits = java.util.Collections.singletonList(new Edit(found.start,found.end,app.toByteArray()));
        ByteArrayOutputStream out = new ByteArrayOutputStream(input.length+app.size());
        out.write(input,0,found.start); out.write(app.toByteArray());
        out.write(input,found.end,input.length-found.end);
        byte[] result = out.toByteArray();
        for (Segment s : all) if (s.marker==0xe2 && starts(input,s.start+4,new byte[]{77,80,70,0}))
            relocateMpf(input,result,s,edits);
        return result;
    }

    private static final class Segment {
        final int marker, start, end;
        Segment(int marker, int start, int end) { this.marker=marker; this.start=start; this.end=end; }
    }
    private static final class Edit {
        final int start, end;
        final byte[] bytes;
        Edit(int start, int end, byte[] bytes) { this.start=start; this.end=end; this.bytes=bytes; }
    }

    public static byte[] repair(byte[] input) throws Exception {
        List<Segment> headers = headers(input);
        Segment xmp = null;
        for (Segment s : headers) if (s.marker == 0xe1 && starts(input, s.start+4, XMP)) {
            if (xmp != null) throw new IllegalArgumentException("multiple standard XMP packets");
            xmp = s;
        }
        if (xmp == null) return input;
        String xml = new String(input, xmp.start+4+XMP.length, xmp.end-xmp.start-4-XMP.length, StandardCharsets.UTF_8);
        if (!xml.contains("Legend.M9") && !xml.contains("Legend.MONOPAN")) return input;
        if (xml.contains("<!DOCTYPE") || xml.contains("<!ENTITY")) throw new IllegalArgumentException("XMP DTD forbidden");
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(true);
        factory.setExpandEntityReferences(false);
        Document document = factory.newDocumentBuilder().parse(new ByteArrayInputStream(xml.getBytes(StandardCharsets.UTF_8)));
        List<Element> elements = elements(document);
        boolean owned=false, needNamespace=false;
        int attachmentStart=input.length;
        List<Element> gainItems=new ArrayList<>();
        for (Element e : elements) {
            String name=e.getAttributeNS(MI, "name");
            if (name.startsWith("Legend.M9") || name.equals("Legend.MONOPAN")) {
                owned=true;
                if (!MI.equals(e.lookupNamespaceURI("MiItem"))) needNamespace=true;
                String offset=e.getAttributeNS(MI, "Offset");
                String length=e.getAttributeNS(MI, "length");
                if (!offset.isEmpty() && !length.isEmpty()) {
                    long off=Long.parseLong(offset), len=Long.parseLong(length);
                    if (off<0 || len<0 || off>input.length || len>off) throw new IllegalArgumentException("Legend payload bounds");
                    if (len>0) attachmentStart=Math.min(attachmentStart, input.length-(int)off);
                }
            }
            if ("GainMap".equals(e.getAttributeNS(GOOGLE, "Semantic"))) gainItems.add(e);
        }
        if (!owned) return input;
        int primaryEnd=jpegEnd(input, 0, input.length);
        boolean staleGainMap=!gainItems.isEmpty() &&
            !(primaryEnd+2<=attachmentStart && starts(input, primaryEnd, new byte[]{(byte)255,(byte)216}));
        if (!needNamespace && !staleGainMap) return input;
        if (needNamespace) {
            // Keep the existing Item prefix for bytecode consumers. The editor's
            // cleaner inserts MiItem literally, so both aliases need the same URI.
            for (Element e : elements) if (e.getAttributeNS(MI,"name").startsWith("Legend.")) {
                if (!MI.equals(e.lookupNamespaceURI("MiItem")))
                    e.setAttributeNS(XMLNS, "xmlns:MiItem", MI);
            }
        }
        if (staleGainMap) {
            for (Element e : gainItems) {
                Node li=e.getParentNode();
                if (li != null && li.getParentNode() != null) li.getParentNode().removeChild(li);
            }
            for (Element e : elements(document)) {
                NamedNodeMap attrs=e.getAttributes();
                for (int i=attrs.getLength()-1;i>=0;i--) {
                    Node a=attrs.item(i);
                    if (HDR.equals(a.getNamespaceURI())) e.removeAttributeNode((org.w3c.dom.Attr)a);
                }
            }
            // A Google directory reduced to just Primary no longer describes
            // an auxiliary image. Keep non-HDR (e.g. MotionPhoto) entries intact.
            for (Element e : elements(document)) if (CONTAINER.equals(e.getNamespaceURI()) && "Directory".equals(e.getLocalName())) {
                boolean other=false;
                org.w3c.dom.NodeList entries=e.getElementsByTagNameNS(CONTAINER,"Item");
                for (int i=0;i<entries.getLength();i++) {
                    String semantic=((Element)entries.item(i)).getAttributeNS(GOOGLE,"Semantic");
                    if (!semantic.isEmpty() && !semantic.equals("Primary")) other=true;
                }
                if (!other && e.getParentNode()!=null) e.getParentNode().removeChild(e);
            }
        }
        ByteArrayOutputStream encoded=new ByteArrayOutputStream();
        javax.xml.transform.Transformer transformer=TransformerFactory.newInstance().newTransformer();
        transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION,"yes");
        transformer.setOutputProperty(OutputKeys.ENCODING,"UTF-8");
        transformer.transform(new DOMSource(document),new StreamResult(encoded));
        byte[] text=encoded.toByteArray();
        int length=2+XMP.length+text.length;
        if (length>65535) throw new IllegalArgumentException("XMP APP1 too large");
        ByteArrayOutputStream app1=new ByteArrayOutputStream(length+2);
        app1.write(255);app1.write(225);app1.write(length>>>8);app1.write(length&255);
        app1.write(XMP);app1.write(text);
        List<Edit> edits=new ArrayList<>();
        edits.add(new Edit(xmp.start,xmp.end,app1.toByteArray()));
        if (staleGainMap) for (Segment s:headers)
            if (s.marker==0xe2 && starts(input,s.start+4,new byte[]{77,80,70,0}))
                edits.add(new Edit(s.start,s.end,new byte[0]));
        edits.sort((a,b)->Integer.compare(a.start,b.start));
        ByteArrayOutputStream output=new ByteArrayOutputStream(input.length+text.length);
        int cursor=0;
        for(Edit e:edits) {
            if(e.start<cursor) throw new IllegalArgumentException("overlapping header edits");
            output.write(input,cursor,e.start-cursor);output.write(e.bytes);cursor=e.end;
        }
        output.write(input,cursor,input.length-cursor);
        byte[] result=output.toByteArray();
        if (!staleGainMap) for(Segment s:headers)
            if(s.marker==0xe2 && starts(input,s.start+4,new byte[]{77,80,70,0})) relocateMpf(input,result,s,edits);
        // EOF-relative Legend offsets remain valid: all edits precede the JPEG
        // scan and attachment bytes are copied verbatim in a single tail copy.
        return result;
    }

    private static void relocateMpf(byte[] old,byte[] out,Segment s,List<Edit> edits) {
        int t=s.start+8, nt=position(t,edits);
        boolean little=old[t]=='I' && old[t+1]=='I';
        if(!little && !(old[t]=='M' && old[t+1]=='M')) throw new IllegalArgumentException("MPF endian");
        int ifd=t+u32(old,t+4,little), count=u16(old,ifd,little);
        if(count>128 || ifd+2+count*12>s.end) throw new IllegalArgumentException("MPF IFD bounds");
        for(int i=0;i<count;i++) {
            int at=ifd+2+i*12;
            if(u16(old,at,little)!=0xb002) continue;
            int bytes=u32(old,at+4,little), table=t+u32(old,at+8,little);
            if(bytes<16 || bytes%16!=0 || table<t || table+bytes>s.end) throw new IllegalArgumentException("MPF entries");
            for(int j=0;j<bytes/16;j++) {
                int p=table+j*16, size=u32(old,p+4,little), relative=u32(old,p+8,little);
                int absolute=j==0 && relative==0 ? 0 : t+relative;
                if(absolute<0 || size<0 || absolute>old.length-size) throw new IllegalArgumentException("MPF image bounds");
                int newAbsolute=position(absolute,edits);
                put32(out,position(p+4,edits),position(absolute+size,edits)-newAbsolute,little);
                if(j!=0 || relative!=0) put32(out,position(p+8,edits),newAbsolute-nt,little);
            }
        }
    }
    private static int position(int p,List<Edit> edits) {
        int delta=0;
        for(Edit e:edits) {
            if(p>=e.end) delta+=e.bytes.length-(e.end-e.start);
            else if(p>e.start) throw new IllegalArgumentException("MPF points inside edited header");
        }
        return p+delta;
    }
    private static int u16(byte[] a,int p,boolean l) {
        if(p<0 || p>a.length-2) throw new IllegalArgumentException("u16 bounds");
        return l ? (a[p]&255)|((a[p+1]&255)<<8) : ((a[p]&255)<<8)|(a[p+1]&255);
    }
    private static int u32(byte[] a,int p,boolean l) {
        if(p<0 || p>a.length-4) throw new IllegalArgumentException("u32 bounds");
        return l ? u16(a,p,true)|(u16(a,p+2,true)<<16) : (u16(a,p,false)<<16)|u16(a,p+2,false);
    }
    private static void put32(byte[] a,int p,int value,boolean l) {
        for(int i=0;i<4;i++) a[p+i]=(byte)(value >>> (l ? i*8 : (3-i)*8));
    }
    private static List<Element> elements(Document d) {
        List<Element> all=new ArrayList<>();
        org.w3c.dom.NodeList nodes=d.getElementsByTagName("*");
        for(int i=0;i<nodes.getLength();i++) all.add((Element)nodes.item(i));
        return all;
    }
    private static boolean starts(byte[] data,int at,byte[] prefix) {
        if(at<0 || at>data.length-prefix.length) return false;
        for(int i=0;i<prefix.length;i++) if(data[at+i]!=prefix[i]) return false;
        return true;
    }
    private static List<Segment> headers(byte[] data) {
        if(!starts(data,0,new byte[]{(byte)255,(byte)216})) throw new IllegalArgumentException("not JPEG");
        List<Segment> result=new ArrayList<>();
        for(int p=2;p<data.length;) {
            int start=p;
            if((data[p++]&255)!=255) throw new IllegalArgumentException("JPEG header boundary");
            while(p<data.length && (data[p]&255)==255)p++;
            if(p>=data.length)throw new IllegalArgumentException("JPEG marker truncated");
            int marker=data[p++]&255;
            if(marker==0xda || marker==0xd9) return result;
            int len=u16(data,p,false);
            if(len<2 || p>data.length-len)throw new IllegalArgumentException("JPEG segment bounds");
            result.add(new Segment(marker,start,p+len));p+=len;
        }
        throw new IllegalArgumentException("JPEG scan missing");
    }
    private static int jpegEnd(byte[] data,int start,int limit) {
        int p=start+2;boolean entropy=false;
        while(p<limit) {
            if(entropy) { while(p<limit && (data[p]&255)!=255)p++; }
            if(p>=limit || (data[p++]&255)!=255)throw new IllegalArgumentException("JPEG scan boundary");
            while(p<limit && (data[p]&255)==255)p++;
            if(p>=limit)throw new IllegalArgumentException("JPEG scan truncated");
            int marker=data[p++]&255;
            if(entropy && (marker==0 || marker>=0xd0 && marker<=0xd7))continue;
            if(marker==0xd9)return p;
            if(marker==0xd8 || marker==1)continue;
            int len=u16(data,p,false);
            if(len<2 || p>limit-len)throw new IllegalArgumentException("JPEG scan length");
            p+=len;entropy=marker==0xda;
        }
        throw new IllegalArgumentException("JPEG EOI absent");
    }
}
