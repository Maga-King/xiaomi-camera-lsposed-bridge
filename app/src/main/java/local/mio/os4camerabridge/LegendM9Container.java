package local.mio.os4camerabridge;

import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.charset.StandardCharsets;
import java.util.Locale;

/** Builds the native Xiaomi M9/"Leica Legendary" cloud input container. */
final class LegendM9Container {
    static final int RAW_WIDTH = 4096;
    static final int RAW_HEIGHT = 3072;
    static final int RAW_STRIDE = 5120;
    static final int RAW_BYTES = RAW_STRIDE * RAW_HEIGHT;
    static final int LSC_FLOATS = 17 * 13 * 4;
    static final String CLOUD_ALGORITHM_VERSION = "1.4.251127.0";

    private static final String NS_CONTAINER =
            "http://ns.xiaomi.com/photos/1.0/container/";
    private static final String NS_ITEM =
            "http://ns.xiaomi.com/photos/1.0/container/item/";
    private static final byte[] XMP_HEADER =
            "http://ns.adobe.com/xap/1.0/\0"
                    .getBytes(StandardCharsets.UTF_8);
    private static final String RAW_KEY_PREFIX = "xiaomi";
    private static final String RAW_KEY_SUFFIX =
            "niubi_f4d7a2c9e1b3f5a7d2c4e6b8f0a1c3d5e7b9f2a4c6e8b0f1a3c5e7b9f0a2c4d6";

    static final class Metadata {
        final int sensitivityIso;
        final float awbR;
        final float awbG;
        final float awbB;
        final float adrcGain;
        final float ispGain;
        final float exposureMs;
        final int orientation;
        final int cct;
        final int luxIndex;
        final int blackLevel;
        final int whiteLevel;
        final int sensorMode;
        final int sensorType;
        /** Android SENSOR_INFO_COLOR_FILTER_ARRANGEMENT (RGGB=0..BGGR=3). */
        final int sourceCfa;

        Metadata(int sensitivityIso, float awbR, float awbG, float awbB,
                float adrcGain, float ispGain, float exposureMs,
                int orientation, int cct, int luxIndex, int blackLevel,
                int whiteLevel, int sensorMode, int sensorType,
                int sourceCfa) {
            this.sensitivityIso = sensitivityIso;
            this.awbR = awbR;
            this.awbG = awbG;
            this.awbB = awbB;
            this.adrcGain = adrcGain;
            this.ispGain = ispGain;
            this.exposureMs = exposureMs;
            this.orientation = orientation;
            this.cct = cct;
            this.luxIndex = luxIndex;
            this.blackLevel = blackLevel;
            this.whiteLevel = whiteLevel;
            this.sensorMode = sensorMode;
            this.sensorType = sensorType;
            this.sourceCfa = sourceCfa;
        }

        void validate() {
            require(sensitivityIso > 0, "ISO absent");
            require(positive(awbR) && positive(awbG) && positive(awbB),
                    "AWB gains absent");
            require(positive(adrcGain), "ADRC gain absent");
            require(positive(ispGain), "ISP gain absent");
            require(positive(exposureMs), "exposure absent");
            require(orientation == 0 || orientation == 90
                            || orientation == 180 || orientation == 270,
                    "invalid orientation " + orientation);
            require(cct > 0, "CCT absent");
            require(luxIndex >= 0, "lux index absent");
            require(blackLevel >= 0 && blackLevel < whiteLevel
                            && whiteLevel <= 1024,
                    "invalid RAW10 levels " + blackLevel + "/"
                            + whiteLevel);
            require(sensorType > 0, "sensor type absent");
            require(sourceCfa >= 0 && sourceCfa <= 3,
                    "unsupported source CFA " + sourceCfa);
        }
    }

    private LegendM9Container() {
    }

    static byte[] wrap(byte[] jpeg, byte[] raw10, float[] lsc,
            String jpegBasename, Metadata metadata) {
        requireJpeg(jpeg);
        int[] dimensions = jpegDimensions(jpeg);
        require(LegendaryWatermarkContainer.primaryGeometryValid(jpeg),
                "M9 primary must retain a native full-size image ROI, got "
                        + dimensions[0] + "x" + dimensions[1]);
        require(raw10 != null && raw10.length == RAW_BYTES,
                "RAW10 length invalid");
        require(lsc != null && lsc.length == LSC_FLOATS,
                "LSC must contain " + LSC_FLOATS + " floats");
        String basename = normalizeBasename(jpegBasename);
        metadata.validate();

        byte[] tagged = LegendExifTagger.tag(jpeg, 1);
        require(LegendExifTagger.read(tagged) == 1,
                "legendmode EXIF readback failed");
        byte[] packedRaw = packToCloudBggr(raw10,
                metadata.blackLevel, metadata.whiteLevel, basename,
                metadata.sourceCfa);
        byte[] message = buildMessage(basename, metadata, lsc);
        byte[] output = addM9Container(tagged, packedRaw, message,
                metadata.orientation);
        verify(output, packedRaw.length, message.length);
        return LegendaryContainerIntegrityBridge.finish(output);
    }

