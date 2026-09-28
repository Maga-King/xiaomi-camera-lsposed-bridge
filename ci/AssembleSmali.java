import brut.androlib.smali.SmaliBuilder;
import com.android.tools.smali.dexlib2.Opcodes;
import com.android.tools.smali.dexlib2.writer.builder.DexBuilder;
import com.android.tools.smali.dexlib2.writer.io.FileDataStore;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.stream.Stream;

/** Host-only assembler using the already installed apktool's smali library. */
public final class AssembleSmali {
    public static void main(String[] args) throws Exception {
        if (args.length != 2) throw new IllegalArgumentException("smali-dir output.dex");
        Path source = Path.of(args[0]);
        Path output = Path.of(args[1]);
        if (Files.exists(output)) throw new IllegalArgumentException("Output already exists");
        List<Path> files;
        try (Stream<Path> stream = Files.walk(source)) {
            files = stream.filter(p -> p.toString().endsWith(".smali")).sorted().toList();
        }
        if (files.isEmpty()) throw new IllegalArgumentException("No smali input");
        DexBuilder dex = new DexBuilder(new Opcodes(30));
        SmaliBuilder assembler = new SmaliBuilder(30);
        for (Path input : files) {
            if (!assembler.buildFile(input.toFile(), dex)) {
                throw new IllegalStateException("Assembly failed: " + input);
            }
        }
        FileDataStore store = new FileDataStore(output.toFile());
        try {
            dex.writeTo(store);
        } finally {
            store.raf.close();
        }
        System.out.println("Assembled " + files.size() + " classes -> " + output);
    }
}
