package local.mio.os4camerabridge;

/** Admission for a one-shot, same-thread Xiaomi LivePhoto filename handoff. */
public final class LivePhotoCapturePathPolicy {
    private LivePhotoCapturePathPolicy() {}

    public static boolean isNativeLivePath(String path) {
        return path != null && path.matches("/storage/emulated/0/DCIM/Camera/MVIMG_[0-9]{8}_[0-9]{6}(?:_[0-9]+)?\\.jpg");
    }

    public static long dateTakenMillis(String taskDescription) {
        if (taskDescription == null) return -1;
        String marker = ",mDateTakenTime=";
        int begin = taskDescription.indexOf(marker);
        if (begin < 0) return -1;
        begin += marker.length();
        int end = taskDescription.indexOf(',', begin);
        if (end <= begin || end - begin > 16) return -1;
        try { return Long.parseLong(taskDescription.substring(begin, end)); }
        catch (NumberFormatException ignored) { return -1; }
    }

    public static boolean mayTransfer(String path, long ageNanos, long pathWallMillis,
                                      long shotWallMillis, int pathGeneration, int currentGeneration) {
        return isNativeLivePath(path) && ageNanos >= 0 && ageNanos <= 1_000_000_000L
                && pathWallMillis > 0 && shotWallMillis > 0
                && shotWallMillis >= pathWallMillis - 100
                && shotWallMillis <= pathWallMillis + 1000
                && pathGeneration == currentGeneration;
    }
}