    /**
     * Builds the JPEG-only M3 contract consumed by MediaEditor's local
     * mialgo_monopan pipeline. M3 uses the primary HAL JPEG as its input; it
     * does not use the encrypted RAW10/protobuf pair required by M9.
     */
    static byte[] wrapM3(byte[] jpeg) {
        requireJpeg(jpeg);
        int[] dimensions = jpegDimensions(jpeg);
        byte[] tagged = LegendExifTagger.tag(jpeg, 2);
        byte[] output = addM3Container(tagged,
                dimensions[0], dimensions[1]);
        require(LegendExifTagger.read(output) == 2,
                "M3 EXIF marker missing");
        Segment xmp = findXmp(output);
        require(xmp != null, "M3 XMP missing");
        String text = xml(output, xmp);
        require(count(text, "Item:name=\"Legend.MONOPAN\"") == 1,
                "M3 item set invalid");
        require(count(text, "Item:UseMainImage=\"1\"") == 1,
                "M3 must consume the primary JPEG");
        return LegendaryContainerIntegrityBridge.finish(output);
    }

    private static String normalizeBasename(String source) {
        String name = source == null ? "" : source;
        int slash = Math.max(name.lastIndexOf('/'), name.lastIndexOf('\\'));
        if (slash >= 0) {
            name = name.substring(slash + 1);
        }
        if (name.endsWith(".tmp")) {
            name = name.substring(0, name.length() - 4);
        }
        String lower = name.toLowerCase(Locale.ROOT);
        if (!lower.endsWith(".jpg") && !lower.endsWith(".jpeg")) {
            name += ".jpg";
        }
        require(name.length() > 4 && name.indexOf('/') < 0
                        && name.indexOf('\\') < 0,
                "invalid M9 basename '" + name + "'");
        return name;
    }

    /**
     * Xiaomi's cloud model consumes BGGR. OnePlus 13 is not one-CFA hardware:
     * main is RGGB while both ultrawide and tele are GBRG. Perform the same
     * semantic two-row remap as the recovered Xiaomi adapter, selected from
     * the physical camera characteristics for this exact frame.
     */
    private static byte[] packToCloudBggr(byte[] source, int black,
            int white, String basename, int sourceCfa) {
        int[] lut = buildTransferLut(black, white);
        int[] phaseMap = phaseMapToBggr(sourceCfa);
        byte[] output = source.clone();
        int activeRowBytes = RAW_WIDTH * 5 / 4;
        for (int row = 0; row < RAW_HEIGHT; row += 2) {
            int top = row * RAW_STRIDE;
            int bottom = top + RAW_STRIDE;
            for (int columnByte = 0; columnByte < activeRowBytes;
                    columnByte += 5) {
                int topOffset = top + columnByte;
                int bottomOffset = bottom + columnByte;
                int top0 = raw10Pixel(source, topOffset, 0);
                int top1 = raw10Pixel(source, topOffset, 1);
                int top2 = raw10Pixel(source, topOffset, 2);
                int top3 = raw10Pixel(source, topOffset, 3);
                int bottom0 = raw10Pixel(source, bottomOffset, 0);
                int bottom1 = raw10Pixel(source, bottomOffset, 1);
                int bottom2 = raw10Pixel(source, bottomOffset, 2);
                int bottom3 = raw10Pixel(source, bottomOffset, 3);
                int[] firstPair = {top0, top1, bottom0, bottom1};
                int[] secondPair = {top2, top3, bottom2, bottom3};
                writeGroup(output, topOffset,
                        lut[firstPair[phaseMap[0]]],
                        lut[firstPair[phaseMap[1]]],
                        lut[secondPair[phaseMap[0]]],
                        lut[secondPair[phaseMap[1]]]);
                writeGroup(output, bottomOffset,
                        lut[firstPair[phaseMap[2]]],
                        lut[firstPair[phaseMap[3]]],
                        lut[secondPair[phaseMap[2]]],
                        lut[secondPair[phaseMap[3]]]);
            }
        }
        rc4XorInPlace(output, basename);
        return output;
    }

