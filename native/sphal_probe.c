#include <dlfcn.h>
#include <stdio.h>

typedef void *(*load_sphal_fn)(const char *name, int flags);
typedef int (*unload_sphal_fn)(void *handle);

int main(void) {
    void *support = dlopen("libvndksupport.so", RTLD_NOW);
    if (support == NULL) {
        fprintf(stderr, "vndksupport: %s\n", dlerror());
        return 2;
    }

    load_sphal_fn load_sphal = (load_sphal_fn)dlsym(
            support, "android_load_sphal_library");
    unload_sphal_fn unload_sphal = (unload_sphal_fn)dlsym(
            support, "android_unload_sphal_library");
    if (load_sphal == NULL || unload_sphal == NULL) {
        fprintf(stderr, "symbols: %s\n", dlerror());
        return 3;
    }

    void *algorithm = load_sphal("/odm/lib64/libFaceBeautyJni.so", RTLD_NOW);
    if (algorithm == NULL) {
        fprintf(stderr, "algorithm: %s\n", dlerror());
        return 4;
    }

    printf("system sphal load succeeded: %p\n", algorithm);
    unload_sphal(algorithm);
    dlclose(support);
    return 0;
}
