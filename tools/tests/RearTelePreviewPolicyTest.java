import local.mio.os4camerabridge.RearTelePreviewPolicy;

public final class RearTelePreviewPolicyTest {
    private static int checks;
    private static void check(boolean value) {
        checks++;
        if (!value) throw new AssertionError("Check " + checks);
    }
    public static void main(String[] args) {
        check(RearTelePreviewPolicy.eligible(163, 0, true, false, true, 3));
        check(RearTelePreviewPolicy.eligible(163, 0, true, false, true, 20));
        for (float zoom : new float[]{0.6f, 1, 2, 2.999f, 20.1f, Float.NaN,
                Float.POSITIVE_INFINITY, Float.NEGATIVE_INFINITY})
            check(!RearTelePreviewPolicy.eligible(163, 0, true, false, true, zoom));
        for (int module : new int[]{-1, 162, 167, 171, 256})
            check(!RearTelePreviewPolicy.eligible(module, 0, true, false, true, 3));
        for (int camera : new int[]{-1, 1, 2, 3, 4})
            check(!RearTelePreviewPolicy.eligible(163, camera, true, false, true, 3));
        check(!RearTelePreviewPolicy.eligible(163, 0, false, false, true, 3));
        check(!RearTelePreviewPolicy.eligible(163, 0, true, true, true, 3));
        check(!RearTelePreviewPolicy.eligible(163, 0, true, false, false, 3));
        check(RearTelePreviewPolicy.mask(null)[0] == 2);
        check(RearTelePreviewPolicy.mask(new int[]{0})[0] == 2);
        check(RearTelePreviewPolicy.mask(new int[]{2})[0] == 2);
        int[] original = {4};
        check(RearTelePreviewPolicy.mask(original)[0] == 6 && original[0] == 4);
        check(RearTelePreviewPolicy.mask(new int[0]) == null);
        check(RearTelePreviewPolicy.mask(new int[]{0, 2}) == null);
        check(RearTelePreviewPolicy.mask(new int[]{-1}) == null);
        System.out.println("PASS " + checks + " rear tele preview policy checks");
    }
}
