#define _GNU_SOURCE

#include <android/dlext.h>
#include <android/log.h>
#include <dlfcn.h>
#include <pthread.h>

extern struct android_namespace_t* __loader_android_get_exported_namespace(
        const char* name) __attribute__((weak));

static pthread_once_t g_once = PTHREAD_ONCE_INIT;
static struct android_namespace_t* g_sphal_namespace;
static const char* g_namespace_name;

static void resolve_platform_vndksupport(void) {
    if (__loader_android_get_exported_namespace == NULL) {
        __android_log_print(ANDROID_LOG_ERROR, "OS4SphalProxy",
                "linker namespace export is unavailable");
        return;
    }
    static const char* candidates[] = {"sphal", "vendor", "vndk"};
    for (unsigned int index = 0;
            index < sizeof(candidates) / sizeof(candidates[0]); index++) {
        struct android_namespace_t* value =
                __loader_android_get_exported_namespace(
                        candidates[index]);
        if (value != NULL) {
            g_sphal_namespace = value;
            g_namespace_name = candidates[index];
            break;
        }
    }
    __android_log_print(g_sphal_namespace != NULL
                    ? ANDROID_LOG_INFO : ANDROID_LOG_ERROR,
            "OS4SphalProxy", "exported namespace %s -> %p",
            g_namespace_name != NULL ? g_namespace_name : "<none>",
            g_sphal_namespace);
}

void* android_load_sphal_library(const char* name, int flags) {
    pthread_once(&g_once, resolve_platform_vndksupport);
    if (g_sphal_namespace == NULL) {
        return NULL;
    }
    android_dlextinfo info = {
            .flags = ANDROID_DLEXT_USE_NAMESPACE,
            .library_namespace = g_sphal_namespace,
    };
    void* handle = android_dlopen_ext(name, flags, &info);
    __android_log_print(handle != NULL
                    ? ANDROID_LOG_INFO : ANDROID_LOG_ERROR,
            "OS4SphalProxy", "system SPHAL load %s -> %p",
            name != NULL ? name : "<null>", handle);
    return handle;
}

int android_unload_sphal_library(void* handle) {
    return handle != NULL ? dlclose(handle) : 0;
}