    private static int[] phaseMapToBggr(int sourceCfa) {
        // Four 2x2 positions expressed as semantic R/G/G/B indices. These
        // are the exact phase tables used by the recovered Xiaomi adapter.
        final int[][] sourceSemantics = {
                {0, 1, 2, 3}, // Android RGGB
                {1, 0, 3, 2}, // Android GRBG
                {2, 3, 0, 1}, // Android GBRG
                {3, 2, 1, 0}  // Android BGGR
        };
        final int[] targetBggr = {3, 2, 1, 0};
        require(sourceCfa >= 0 && sourceCfa < sourceSemantics.length,
                "unsupported source CFA " + sourceCfa);
        int[] source = sourceSemantics[sourceCfa];
        int[] map = new int[4];
        for (int outputPosition = 0; outputPosition < 4;
                outputPosition++) {
            int semantic = targetBggr[outputPosition];
            int inputPosition = 0;
            while (inputPosition < 4
                    && source[inputPosition] != semantic) {
                inputPosition++;
            }
            require(inputPosition < 4, "invalid CFA semantic map");
            map[outputPosition] = inputPosition;
        }
        return map;
    }

    private static int raw10Pixel(byte[] bytes, int offset, int pixel) {
        int low = bytes[offset + 4] & 0xff;
        return ((bytes[offset + pixel] & 0xff) << 2)
                | ((low >>> (pixel * 2)) & 3);
    }

    private static int[] buildTransferLut(int black, int white) {
        require(black >= 0 && black < white && white <= 1024,
                "invalid RAW10 levels");
        float inverseRange = 1.0f / (white - black);
        float normalizedBlack = black * inverseRange;
        int[] lut = new int[1024];
        for (int value = 0; value < lut.length; value++) {
            float normalized = Math.min(1.0f,
                    Math.max(0.0f,
                            value * inverseRange - normalizedBlack));
            lut[value] = (int) Math.min(1023.0f,
                    Math.max(0.0f,
                            (float) Math.sqrt(normalized) * 1023.0f));
        }
        return lut;
    }

    private static void rc4XorInPlace(byte[] bytes, String basename) {
        byte[] key = (RAW_KEY_PREFIX + basename + RAW_KEY_SUFFIX)
                .getBytes(StandardCharsets.UTF_8);
        int keyLength = Math.min(key.length, 254);
        require(keyLength > 0, "empty RAW RC4 key");
        int[] state = new int[256];
        for (int index = 0; index < state.length; index++) {
            state[index] = index;
        }
        int j = 0;
        for (int index = 0; index < state.length; index++) {
            j = (j + state[index] + (key[index % keyLength] & 0xff)) & 0xff;
            int swap = state[index];
            state[index] = state[j];
            state[j] = swap;
        }
        int i = 0;
        j = 0;
        for (int index = 0; index < bytes.length; index++) {
            i = (i + 1) & 0xff;
            j = (j + state[i]) & 0xff;
            int swap = state[i];
            state[i] = state[j];
            state[j] = swap;
            bytes[index] ^= (byte) state[(state[i] + state[j]) & 0xff];
        }
    }

    private static void writeGroup(byte[] bytes, int offset, int a, int b,
            int c, int d) {
        bytes[offset] = (byte) (a >>> 2);
        bytes[offset + 1] = (byte) (b >>> 2);
        bytes[offset + 2] = (byte) (c >>> 2);
        bytes[offset + 3] = (byte) (d >>> 2);
        bytes[offset + 4] = (byte) ((a & 3) | ((b & 3) << 2)
                | ((c & 3) << 4) | ((d & 3) << 6));
    }

