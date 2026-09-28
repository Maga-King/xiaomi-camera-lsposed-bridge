package local.mio.os4camerabridge;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public final class JpegWatermarkMetadataPolicyTest {
    private static int checks;
    public static void main(String[] args) throws Exception {
        check(JpegWatermarkMetadataPolicy.eligible(163, 0, 0, true), "rear Photo");
        check(JpegWatermarkMetadataPolicy.eligible(167, 0, 0, true), "rear Pro");
        check(!JpegWatermarkMetadataPolicy.eligible(256, 0, 0, true), "exclude M3/M9");
        check(!JpegWatermarkMetadataPolicy.eligible(171, 0, 0, true), "exclude portrait");
        check(!JpegWatermarkMetadataPolicy.eligible(163, 1, 0, true), "exclude front");
        check(!JpegWatermarkMetadataPolicy.eligible(163, 0, 1, true), "exclude parallel");
        check(!JpegWatermarkMetadataPolicy.eligible(163, 0, 0, false), "water disabled");
        check(JpegWatermarkMetadataPolicy.needsRestore("6400", null), "restore missing");
        check(JpegWatermarkMetadataPolicy.needsRestore("1/8000", null), "short exposure fraction retained");
        check(!JpegWatermarkMetadataPolicy.needsRestore("6400", "3200"), "keep existing");
        check(!JpegWatermarkMetadataPolicy.needsRestore(null, null), "no fabricated value");
        check(!JpegWatermarkMetadataPolicy.needsRestore("", null), "no empty value");
        check(!JpegWatermarkMetadataPolicy.needsRestore("1".repeat(161), null), "bounded value");
        Set<String> tags = new HashSet<>(Arrays.asList(JpegWatermarkMetadataPolicy.SHOOTING_TAGS));
        check(tags.size() == JpegWatermarkMetadataPolicy.SHOOTING_TAGS.length, "unique tags");
        for (String excluded : new String[]{"Orientation", "PixelXDimension", "PixelYDimension",
                "ImageWidth", "ImageLength", "MakerNote", "UserComment", "XiaomiCvSessionkeyType",
                "Xmp", "JPEGInterchangeFormat", "GPSLatitude", "GPSLongitude"})
            check(!tags.contains(excluded), "exclude " + excluded);
        byte[] jpeg = {(byte)255,(byte)216,(byte)255,(byte)225,0,4,0,0,
                (byte)255,(byte)192,0,11,8,0x11,(byte)0xc6,0x0c,0,1,1,0x11,0,
                (byte)255,(byte)217};
        check(Arrays.equals(JpegWatermarkMetadataPolicy.dimensions(jpeg), new int[]{3072,4550}), "SOF size");
        byte[] progressive = jpeg.clone(); progressive[9] = (byte)194;
        check(Arrays.equals(JpegWatermarkMetadataPolicy.dimensions(progressive), new int[]{3072,4550}), "progressive SOF");
        byte[] wrongMarker = jpeg.clone(); wrongMarker[9] = (byte)196;
        check(JpegWatermarkMetadataPolicy.dimensions(wrongMarker) == null, "DHT is not SOF");
        byte[] wrongLength = jpeg.clone(); wrongLength[11] = 8;
        check(JpegWatermarkMetadataPolicy.dimensions(wrongLength) == null, "component length validated");
        byte[] zeroWidth = jpeg.clone(); zeroWidth[15] = 0;
        check(JpegWatermarkMetadataPolicy.dimensions(zeroWidth) == null, "zero width rejected");
        check(JpegWatermarkMetadataPolicy.dimensions(null) == null, "null JPEG");
        for (int length = 0; length < 21; length++)
            check(JpegWatermarkMetadataPolicy.dimensions(Arrays.copyOf(jpeg, length)) == null, "truncated " + length);
        System.out.println("PASS " + checks + " watermark metadata policy/parser checks");
        for (String path : args) {
            int[] size = JpegWatermarkMetadataPolicy.dimensions(java.nio.file.Files.readAllBytes(java.nio.file.Path.of(path)));
            if (size == null) throw new AssertionError("Unrecognized sample JPEG SOF: " + path);
            System.out.println("Sample encoded size " + Arrays.toString(size) + " " + path);
        }
    }
    private static void check(boolean ok, String name) {
        if (!ok) throw new AssertionError(name);
        checks++;
    }
}
