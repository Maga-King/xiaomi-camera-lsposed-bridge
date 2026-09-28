package local.mio.os4camerabridge;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.nio.charset.StandardCharsets;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

/** Preserve the real Xiaomi watermark/removal contract alongside independent Legend payloads. */
public final class LegendaryWatermarkContainer {
    private static final String CAMERA="http://ns.xiaomi.com/photos/1.0/camera/";
    private static final byte[] XMP="http://ns.adobe.com/xap/1.0/\0".getBytes(StandardCharsets.UTF_8);
    private LegendaryWatermarkContainer() {}

    public static boolean primaryGeometryValid(byte[] jpeg) {
        try {
            int[] size=JpegWatermarkMetadataPolicy.dimensions(jpeg);
            if(size==null)return false;
            if(fullSize(size[0],size[1]))return true;
            if(size[0]>8192 || size[1]>8192)return false;
            String camera=legacy(jpeg);
            if(camera==null)return false;
            Document inner=parseInner(camera);
            NodeList nodes=inner.getElementsByTagName("madrid_image");
            if(nodes.getLength()!=1)return false;
            Element rect=(Element)nodes.item(0);
            int type=integer(rect,"type"),w=integer(rect,"width"),h=integer(rect,"height");
            int x=integer(rect,"paddingx"),y=integer(rect,"paddingy");
            // These are the exact native original-image ROI values, not a guessed sensor size.
            return (type==700 || type==701) && fullSize(w,h) && x>=0 && y>=0
                    && (long)x+w<=size[0] && (long)y+h<=size[1];
        } catch(Exception rejected){return false;}
    }

    public static byte[] preserve(byte[] primary,byte[] encoded,int addedTail) throws Exception {
        if(addedTail<0 || addedTail>encoded.length)throw new IllegalArgumentException("added tail");
        String original=legacy(primary);
        byte[] clean=LegendaryContainerIntegrity.repair(encoded);
        Document output=parse(xmp(clean));
        // MiPropXmp also has EOF-relative re-edit/end-marker properties outside XMPMeta.
        // Ra.a.e writes these after native removal payloads; appending RAW must relocate them too.
        shiftProperty(output,"http://ns.xiaomi.com/photos/1.0/camera/xmend",primary.length,addedTail);
        shiftProperty(output,"http://ns.xiaomi.com/photos/1.0/camera/reedit",primary.length,addedTail);
        Element owner=owner(output);
        if(owner==null)throw new IllegalArgumentException("legacy placeholder absent");
        if(original==null) {
            // Official unwatermarked 17U M9 has no Madrid property. Do not invent one.
            owner.removeAttributeNS(CAMERA,"XMPMeta");
        } else {
            Document inner=parseInner(original);
            NodeList items=inner.getDocumentElement().getChildNodes();
            boolean changed=false;
            for(int i=0;i<items.getLength();i++)if(items.item(i) instanceof Element) {
                Element e=(Element)items.item(i);
                if(!e.hasAttribute("length") || !e.hasAttribute("offset"))continue;
                long length=Long.parseLong(e.getAttribute("length"));
                long offset=Long.parseLong(e.getAttribute("offset"));
                if(length<0 || offset<0 || length>offset || offset>primary.length)
                    throw new IllegalArgumentException("native watermark attachment bounds: "+e.getTagName());
                if(length>0) {
                    // Native removal payloads are EOF-relative. Only appended tail changes these offsets.
                    e.setAttribute("offset",Long.toString(Math.addExact(offset,addedTail)));
                    changed|=addedTail!=0;
                }
            }
            if(changed) {
                StringBuilder text=new StringBuilder();
                for(int i=0;i<items.getLength();i++)if(items.item(i) instanceof Element)
                    text.append(new String(serialize(items.item(i)),StandardCharsets.UTF_8));
                original=text.toString();
            }
            owner.setAttributeNS(CAMERA,"MiCamera:XMPMeta",original);
        }
        return LegendaryContainerIntegrity.replaceXmp(clean,serialize(output));
    }

