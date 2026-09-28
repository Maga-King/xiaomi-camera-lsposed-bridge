#include <jni.h>

#include <android/hardware_buffer.h>
#include <android/hardware_buffer_jni.h>
#include <android/log.h>
#include <android/native_window.h>
#include <android/native_window_jni.h>
#include <stdint.h>
#include <string.h>

#include <climits>
#include <cstddef>

namespace {

constexpr const char* kLogTag = "OS4CommonAPS";
constexpr uint16_t kCamera3JpegBlobId = 0x00ff;
constexpr size_t kCamera3JpegBlobSize = 8;

// libnativewindow exports this stable platform entry point, although the NDK
// keeps it out of the public header.  It is required here so the synthetic
// ImageReader frame joins Xiaomi's already-created capture task instead of
// receiving an arbitrary producer timestamp.
extern "C" int ANativeWindow_setBuffersTimestamp(
        ANativeWindow* window, int64_t timestamp);

}  // namespace

extern "C" JNIEXPORT jbyteArray JNICALL
Java_local_mio_os4camerabridge_HookEntry_nativeCopyApsJpegFromHardwareBuffer(
        JNIEnv* env, jclass, jobject hardware_buffer) {
    if (hardware_buffer == nullptr) {
        return nullptr;
    }
    AHardwareBuffer* buffer = AHardwareBuffer_fromHardwareBuffer(
            env, hardware_buffer);
    if (buffer == nullptr) {
        return nullptr;
    }
    AHardwareBuffer_Desc descriptor = {};
    AHardwareBuffer_describe(buffer, &descriptor);
    const uint64_t capacity64 = static_cast<uint64_t>(descriptor.width)
            * descriptor.height * descriptor.layers;
    if (descriptor.format != AHARDWAREBUFFER_FORMAT_BLOB
            || capacity64 < 16
            || capacity64 > 256ULL * 1024ULL * 1024ULL) {
        __android_log_print(ANDROID_LOG_WARN, kLogTag,
                "JPEG BLOB rejected size=%ux%u layers=%u format=%u",
                descriptor.width, descriptor.height, descriptor.layers,
                descriptor.format);
        return nullptr;
    }

    void* address = nullptr;
    const int lock_status = AHardwareBuffer_lock(buffer,
            AHARDWAREBUFFER_USAGE_CPU_READ_RARELY, -1, nullptr, &address);
    if (lock_status != 0 || address == nullptr) {
        __android_log_print(ANDROID_LOG_WARN, kLogTag,
                "JPEG BLOB lock failed status=%d", lock_status);
        return nullptr;
    }

    const auto* bytes = static_cast<const uint8_t*>(address);
    const size_t capacity = static_cast<size_t>(capacity64);
    size_t jpeg_size = 0;
    if (bytes[0] == 0xff && bytes[1] == 0xd8) {
        // camera3_jpeg_blob_t is an aligned uint16 id plus uint32 size.
        // Accept a small allocator tail after the footer as ColorOS does.
        for (size_t padding = 0;
                padding <= 64 && capacity >= 8 + padding; ++padding) {
            const size_t footer = capacity - 8 - padding;
            uint16_t blob_id = 0;
            uint32_t candidate_size = 0;
            memcpy(&blob_id, bytes + footer, sizeof(blob_id));
            memcpy(&candidate_size, bytes + footer + 4,
                    sizeof(candidate_size));
            if (blob_id == 0x00ff && candidate_size >= 4
                    && candidate_size <= footer
                    && bytes[candidate_size - 2] == 0xff
                    && bytes[candidate_size - 1] == 0xd9) {
                jpeg_size = candidate_size;
                break;
            }
        }
        // APS can also return a compact BLOB without camera3 footer.
        if (jpeg_size == 0) {
            for (size_t end = capacity; end >= 2; --end) {
                if (bytes[end - 2] == 0xff
                        && bytes[end - 1] == 0xd9) {
                    jpeg_size = end;
                    break;
                }
            }
        }
    }

    jbyteArray result = nullptr;
    if (jpeg_size != 0 && jpeg_size <= static_cast<size_t>(INT_MAX)) {
        result = env->NewByteArray(static_cast<jsize>(jpeg_size));
        if (result != nullptr) {
            env->SetByteArrayRegion(result, 0,
                    static_cast<jsize>(jpeg_size),
                    reinterpret_cast<const jbyte*>(bytes));
        }
    }
    AHardwareBuffer_unlock(buffer, nullptr);
    __android_log_print(result == nullptr ? ANDROID_LOG_WARN
                                          : ANDROID_LOG_INFO,
            kLogTag, "JPEG BLOB copied jpeg=%zu capacity=%zu format=%u",
            jpeg_size, capacity, descriptor.format);
    return result;
}

