import java.nio.*;
import java.nio.file.*;
import java.util.*;

/** Build-only adaptation of private DIPS runtime: a disabled mask must not initialize an EGL engine. */
public final class PatchNativeNoMask {
    public static void main(String[] args) throws Exception {
        Path path=Path.of(args[0]);byte[] original=Files.readAllBytes(path),changed=original.clone();
        ByteBuffer elf=ByteBuffer.wrap(changed).order(ByteOrder.LITTLE_ENDIAN);
        if(elf.getInt(0)!=0x464c457f||elf.get(4)!=2||elf.getShort(18)!=183)throw new IllegalArgumentException("Expected ELF64 AArch64");
        int call=offset(elf,0x1631c),gate=offset(elf,0x1642c);
        int logWidth=offset(elf,0x1a210),logHeight=offset(elf,0x1a220);
        int expectedCall=0x94000000|(((0x12874-0x1631c)/4)&0x03ffffff);
        int expectedGate=0xb4000008|(((0x165a0-0x1642c)/4)<<5);
        int expectedLogWidth=0x94000000|(((0x12970-0x1a210)/4)&0x03ffffff);
        int expectedLogHeight=0x94000000|(((0x12980-0x1a220)/4)&0x03ffffff);
        if(elf.getInt(call)!=expectedCall||elf.getInt(gate)!=expectedGate
                ||elf.getInt(logWidth)!=expectedLogWidth||elf.getInt(logHeight)!=expectedLogHeight)
            throw new IllegalStateException("Exact runtime instructions changed; refusing patch");
        // The private worker ALWAYS sets M9_MASK_DISABLE=1. Run bypasses execute and destructor accepts nullptr.
        // Preserve real high/low/colorfix Init/shape validation/execution, not a dummy successful model result.
        elf.putInt(call,0xf900011f); // str xzr,[x8] -- null unique_ptr return, no unused portrait engine.
        elf.putInt(gate,0xd503201f); // nop -- require actual QNN, not a mask which this worker never consumes.
        // The final diagnostic line dereferences the mask even when Run did not use it.
        // Report the true disabled-mask dimensions (0x0); these calls feed logging only.
        elf.putInt(logWidth,0x2a1f03e0); // mov w0,wzr
        elf.putInt(logHeight,0x2a1f03e0);
        int[] patches={call,gate,logWidth,logHeight};
        for(int i=0;i<original.length;i++)if(original[i]!=changed[i]) {
            boolean allowed=false;for(int at:patches)if(i>=at&&i<at+4)allowed=true;
            if(!allowed)throw new AssertionError();
        }
        Files.write(path,changed,StandardOpenOption.TRUNCATE_EXISTING);
        System.out.println("Private mask-disabled runtime: exactly four validated AArch64 instructions adapted; model weights untouched");
    }
    static int offset(ByteBuffer elf,long address) {
        long table=elf.getLong(32);int entrySize=Short.toUnsignedInt(elf.getShort(54)),count=Short.toUnsignedInt(elf.getShort(56));
        for(int i=0;i<count;i++) {
            int p=Math.toIntExact(table+(long)i*entrySize);if(elf.getInt(p)!=1)continue;
            long file=elf.getLong(p+8),virtual=elf.getLong(p+16),size=elf.getLong(p+32);
            if(address>=virtual&&address+4<=virtual+size)return Math.toIntExact(file+address-virtual);
        }
        throw new IllegalArgumentException("Unmapped code address");
    }
}
