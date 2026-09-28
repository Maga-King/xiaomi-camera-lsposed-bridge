import local.mio.os4camerabridge.LegendaryContainerIntegrity;
import java.nio.file.*;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.io.*;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.*;

public class TestLegendaryContainerIntegrity {
    static final byte[] XMP="http://ns.adobe.com/xap/1.0/\0".getBytes(StandardCharsets.UTF_8);
    static final String MI="http://ns.xiaomi.com/photos/1.0/container/item/";
    static int[] xmp(byte[] a) {
        for(int p=2;p<a.length;) {
            int m=a[p+1]&255, len=((a[p+2]&255)<<8)|(a[p+3]&255);
            if(m==0xda) break;
            if(m==0xe1 && Arrays.equals(Arrays.copyOfRange(a,p+4,p+4+XMP.length),XMP)) return new int[]{p,p+2+len};
            p+=len+2;
        }
        throw new AssertionError("XMP absent");
    }
    static String xml(byte[] a) { int[] at=xmp(a);return new String(a,at[0]+4+XMP.length,at[1]-at[0]-4-XMP.length,StandardCharsets.UTF_8); }
    static Document doc(String xml) throws Exception {
        DocumentBuilderFactory f=DocumentBuilderFactory.newInstance();f.setNamespaceAware(true);
        return f.newDocumentBuilder().parse(new ByteArrayInputStream(xml.getBytes(StandardCharsets.UTF_8)));
    }
    static List<Element> legend(Document d) {
        List<Element> out=new ArrayList<>();NodeList list=d.getElementsByTagName("*");
        for(int i=0;i<list.getLength();i++) { Element e=(Element)list.item(i);if(e.getAttributeNS(MI,"name").startsWith("Legend."))out.add(e); }
        return out;
    }
    static int scan(byte[] a) {
        for(int p=2;p<a.length;) {if((a[p+1]&255)==0xda)return p;int len=((a[p+2]&255)<<8)|(a[p+3]&255);p+=2+len;}
        throw new AssertionError("SOS absent");
    }
    static void check(boolean value,String why) {if(!value)throw new AssertionError(why);}
    static void verify(byte[] a,byte[] b,boolean nativeReference) throws Exception {
        List<Element> ai=legend(doc(xml(a))), bi=legend(doc(xml(b)));
        check(ai.size()==bi.size(),"Legend item count");
        for(int i=0;i<ai.size();i++) {
            Element x=ai.get(i), y=bi.get(i);
            check(MI.equals(y.lookupNamespaceURI("MiItem")),"cleaner prefix not bound");
            check(x.getAttributeNS(MI,"Offset").equals(y.getAttributeNS(MI,"Offset")),"EOF offset changed");
            int length=Integer.parseInt(x.getAttributeNS(MI,"length")), offset=Integer.parseInt(x.getAttributeNS(MI,"Offset"));
            check(Arrays.equals(Arrays.copyOfRange(a,a.length-offset,a.length-offset+length),Arrays.copyOfRange(b,b.length-offset,b.length-offset+length)),"RAW/meta bytes changed");
        }
        check(Arrays.equals(Arrays.copyOfRange(a,scan(a),a.length),Arrays.copyOfRange(b,scan(b),b.length)),"JPEG scan or tail bytes changed");
        String cleaned=xml(b).replace("Item:Mime=\"meta/protobuf\"","Item:Mime=\"meta/protobuf\" MiItem:CenterBrightness=\"0.5\"");
        doc(cleaned);
        check(Arrays.equals(b,LegendaryContainerIntegrity.repair(b)),"not idempotent");
        if(nativeReference)check(Arrays.equals(a,b),"native reference unnecessarily changed");
    }
    public static void main(String[] args) throws Exception {
        Path root=Path.of(args[0]), out=Path.of(args[1]);Files.createDirectories(out);
        List<Path> samples=List.of(root.resolve("originals/IMG_20260908_152015.jpg"),root.resolve("originals/IMG_20260908_152020.jpg"),root.resolve("phone_evidence/IMG_20260908_121947.jpg"),root.resolve("phone_evidence/IMG_20260908_145503.jpg"));
        int count=0;
        for(Path p:samples) {
            byte[] a=Files.readAllBytes(p), b=LegendaryContainerIntegrity.repair(a);
            boolean nativeReference=p.getParent().getFileName().toString().equals("originals");
            verify(a,b,nativeReference);
            if(!nativeReference)check(!xml(b).contains("Semantic=\"GainMap\""),"dangling gainmap still advertised");
            Files.write(out.resolve(p.getFileName()),b,StandardOpenOption.CREATE_NEW);
            System.out.println("PASS "+p.getFileName()+" bytes="+a.length+"->"+b.length+" nativeUnchanged="+nativeReference);count++;
        }
        // Same-length alias change keeps the input MPF valid while exercising
        // header growth with a REAL gainmap that must not be discarded.
        byte[] nativeM9=Files.readAllBytes(samples.get(0));int[] at=xmp(nativeM9);
        byte[] old=xml(nativeM9).getBytes(StandardCharsets.UTF_8), alias=xml(nativeM9).replace("MiItem","XiItem").getBytes(StandardCharsets.UTF_8);
        check(old.length==alias.length,"alias length");
        byte[] changed=nativeM9.clone();System.arraycopy(alias,0,changed,at[0]+4+XMP.length,alias.length);
        byte[] fixed=LegendaryContainerIntegrity.repair(changed);verify(changed,fixed,false);
        check(xml(fixed).contains("Semantic=\"GainMap\""),"valid gainmap lost");
        Files.write(out.resolve("native-valid-gainmap-alias.jpg"),fixed,StandardOpenOption.CREATE_NEW);
        System.out.println("PASS valid gainmap with namespace repair and MPF relocation");count++;
        System.out.println("Tests passed="+count);
    }
}