    private static void shiftProperty(Document d,String namespace,int originalLength,int addedTail) {
        NodeList nodes=d.getElementsByTagName("*");
        for(int i=0;i<nodes.getLength();i++) {
            Element e=(Element)nodes.item(i);
            if(!e.hasAttributeNS(namespace,"offset"))continue;
            long offset=Long.parseLong(e.getAttributeNS(namespace,"offset"));
            if(offset<=0 || offset>originalLength)throw new IllegalArgumentException("native EOF property bounds");
            org.w3c.dom.Attr attribute=e.getAttributeNodeNS(namespace,"offset");
            attribute.setValue(Long.toString(Math.addExact(offset,addedTail)));
        }
    }

    private static boolean fullSize(int w,int h){return w==4096&&h==3072 || w==3072&&h==4096;}
    private static int integer(Element e,String field){return Integer.parseInt(e.getAttribute(field));}
    private static String legacy(byte[] jpeg) throws Exception {
        byte[] bytes=xmp(jpeg);
        if(bytes==null)return null;
        Element e=owner(parse(bytes));
        return e==null?null:e.getAttributeNS(CAMERA,"XMPMeta");
    }
    private static Element owner(Document d) {
        Element found=null;
        NodeList all=d.getElementsByTagName("*");
        for(int i=0;i<all.getLength();i++) {
            Element e=(Element)all.item(i);
            if(!e.hasAttributeNS(CAMERA,"XMPMeta"))continue;
            if(found!=null)throw new IllegalArgumentException("multiple legacy camera properties");
            found=e;
        }
        return found;
    }
    private static byte[] xmp(byte[] jpeg) {
        if(jpeg==null || jpeg.length<4 || (jpeg[0]&255)!=255 || (jpeg[1]&255)!=216)
            throw new IllegalArgumentException("JPEG absent");
        byte[] result=null;
        for(int p=2;p<jpeg.length;) {
            if((jpeg[p++]&255)!=255)throw new IllegalArgumentException("JPEG header boundary");
            while(p<jpeg.length && (jpeg[p]&255)==255)p++;
            if(p>=jpeg.length)throw new IllegalArgumentException("JPEG marker");
            int marker=jpeg[p++]&255;
            if(marker==218 || marker==217)break;
            if(p>jpeg.length-2)throw new IllegalArgumentException("JPEG length");
            int len=((jpeg[p]&255)<<8)|(jpeg[p+1]&255);
            if(len<2 || p>jpeg.length-len)throw new IllegalArgumentException("JPEG segment bounds");
            if(marker==225 && len>=2+XMP.length) {
                boolean match=true;
                for(int i=0;i<XMP.length;i++)if(jpeg[p+2+i]!=XMP[i]){match=false;break;}
                if(match) {
                    if(result!=null)throw new IllegalArgumentException("multiple standard XMP packets");
                    result=java.util.Arrays.copyOfRange(jpeg,p+2+XMP.length,p+len);
                }
            }
            p+=len;
        }
        return result;
    }
    private static Document parseInner(String s) throws Exception {
        s=s.replaceFirst("^\\s*<\\?xml[^?]*\\?>","");
        return parse(("<root>"+s+"</root>").getBytes(StandardCharsets.UTF_8));
    }
    private static Document parse(byte[] data) throws Exception {
        if(data==null)throw new IllegalArgumentException("XMP absent");
        String text=new String(data,StandardCharsets.UTF_8);
        if(text.contains("<!DOCTYPE") || text.contains("<!ENTITY"))throw new IllegalArgumentException("DTD forbidden");
        DocumentBuilderFactory f=DocumentBuilderFactory.newInstance();
        f.setNamespaceAware(true);f.setExpandEntityReferences(false);
        return f.newDocumentBuilder().parse(new ByteArrayInputStream(data));
    }
    private static byte[] serialize(org.w3c.dom.Node node) throws Exception {
        javax.xml.transform.Transformer t=TransformerFactory.newInstance().newTransformer();
        t.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION,"yes");
        t.setOutputProperty(OutputKeys.ENCODING,"UTF-8");
        ByteArrayOutputStream out=new ByteArrayOutputStream();
        t.transform(new DOMSource(node),new StreamResult(out));return out.toByteArray();
    }
}