    private static byte[] buildMessage(String basename, Metadata metadata,
            float[] lsc) {
        float[][] reordered = new float[4][221];
        for (int point = 0; point < 221; point++) {
            int source = point * 4;
            // Android LensShadingMap: R, Ge, Go, B. Xiaomi M9Msg fields:
            // Gr, Gb, R, B.
            reordered[0][point] = lsc[source + 1];
            reordered[1][point] = lsc[source + 2];
            reordered[2][point] = lsc[source];
            reordered[3][point] = lsc[source + 3];
            for (int channel = 0; channel < 4; channel++) {
                float value = reordered[channel][point];
                require(Float.isFinite(value) && value > 0.01f
                                && value <= 64.0f,
                        "invalid LSC value " + value);
            }
        }

        ByteArrayOutputStream output = new ByteArrayOutputStream(3900);
        string(output, 1, basename + "\0");
        varintField(output, 2, metadata.sensitivityIso);
        message(output, 3, floatsMessage(metadata.awbR, metadata.awbG,
                metadata.awbB));
        fixed32(output, 4, metadata.adrcGain);
        fixed32(output, 5, metadata.ispGain);
        message(output, 7, rawBoundsMessage(RAW_WIDTH, RAW_HEIGHT));
        if (metadata.sensorMode != 0) {
            varintField(output, 8, metadata.sensorMode);
        }
        fixed32(output, 9, metadata.exposureMs);
        fixed32(output, 10, 1.0f); // Reference package's sensorGain.
        if (metadata.orientation != 0) {
            varintField(output, 11, metadata.orientation);
        }
        varintField(output, 12, 13);
        varintField(output, 13, 17);
        packedFloats(output, 14, reordered[0]);
        packedFloats(output, 15, reordered[1]);
        packedFloats(output, 16, reordered[2]);
        packedFloats(output, 17, reordered[3]);
        packedFloats(output, 18, new float[]{
                1.0f, 0.0f, 0.0f,
                0.0f, 1.0f, 0.0f,
                0.0f, 0.0f, 1.0f
        });
        fixed32(output, 19, metadata.cct);
        varintField(output, 20, metadata.luxIndex);
        varintField(output, 22, RAW_WIDTH);
        varintField(output, 23, RAW_HEIGHT);
        varintField(output, 24, RAW_WIDTH);
        varintField(output, 25, RAW_HEIGHT);
        varintField(output, 27, metadata.sensorType);
        string(output, 28, CLOUD_ALGORITHM_VERSION);
        return output.toByteArray();
    }

    private static byte[] floatsMessage(float... values) {
        ByteArrayOutputStream output = new ByteArrayOutputStream(
                values.length * 5);
        for (int index = 0; index < values.length; index++) {
            fixed32(output, index + 1, values[index]);
        }
        return output.toByteArray();
    }

    private static byte[] rawBoundsMessage(int width, int height) {
        ByteArrayOutputStream output = new ByteArrayOutputStream(10);
        fixed32(output, 3, width);
        fixed32(output, 4, height);
        return output.toByteArray();
    }

    private static void packedFloats(ByteArrayOutputStream output, int field,
            float[] values) {
        ByteBuffer bytes = ByteBuffer.allocate(values.length * 4)
                .order(ByteOrder.LITTLE_ENDIAN);
        for (float value : values) {
            bytes.putFloat(value);
        }
        message(output, field, bytes.array());
    }

    private static void fixed32(ByteArrayOutputStream output, int field,
            float value) {
        writeVarint(output, ((long) field << 3) | 5);
        int bits = Float.floatToRawIntBits(value);
        output.write(bits & 0xff);
        output.write((bits >>> 8) & 0xff);
        output.write((bits >>> 16) & 0xff);
        output.write((bits >>> 24) & 0xff);
    }

    private static void string(ByteArrayOutputStream output, int field,
            String value) {
        message(output, field, value.getBytes(StandardCharsets.UTF_8));
    }

    private static void message(ByteArrayOutputStream output, int field,
            byte[] value) {
        writeVarint(output, ((long) field << 3) | 2);
        writeVarint(output, value.length);
        output.write(value, 0, value.length);
    }

    private static void varintField(ByteArrayOutputStream output, int field,
            long value) {
        writeVarint(output, (long) field << 3);
        writeVarint(output, value);
    }

    private static void writeVarint(ByteArrayOutputStream output, long value) {
        while ((value & ~0x7fL) != 0) {
            output.write(((int) value & 0x7f) | 0x80);
            value >>>= 7;
        }
        output.write((int) value);
    }

