package local.mio.os4camerabridge;

/** Lossless 2x2-site reindexing into the legacy packer's RGGB contract. No gamma/NR/rotation. */
public final class LegendaryRawCfaLayout {
    private static final int[][] RGGB_SOURCE_POSITIONS = {
        {0,1,2,3}, {1,0,3,2}, {2,3,0,1}, {3,2,1,0}
    };
    private LegendaryRawCfaLayout() {}
    public static byte[] toRggb(byte[] source, int width, int height, int sourceCfa) {
        if (sourceCfa < 0 || sourceCfa > 3 || width <= 0 || width > 8192 || width % 4 != 0
                || height <= 0 || height > 8192 || height % 2 != 0)
            throw new IllegalArgumentException("CFA/geometry");
        int stride = width / 4 * 5;
        if (source == null || (long)stride * height != source.length)
            throw new IllegalArgumentException("RAW10 length");
        if (sourceCfa == 0) return source; // Exact main-camera byte identity, no extra allocation.
        byte[] result = new byte[source.length];
        int[] map = RGGB_SOURCE_POSITIONS[sourceCfa];
        for (int y=0; y<height; y+=2) {
            int top=y*stride, bottom=top+stride;
            for (int x=0; x<width; x+=4) {
                int offset=x/4*5;
                for (int cell=0; cell<4; cell+=2) {
                    for (int target=0; target<4; target++) {
                        int origin=map[target];
                        int value=read(source,(origin<2 ? top : bottom)+offset,cell+origin%2);
                        write(result,(target<2 ? top : bottom)+offset,cell+target%2,value);
                    }
                }
            }
        }
        return result;
    }
    private static int read(byte[] data,int offset,int index) {
        return (data[offset+index]&255)<<2 | (data[offset+4]>>>(index*2)&3);
    }
    private static void write(byte[] data,int offset,int index,int value) {
        data[offset+index]=(byte)(value>>>2);
        data[offset+4]=(byte)((data[offset+4]&255&~(3<<(index*2))) | ((value&3)<<(index*2)));
    }
}