extern "C" JNIEXPORT jint JNICALL
Java_local_mio_os4camerabridge_HookEntry_nativeQueueJpegToSurface(
        JNIEnv* env, jclass, jobject surface, jbyteArray jpeg,
        jlong timestamp) {
    if (surface == nullptr || jpeg == nullptr || timestamp <= 0) {
        return -1;
    }
    const jsize jpeg_size = env->GetArrayLength(jpeg);
    if (jpeg_size < 4
            || static_cast<uint64_t>(jpeg_size) + kCamera3JpegBlobSize
            > 256ULL * 1024ULL * 1024ULL) {
        return -2;
    }

    jbyte* jpeg_bytes = env->GetByteArrayElements(jpeg, nullptr);
    if (jpeg_bytes == nullptr) {
        return -3;
    }
    ANativeWindow* window = ANativeWindow_fromSurface(env, surface);
    if (window == nullptr) {
        env->ReleaseByteArrayElements(jpeg, jpeg_bytes, JNI_ABORT);
        return -4;
    }

    const int32_t blob_capacity = static_cast<int32_t>(
            jpeg_size + kCamera3JpegBlobSize);
    int result = ANativeWindow_setBuffersGeometry(window, blob_capacity, 1,
            AHARDWAREBUFFER_FORMAT_BLOB);
    if (result != 0) {
        __android_log_print(ANDROID_LOG_ERROR, kLogTag,
                "JPEG loopback geometry failed status=%d capacity=%d",
                result, blob_capacity);
        ANativeWindow_release(window);
        env->ReleaseByteArrayElements(jpeg, jpeg_bytes, JNI_ABORT);
        return -5;
    }

    ANativeWindow_Buffer buffer = {};
    result = ANativeWindow_lock(window, &buffer, nullptr);
    if (result != 0 || buffer.bits == nullptr) {
        __android_log_print(ANDROID_LOG_ERROR, kLogTag,
                "JPEG loopback lock failed status=%d", result);
        ANativeWindow_release(window);
        env->ReleaseByteArrayElements(jpeg, jpeg_bytes, JNI_ABORT);
        return -6;
    }

    const bool layout_valid = buffer.format == AHARDWAREBUFFER_FORMAT_BLOB
            && buffer.height == 1 && buffer.width >= blob_capacity;
    if (layout_valid) {
        auto* destination = static_cast<uint8_t*>(buffer.bits);
        memcpy(destination, jpeg_bytes, static_cast<size_t>(jpeg_size));

        // ImageReader determines the valid payload length from the aligned
        // camera3_jpeg_blob_t stored at the very end of a BLOB allocation.
        // Write the ABI explicitly instead of leaking padding bytes into Rh.r.
        uint8_t* footer = destination + buffer.width
                - kCamera3JpegBlobSize;
        memset(footer, 0, kCamera3JpegBlobSize);
        const uint32_t jpeg_size_u32 = static_cast<uint32_t>(jpeg_size);
        memcpy(footer, &kCamera3JpegBlobId, sizeof(kCamera3JpegBlobId));
        memcpy(footer + 4, &jpeg_size_u32, sizeof(jpeg_size_u32));
        result = ANativeWindow_setBuffersTimestamp(window,
                static_cast<int64_t>(timestamp));
        if (result != 0) {
            __android_log_print(ANDROID_LOG_ERROR, kLogTag,
                    "JPEG loopback timestamp failed status=%d ts=%lld",
                    result, static_cast<long long>(timestamp));
        }
    } else {
        __android_log_print(ANDROID_LOG_ERROR, kLogTag,
                "JPEG loopback bad BLOB layout=%dx%d stride=%d format=%d need=%d",
                buffer.width, buffer.height, buffer.stride, buffer.format,
                blob_capacity);
        result = -7;
    }

    const int post_result = ANativeWindow_unlockAndPost(window);
    ANativeWindow_release(window);
    env->ReleaseByteArrayElements(jpeg, jpeg_bytes, JNI_ABORT);
    if (result != 0) {
        return result;
    }
    if (post_result != 0) {
        __android_log_print(ANDROID_LOG_ERROR, kLogTag,
                "JPEG loopback post failed status=%d", post_result);
        return -8;
    }
    __android_log_print(ANDROID_LOG_INFO, kLogTag,
            "JPEG loopback queued bytes=%d capacity=%d timestamp=%lld",
            jpeg_size, blob_capacity, static_cast<long long>(timestamp));
    return 0;
}
