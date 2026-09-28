#include <android/log.h>
#include <dlfcn.h>
#include <jni.h>

extern void* android_load_sphal_library(const char* name, int flags);
extern int android_unload_sphal_library(void* handle);

JNIEXPORT jboolean JNICALL
Java_local_mio_os4camerabridge_target_SphalNamespaceProbe_probe(
        JNIEnv* env, jclass clazz, jstring path) {
    (void) clazz;
    if (path == NULL) {
        return JNI_FALSE;
    }
    const char* value = (*env)->GetStringUTFChars(env, path, NULL);
    if (value == NULL) {
        return JNI_FALSE;
    }
    void* handle = android_load_sphal_library(
            value, RTLD_NOW | RTLD_LOCAL);
    __android_log_print(handle != NULL ? ANDROID_LOG_INFO : ANDROID_LOG_ERROR,
            "OS4SphalProbe", "link-only probe %s -> %p", value, handle);
    (*env)->ReleaseStringUTFChars(env, path, value);
    if (handle != NULL) {
        android_unload_sphal_library(handle);
        return JNI_TRUE;
    }
    return JNI_FALSE;
}
