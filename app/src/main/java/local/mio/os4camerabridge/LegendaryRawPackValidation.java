package local.mio.os4camerabridge;

/** Bounded per-frame checks of the integer-only packer already compared in full on device. */
public final class LegendaryRawPackValidation {
    private LegendaryRawPackValidation() {}
    public static void check(byte[] input, byte[] output, int[] table) {
        final int stride = 5120, bytes = stride * 3072, groups = 1024, pairs = groups * 1536;
        if (input == null || output == null || input.length != bytes || output.length != bytes
                || table == null || table.length != 1024) throw new IllegalArgumentException("RAW packing geometry");
        // Include both end groups and all four CFA positions, distributed through the whole frame.
        for (int i = 0; i < 1024; i++) {
            int pair = (int)((long)i * (pairs - 1) / 1023);
            int top = (pair / groups) * stride * 2 + (pair % groups) * 5;
            int bottom = top + stride;
            for (int lane = 0; lane < 4; lane++) {
                if (sample(output, top, lane) != table[sample(input, bottom, lane ^ 1)]
                        || sample(output, bottom, lane) != table[sample(input, top, lane ^ 1)])
                    throw new IllegalArgumentException("RAW sample mismatch pair=" + pair + " lane=" + lane);
            }
        }
    }
    private static int sample(byte[] bytes, int offset, int lane) {
        return ((bytes[offset + lane] & 255) << 2) | ((bytes[offset + 4] >>> (lane * 2)) & 3);
    }
}