    private static byte[] addM9Container(byte[] primary, byte[] raw,
            byte[] metadata, int orientation) {
        Segment xmp = findXmp(primary);
        if (xmp != null && xml(primary, xmp).contains(NS_CONTAINER)) {
            throw new IllegalArgumentException("input already has MiContainer");
        }
        String fragments = m9Fragments(raw.length,
                raw.length + metadata.length, metadata.length, orientation);
        String merged;
        if (xmp == null) {
            merged = "<x:xmpmeta\n"
                    + "  xmlns:x=\"adobe:ns:meta/\"\n"
                    + "  x:xmptk=\"Adobe XMP Core 5.1.2\">\n"
                    + "  <rdf:RDF\n"
                    + "    xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">\n"
                    + fragments
                    + "  </rdf:RDF>\n</x:xmpmeta>";
        } else {
            String original = withoutOwnedCameraXmpMeta(xml(primary, xmp));
            int mergePoint = original.indexOf("    <rdf:Description");
            if (mergePoint < 0) {
                mergePoint = original.indexOf("</rdf:RDF>");
            }
            require(mergePoint >= 0, "XMP has no RDF merge point");
            merged = original.substring(0, mergePoint) + fragments
                    + original.substring(mergePoint);
        }
        byte[] app1 = xmpApp1(merged);
        byte[] primaryWithXmp;
        if (xmp == null) {
            int insertion = metadataInsertion(primary);
            primaryWithXmp = replace(primary, insertion, insertion, app1);
        } else {
            primaryWithXmp = replace(primary, xmp.markerOffset,
                    xmp.markerOffset + xmp.totalLength, app1);
        }
        byte[] output = new byte[primaryWithXmp.length + raw.length
                + metadata.length];
        System.arraycopy(primaryWithXmp, 0, output, 0,
                primaryWithXmp.length);
        System.arraycopy(raw, 0, output, primaryWithXmp.length, raw.length);
        System.arraycopy(metadata, 0, output,
                primaryWithXmp.length + raw.length, metadata.length);
        return output;
    }

    private static byte[] addM3Container(byte[] primary,
            int width, int height) {
        Segment xmp = findXmp(primary);
        if (xmp != null && xml(primary, xmp).contains(NS_CONTAINER)) {
            throw new IllegalArgumentException("input already has MiContainer");
        }
        String madrid = "&lt;madrid_image type=&quot;701&quot; offset=&quot;0&quot;"
                + " length=&quot;0&quot; paddingx=&quot;0&quot; paddingy=&quot;0&quot;"
                + " width=&quot;" + width + "&quot; height=&quot;"
                + height + "&quot; location_enabled=&quot;0&quot;"
                + " time_enabled=&quot;0&quot; dark=&quot;0&quot; /&gt;";
        String fragments = "    <rdf:Description\n"
                + "      rdf:about=\"\"\n"
                + "      xmlns:MiCamera=\"http://ns.xiaomi.com/photos/1.0/camera/\"\n"
                + "      MiCamera:XMPMeta=\"" + madrid + "\"/>\n"
                + "    <rdf:Description\n"
                + "      rdf:about=\"\"\n"
                + "      xmlns:MiContainer=\"" + NS_CONTAINER + "\"\n"
                + "      xmlns:Item=\"" + NS_ITEM + "\"\n"
                + "      MiContainer:Version=\"1.0\">\n"
                + "      <MiContainer:Directory>\n"
                + "        <rdf:Seq>\n"
                + itemXml("Legend.MONOPAN", 0, 0, "image/jpeg",
                        "              Item:Orient=\"0\"\n"
                                + "              Item:width=\"" + width
                                + "\"\n"
                                + "              Item:height=\"" + height
                                + "\"\n"
                                + "              Item:UseMainImage=\"1\"")
                + "        </rdf:Seq>\n"
                + "      </MiContainer:Directory>\n"
                + "    </rdf:Description>\n";
        String merged;
        if (xmp == null) {
            merged = "<x:xmpmeta\n"
                    + "  xmlns:x=\"adobe:ns:meta/\"\n"
                    + "  x:xmptk=\"Adobe XMP Core 5.1.2\">\n"
                    + "  <rdf:RDF\n"
                    + "    xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">\n"
                    + fragments
                    + "  </rdf:RDF>\n</x:xmpmeta>";
        } else {
            String original = withoutOwnedCameraXmpMeta(xml(primary, xmp));
            int mergePoint = original.indexOf("    <rdf:Description");
            if (mergePoint < 0) {
                mergePoint = original.indexOf("</rdf:RDF>");
            }
            require(mergePoint >= 0, "XMP has no RDF merge point");
            merged = original.substring(0, mergePoint) + fragments
                    + original.substring(mergePoint);
        }
        byte[] app1 = xmpApp1(merged);
        if (xmp == null) {
            int insertion = metadataInsertion(primary);
            return replace(primary, insertion, insertion, app1);
        }
        return replace(primary, xmp.markerOffset,
                xmp.markerOffset + xmp.totalLength, app1);
    }

