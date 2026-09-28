#define _GNU_SOURCE

#include <android/dlext.h>
#include <android/log.h>
#include <dlfcn.h>
#include <string.h>

void* android_load_sphal_library(const char* name, int flags) {
    if (name == NULL) {
        return NULL;
    }

    const char* basename = strrchr(name, '/');
    basename = basename != NULL ? basename + 1 : name;
    if (strcmp(basename, "libFaceBeautyJni.so") != 0
            && strcmp(basename, "lib2DSlender.so") != 0) {
        __android_log_print(ANDROID_LOG_ERROR, "OS4VndkShim",
                "unsupported sphal request: %s", name);
        return NULL;
    }

    // Both ColorOS libraries are bundled into the module's isolated native
    // namespace. Loading by basename keeps their standard EGL/GLES/bionic
    // dependencies in that same namespace and avoids Android's private linker
    // forwarding stubs.
    void* handle = android_dlopen_ext(basename, flags, NULL);
    if (handle == NULL) {
        __android_log_print(ANDROID_LOG_ERROR, "OS4VndkShim",
                "local load failed for %s: %s", basename,
                dlerror());
    } else {
        __android_log_print(ANDROID_LOG_INFO, "OS4VndkShim",
                "local load ok: %s", basename);
    }
    return handle;
}

int android_unload_sphal_library(void* handle) {
    return handle != NULL ? dlclose(handle) : 0;
}
