import java.nio.file.*;
import java.util.*;
import java.util.zip.*;

/** Explicit replacement/addition directory; all remaining installed payloads verified byte-for-byte. */
public final class RepackNativeModule {
    public static void main(String[] args) throws Exception {
        Path overlay=Path.of(args[1]),output=Path.of(args[2]);
        Map<String,Path> changes=new TreeMap<>();
        try(var paths=Files.walk(overlay)) { paths.filter(Files::isRegularFile).forEach(path -> changes.put(overlay.relativize(path).toString().replace('\\','/'),path)); }
        for(String name:changes.keySet()) if(!(name.equals("classes4.dex")||name.equals("AndroidManifest.xml")
                ||name.startsWith("assets/legendary/models/")||name.equals("assets/legendary/watermarks/leica-135.zip")
                ||name.startsWith("lib/arm64-v8a/"))) throw new IllegalArgumentException("Unapproved entry "+name);
        Set<String> seen=new HashSet<>();
        try(var source=new ZipFile(args[0]);var zip=new ZipOutputStream(Files.newOutputStream(output,StandardOpenOption.CREATE_NEW))) {
            var entries=source.entries();
            while(entries.hasMoreElements()) {
                var entry=entries.nextElement();String name=entry.getName();
                if(!seen.add(name))throw new IllegalStateException("Duplicate baseline entry");
                if(signature(name))continue;
                byte[] bytes;
                if(changes.containsKey(name))bytes=Files.readAllBytes(changes.get(name));
                else try(var in=source.getInputStream(entry)){bytes=in.readAllBytes();}
                put(zip,name,bytes,entry.getMethod());
            }
            for(var item:changes.entrySet())if(!seen.contains(item.getKey()))put(zip,item.getKey(),Files.readAllBytes(item.getValue()),
                    item.getKey().endsWith(".so")?ZipEntry.STORED:ZipEntry.DEFLATED);
        }
        int preserved=0;
        try(var original=new ZipFile(args[0]);var built=new ZipFile(args[2])) {
            var entries=original.entries();
            while(entries.hasMoreElements()) {
                var entry=entries.nextElement();String name=entry.getName();
                if(signature(name)||changes.containsKey(name))continue;
                var next=built.getEntry(name);if(next==null)throw new IllegalStateException("Missing "+name);
                try(var left=original.getInputStream(entry);var right=built.getInputStream(next)) {
                    if(!Arrays.equals(left.readAllBytes(),right.readAllBytes()))throw new IllegalStateException("Unexpected change "+name);
                }
                preserved++;
            }
        }
        System.out.println("Verified unchanged baseline payloads="+preserved+" explicit overlay entries="+changes.size());
    }
    static boolean signature(String name){return name.matches("(?i)META-INF/(MANIFEST\\.MF|[^/]+\\.(SF|RSA|DSA|EC))");}
    static void put(ZipOutputStream zip,String name,byte[] data,int method)throws Exception {
        ZipEntry entry=new ZipEntry(name);entry.setMethod(name.equals("resources.arsc")?ZipEntry.STORED:method);
        if(entry.getMethod()==ZipEntry.STORED){CRC32 crc=new CRC32();crc.update(data);entry.setSize(data.length);entry.setCompressedSize(data.length);entry.setCrc(crc.getValue());}
        zip.putNextEntry(entry);zip.write(data);zip.closeEntry();
    }
}