    private static String m9Fragments(int rawLength, int rawOffset,
            int metadataLength, int orientation) {
        String madrid = "&lt;madrid_image type=&quot;701&quot; offset=&quot;0&quot;"
                + " length=&quot;0&quot; paddingx=&quot;0&quot; paddingy=&quot;0&quot;"
                + " width=&quot;4096&quot; height=&quot;3072&quot;"
                + " location_enabled=&quot;0&quot; time_enabled=&quot;0&quot;"
                + " dark=&quot;0&quot; /&gt;";
        return "    <rdf:Description\n"
                + "      rdf:about=\"\"\n"
                + "      xmlns:MiCamera=\"http://ns.xiaomi.com/photos/1.0/camera/\"\n"
                + "      MiCamera:XMPMeta=\"" + madrid + "\"/>\n"
                + "    <rdf:Description\n"
                // OS4's Adobe XMP parser rejects a packet whose top-level
                // rdf:Description nodes describe different subjects.  The
                // OS3 M9 writer used a URI here while MiCamera and the stock
                // packet use the empty subject, which makes OS4 discard the
                // otherwise valid Legend.M9.meta item during integrity
                // admission.  The namespace, not rdf:about, identifies the
                // MiContainer dialect, so keep every description on the same
                // empty subject.
                + "      rdf:about=\"\"\n"
                + "      xmlns:MiContainer=\"" + NS_CONTAINER + "\"\n"
                + "      xmlns:Item=\"" + NS_ITEM + "\"\n"
                + "      MiContainer:Version=\"1.0\">\n"
                + "      <MiContainer:Directory>\n"
                + "        <rdf:Seq>\n"
                + itemXml("Legend.M9", rawLength, rawOffset,
                        "image/mipiraw10",
                        "              Item:Orient=\"" + orientation + "\"\n"
                                + "              Item:width=\"4096\"\n"
                                + "              Item:height=\"3072\"\n"
                                + "              Item:stride=\"5120\"")
                + itemXml("Legend.M9.meta", metadataLength,
                        metadataLength, "meta/protobuf", null)
                + "        </rdf:Seq>\n"
                + "      </MiContainer:Directory>\n"
                + "    </rdf:Description>\n";
    }

    private static String itemXml(String name, int length, int offset,
            String mime, String additional) {
        return "          <rdf:li\n"
                + "            rdf:parseType=\"Resource\">\n"
                + "            <MiContainer:Item\n"
                + "              Item:name=\"" + name + "\"\n"
                + "              Item:length=\"" + length + "\"\n"
                + "              Item:Offset=\"" + offset + "\"\n"
                + "              Item:OffsetType=\"EOF\"\n"
                + "              Item:Mime=\"" + mime + "\""
                + (additional == null ? "/>\n" : "\n" + additional + "/>\n")
                + "          </rdf:li>\n";
    }

    private static String withoutOwnedCameraXmpMeta(String xml) {
        while (true) {
            int property = xml.indexOf("MiCamera:XMPMeta=");
            if (property < 0) {
                return xml;
            }
            int start = xml.lastIndexOf("<rdf:Description", property);
            int tagEnd = xml.indexOf('>', property);
            require(start >= 0 && tagEnd >= 0 && property <= tagEnd,
                    "MiCamera:XMPMeta is not an rdf:Description attribute");
            int end = tagEnd + 1;
            String opening = xml.substring(start, end);
            requireOwnedCameraDescription(opening);
            if (!opening.trim().endsWith("/>")) {
                int closing = xml.indexOf("</rdf:Description>", end);
                require(closing >= 0,
                        "unterminated MiCamera:XMPMeta description");
                require(xml.substring(end, closing).trim().isEmpty(),
                        "MiCamera:XMPMeta description owns child metadata");
                end = closing + "</rdf:Description>".length();
            }
            xml = xml.substring(0, start) + xml.substring(end);
        }
    }

    private static void requireOwnedCameraDescription(String opening) {
        int cursor = "<rdf:Description".length();
        boolean found = false;
        while (cursor < opening.length()) {
            while (cursor < opening.length()
                    && Character.isWhitespace(opening.charAt(cursor))) {
                cursor++;
            }
            if (cursor >= opening.length() || opening.charAt(cursor) == '>'
                    || opening.charAt(cursor) == '/') {
                break;
            }
            int nameEnd = cursor;
            while (nameEnd < opening.length()) {
                char value = opening.charAt(nameEnd);
                if (Character.isWhitespace(value) || value == '='
                        || value == '>' || value == '/') {
                    break;
                }
                nameEnd++;
            }
            String name = opening.substring(cursor, nameEnd);
            cursor = nameEnd;
            while (cursor < opening.length()
                    && Character.isWhitespace(opening.charAt(cursor))) {
                cursor++;
            }
            require(cursor < opening.length() && opening.charAt(cursor) == '=',
                    "malformed MiCamera:XMPMeta attribute");
            cursor++;
            while (cursor < opening.length()
                    && Character.isWhitespace(opening.charAt(cursor))) {
                cursor++;
            }
            require(cursor < opening.length()
                            && (opening.charAt(cursor) == '"'
                            || opening.charAt(cursor) == '\''),
                    "unquoted MiCamera:XMPMeta attribute");
            char quote = opening.charAt(cursor);
            int valueEnd = opening.indexOf(quote, cursor + 1);
            require(valueEnd >= 0,
                    "unterminated MiCamera:XMPMeta attribute");
            if ("MiCamera:XMPMeta".equals(name)) {
                found = true;
            } else {
                require("rdf:about".equals(name) || name.startsWith("xmlns:"),
                        "MiCamera:XMPMeta description owns attribute " + name);
            }
            cursor = valueEnd + 1;
        }
        require(found, "MiCamera:XMPMeta property disappeared");
    }

