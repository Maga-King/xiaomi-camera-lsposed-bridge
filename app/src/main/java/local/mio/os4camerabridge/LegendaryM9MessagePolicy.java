package local.mio.os4camerabridge;

import java.util.HashMap;
import java.util.Map;

/** Same-size protobuf field replacement; never rewrites RAW/JPEG/container offsets. */
public final class LegendaryM9MessagePolicy {
    private LegendaryM9MessagePolicy() {}
    public static byte[] correct(byte[] original, float zoom, float ispGain, float[] ccm) {
        if (!positive(zoom) || !positive(ispGain) || ccm == null || ccm.length != 9)
            throw new IllegalArgumentException("missing capture contract");
        for (float value : ccm) if (!Float.isFinite(value) || Math.abs(value) > 16)
            throw new IllegalArgumentException("invalid color transform");
        Map<Integer, Integer> offsets = new HashMap<>();
        int[] cursor = {0};
        while (cursor[0] < original.length) {
            long key = varint(original, cursor);
            int field = (int) (key >>> 3), wire = (int) (key & 7);
            if (field <= 0) throw new IllegalArgumentException("invalid field");
            int position = cursor[0], length;
            if (wire == 0) { varint(original, cursor); continue; }
            if (wire == 1) length = 8;
            else if (wire == 5) length = 4;
            else if (wire == 2) {
                long n = varint(original, cursor);
                if (n > original.length) throw new IllegalArgumentException("invalid length");
                length = (int) n; position = cursor[0];
            } else throw new IllegalArgumentException("unsupported wire type");
            if (length < 0 || position > original.length - length) throw new IllegalArgumentException("truncated packet");
            if (field == 5 || field == 9 || field == 18) {
                if (offsets.put(field, position) != null) throw new IllegalArgumentException("duplicate contract field");
                if (field == 18 ? wire != 2 || length != 36 : wire != 5)
                    throw new IllegalArgumentException("contract wire mismatch");
            }
            cursor[0] = position + length;
        }
        if (offsets.size() != 3) throw new IllegalArgumentException("contract fields absent");
        byte[] result = original.clone();
        put(result, offsets.get(5), ispGain);
        put(result, offsets.get(9), zoom);
        for (int i = 0; i < 9; i++) put(result, offsets.get(18) + i * 4, ccm[i]);
        return result;
    }
    private static long varint(byte[] bytes, int[] cursor) {
        long value = 0;
        for (int shift = 0; shift < 64 && cursor[0] < bytes.length; shift += 7) {
            int part = bytes[cursor[0]++] & 255;
            value |= (long) (part & 127) << shift;
            if ((part & 128) == 0) return value;
        }
        throw new IllegalArgumentException("invalid varint");
    }
    private static void put(byte[] bytes, int offset, float value) {
        int bits = Float.floatToRawIntBits(value);
        for (int i = 0; i < 4; i++) bytes[offset + i] = (byte) (bits >>> (i * 8));
    }
    private static boolean positive(float value) { return Float.isFinite(value) && value > 0; }
}
