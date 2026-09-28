import local.mio.os4camerabridge.RearJpegMetadataPolicy;
import java.io.ByteArrayOutputStream;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;

public final class RearJpegMetadataPolicyTest {
    private static int checks;
    private static byte[] segment(int marker, String payload) {
        byte[] bytes = payload.getBytes(StandardCharsets.ISO_8859_1);
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        out.write(255); out.write(marker);
        out.write((bytes.length + 2) >>> 8); out.write((bytes.length + 2) & 255);
        out.writeBytes(bytes);
        return out.toByteArray();
    }
    private static byte[] jpeg(byte[]... segments) {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        out.write(255); out.write(216);
        for (byte[] segment : segments) out.writeBytes(segment);
        out.writeBytes(new byte[]{(byte)255, (byte)218, 0, 8, 1, 1, 0, 0, 63, 0,
                10, 20, (byte)255, 0, 30, (byte)255, (byte)217});
        return out.toByteArray();
    }
    private static void check(boolean value, String label) {
        checks++;
        if (!value) throw new AssertionError(label);
    }
    private static void equal(byte[] expected, byte[] actual, String label) {
        check(Arrays.equals(expected, actual), label);
    }
    private static void reject(byte[] bad, String label) {
        try { RearJpegMetadataPolicy.transfer(bad, jpeg()); }
        catch (IllegalArgumentException expected) { checks++; return; }
        throw new AssertionError(label);
    }
    public static void main(String[] args) {
        byte[] exif = segment(0xe1, "Exif\0\0source");
        byte[] exifTarget = segment(0xe1, "Exif\0\0target");
        byte[] xmp = segment(0xe1, "http://ns.adobe.com/xap/1.0/\0metadata");
        byte[] iptc = segment(0xed, "Photoshop metadata");
        byte[] iccSource = segment(0xe2, "ICC_PROFILE\0\1\1source");
        byte[] iccTarget = segment(0xe2, "ICC_PROFILE\0\1\1target");
        byte[] mpf = segment(0xe2, "MPF\0source-offsets");
        byte[] target = jpeg(iccTarget);
        byte[] source = jpeg(exif, xmp, iptc, iccSource, mpf);
        byte[] result = RearJpegMetadataPolicy.transfer(source, target);
        equal(jpeg(exif, xmp, iptc, iccTarget), result, "metadata transferred, target ICC retained, source MPF omitted");
        check(RearJpegMetadataPolicy.transfer(result, result) == result, "identity fast path");
        check(RearJpegMetadataPolicy.transfer(result.clone(), result) == result, "equal-content fast path");
        check(RearJpegMetadataPolicy.transfer(source, result) == result, "idempotent transfer");
        equal(jpeg(xmp, iptc, exifTarget, iccTarget),
                RearJpegMetadataPolicy.transfer(source, jpeg(exifTarget, iccTarget)), "encoder EXIF wins without duplicate");
        equal(jpeg(exif, xmp, iptc, iccTarget), RearJpegMetadataPolicy.transfer(
                jpeg(exif, exifTarget, xmp, xmp, iptc, iptc, iccSource, mpf), target), "source duplicate metadata deduplicated");
        check(RearJpegMetadataPolicy.transfer(jpeg(iccSource, mpf), target) == target, "APP2-only source changes nothing");
        check(RearJpegMetadataPolicy.transfer(jpeg(), target) == target, "empty metadata changes nothing");
        equal(jpeg(exif), RearJpegMetadataPolicy.transfer(jpeg(exif, iccSource), jpeg()), "no foreign ICC invented for untagged encoder");
        reject(null, "null"); reject(new byte[]{1,2,3,4}, "not JPEG");
        reject(new byte[]{(byte)255,(byte)216,(byte)255}, "truncated marker");
        reject(new byte[]{(byte)255,(byte)216,(byte)255,(byte)225,0,1}, "short segment");
        reject(new byte[]{(byte)255,(byte)216,(byte)255,(byte)225,127,127}, "oversized segment");
        reject(new byte[]{(byte)255,(byte)216,(byte)255,(byte)218,0,8}, "truncated SOS");
        reject(new byte[]{(byte)255,(byte)216,0,0}, "invalid marker");
        reject(new byte[]{(byte)255,(byte)216,(byte)255,(byte)225,0,2}, "no scan or EOI");
        byte[] filled = jpeg(exif);
        byte[] padded = new byte[filled.length + 1];
        System.arraycopy(filled, 0, padded, 0, 2); padded[2] = (byte)255;
        System.arraycopy(filled, 2, padded, 3, filled.length - 2);
        equal(jpeg(exif, iccTarget), RearJpegMetadataPolicy.transfer(padded, target), "marker padding accepted");
        System.out.println("RearJpegMetadataPolicy: " + checks + " checks passed");
    }
}