    private static void verify(byte[] output, int rawLength,
            int metadataLength) {
        requireJpeg(output);
        require(LegendExifTagger.read(output) == 1,
                "M9 EXIF marker missing");
        Segment xmp = findXmp(output);
        require(xmp != null, "M9 XMP missing");
        String text = xml(output, xmp);
        require(count(text, "MiCamera:XMPMeta=") <= 1,
                "M9 must not duplicate native watermark metadata");
        require(count(text, "Item:name=\"Legend.M9\"") == 1
                        && count(text, "Item:name=\"Legend.M9.meta\"") == 1,
                "M9 item set invalid");
        String rawItem = item(text, "Item:name=\"Legend.M9\"");
        String metaItem = item(text, "Item:name=\"Legend.M9.meta\"");
        int rawDeclaredLength = positive(rawItem, "Item:length");
        int rawDeclaredOffset = positive(rawItem, "Item:Offset");
        int metaDeclaredLength = positive(metaItem, "Item:length");
        int metaDeclaredOffset = positive(metaItem, "Item:Offset");
        require(rawDeclaredLength == rawLength
                        && metaDeclaredLength == metadataLength
                        && rawDeclaredOffset == rawLength + metadataLength
                        && metaDeclaredOffset == metadataLength,
                "M9 EOF ranges are inconsistent");
        int rawStart = output.length - rawDeclaredOffset;
        int metaStart = output.length - metaDeclaredOffset;
        require(rawStart > 0 && rawStart + rawLength == metaStart
                        && metaStart + metadataLength == output.length,
                "M9 payloads are not contiguous at EOF");
    }

    private static byte[] xmpApp1(String xml) {
        byte[] body = xml.getBytes(StandardCharsets.UTF_8);
        int contentLength = XMP_HEADER.length + body.length;
        int segmentLength = contentLength + 2;
        require(segmentLength <= 65535, "Legend XMP exceeds APP1 64 KiB");
        ByteArrayOutputStream output = new ByteArrayOutputStream(
                contentLength + 4);
        output.write(0xff);
        output.write(0xe1);
        output.write((segmentLength >>> 8) & 0xff);
        output.write(segmentLength & 0xff);
        output.write(XMP_HEADER, 0, XMP_HEADER.length);
        output.write(body, 0, body.length);
        return output.toByteArray();
    }

    private static Segment findXmp(byte[] jpeg) {
        int offset = 2;
        while (offset + 4 <= jpeg.length) {
            if ((jpeg[offset] & 0xff) != 0xff) {
                offset++;
                continue;
            }
            int marker = jpeg[offset + 1] & 0xff;
            if (marker == 0xda) {
                return null;
            }
            if (marker == 0xd8 || marker == 0xd9 || marker == 0
                    || (marker >= 0xd0 && marker <= 0xd7)) {
                offset += 2;
                continue;
            }
            int length = u16be(jpeg, offset + 2);
            int total = length + 2;
            require(length >= 2 && offset + total <= jpeg.length,
                    "malformed JPEG segment");
            int bodyLength = length - 2;
            if (marker == 0xe1
                    && startsWith(jpeg, offset + 4, bodyLength, XMP_HEADER)) {
                return new Segment(offset, total, offset + 4, bodyLength);
            }
            offset += total;
        }
        return null;
    }

    private static int metadataInsertion(byte[] jpeg) {
        int offset = 2;
        int insertion = 2;
        while (offset + 4 <= jpeg.length) {
            int marker = jpeg[offset + 1] & 0xff;
            if ((jpeg[offset] & 0xff) != 0xff
                    || (marker != 0xe0 && marker != 0xe1)) {
                break;
            }
            insertion = offset + u16be(jpeg, offset + 2) + 2;
            require(insertion <= jpeg.length, "malformed metadata prefix");
            offset = insertion;
        }
        return insertion;
    }

    private static String xml(byte[] jpeg, Segment segment) {
        return new String(jpeg,
                segment.bodyOffset + XMP_HEADER.length,
                segment.bodyLength - XMP_HEADER.length,
                StandardCharsets.UTF_8);
    }

    private static String item(String xml, String needle) {
        int name = xml.indexOf(needle);
        int start = xml.lastIndexOf("<MiContainer:Item", name);
        int end = xml.indexOf("/>", name);
        require(name >= 0 && start >= 0 && end >= 0,
                "missing item " + needle);
        return xml.substring(start, end);
    }

    private static int positive(String text, String attribute) {
        String prefix = attribute + "=\"";
        int start = text.indexOf(prefix);
        int end = start < 0 ? -1
                : text.indexOf('"', start + prefix.length());
        require(start >= 0 && end >= 0, "missing " + attribute);
        int value = Integer.parseInt(text.substring(
                start + prefix.length(), end));
        require(value > 0, "nonpositive " + attribute);
        return value;
    }

    private static int count(String text, String needle) {
        int count = 0;
        int cursor = 0;
        while (true) {
            int found = text.indexOf(needle, cursor);
            if (found < 0) {
                return count;
            }
            count++;
            cursor = found + needle.length();
        }
    }

    private static byte[] replace(byte[] source, int start, int end,
            byte[] replacement) {
        byte[] output = new byte[source.length - (end - start)
                + replacement.length];
        System.arraycopy(source, 0, output, 0, start);
        System.arraycopy(replacement, 0, output, start,
                replacement.length);
        System.arraycopy(source, end, output, start + replacement.length,
                source.length - end);
        return output;
    }

    private static int[] jpegDimensions(byte[] jpeg) {
        if (jpeg == null || jpeg.length < 4
                || (jpeg[0] & 0xff) != 0xff
                || (jpeg[1] & 0xff) != 0xd8) {
            return new int[]{0, 0};
        }
        int offset = 2;
        while (offset + 4 <= jpeg.length) {
            if ((jpeg[offset] & 0xff) != 0xff) {
                offset++;
                continue;
            }
            int marker = jpeg[offset + 1] & 0xff;
            if (marker == 0xd8 || marker == 0xd9 || marker == 0
                    || (marker >= 0xd0 && marker <= 0xd7)) {
                offset += 2;
                continue;
            }
            int length = u16be(jpeg, offset + 2);
            if (length < 2 || offset + length + 2 > jpeg.length) {
                return new int[]{0, 0};
            }
            boolean sof = marker >= 0xc0 && marker <= 0xcf
                    && marker != 0xc4 && marker != 0xc8 && marker != 0xcc;
            if (sof && length >= 7) {
                int height = u16be(jpeg, offset + 5);
                int width = u16be(jpeg, offset + 7);
                return new int[]{width, height};
            }
            if (marker == 0xda) {
                break;
            }
            offset += length + 2;
        }
        return new int[]{0, 0};
    }

    private static boolean startsWith(byte[] source, int offset,
            int available, byte[] prefix) {
        if (available < prefix.length || offset < 0
                || offset + prefix.length > source.length) {
            return false;
        }
        for (int index = 0; index < prefix.length; index++) {
            if (source[offset + index] != prefix[index]) {
                return false;
            }
        }
        return true;
    }

    private static int u16be(byte[] bytes, int offset) {
        return ((bytes[offset] & 0xff) << 8) | (bytes[offset + 1] & 0xff);
    }

    private static boolean positive(float value) {
        return Float.isFinite(value) && value > 0.0f;
    }

    private static void require(boolean condition, String message) {
        if (!condition) {
            throw new IllegalArgumentException(message);
        }
    }

    private static void requireJpeg(byte[] jpeg) {
        require(jpeg != null && jpeg.length >= 4
                        && (jpeg[0] & 0xff) == 0xff
                        && (jpeg[1] & 0xff) == 0xd8,
                "input is not a JPEG");
    }

    private static final class Segment {
        final int markerOffset;
        final int totalLength;
        final int bodyOffset;
        final int bodyLength;

        Segment(int markerOffset, int totalLength, int bodyOffset,
                int bodyLength) {
            this.markerOffset = markerOffset;
            this.totalLength = totalLength;
            this.bodyOffset = bodyOffset;
            this.bodyLength = bodyLength;
        }
    }
}
