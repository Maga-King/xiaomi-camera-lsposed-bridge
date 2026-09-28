#include <jni.h>
#include <android/bitmap.h>
#include <cstdint>
#include <vector>
#include <algorithm>

static uint8_t clip(int v) { return uint8_t(std::min(255, std::max(0, v))); }
static uint8_t* pixel(uint8_t* base, const AndroidBitmapInfo& info, bool portrait, int x, int y) {
    // Canonical = portrait rotated -90 degrees. Reverse mapping restores precisely the same orientation.
    int sx = portrait ? 3071-y : x, sy = portrait ? x : y;
    return base + size_t(sy)*info.stride + size_t(sx)*4;
}
static bool valid(const AndroidBitmapInfo& i, bool p) {
    return i.format == ANDROID_BITMAP_FORMAT_RGBA_8888 && i.width == (p?3072:4096) && i.height == (p?4096:3072);
}
extern "C" JNIEXPORT jbyteArray JNICALL
Java_local_mio_os4camerabridge_LegendaryPixelCodec_toNv12(JNIEnv* env, jclass, jobject bitmap, jboolean portrait) {
    AndroidBitmapInfo info{}; void* data=nullptr;
    if(AndroidBitmap_getInfo(env,bitmap,&info)||!valid(info,portrait)||AndroidBitmap_lockPixels(env,bitmap,&data)) return nullptr;
    constexpr int w=4096,h=3072; constexpr size_t ySize=size_t(w)*h;
    std::vector<uint8_t> out(ySize*3/2);
    for(int y=0;y<h;y+=2) for(int x=0;x<w;x+=2) {
        int r=0,g=0,b=0;
        for(int dy=0;dy<2;dy++) for(int dx=0;dx<2;dx++) {
            auto p=pixel(static_cast<uint8_t*>(data),info,portrait,x+dx,y+dy);
            out[size_t(y+dy)*w+x+dx]=clip((77*p[0]+150*p[1]+29*p[2]+128)>>8);
            r+=p[0];g+=p[1];b+=p[2];
        }
        size_t offset=ySize+size_t(y/2)*w+x;
        out[offset]=clip(128+((-43*r-85*g+128*b+512)>>10));
        out[offset+1]=clip(128+((128*r-107*g-21*b+512)>>10));
    }
    AndroidBitmap_unlockPixels(env,bitmap);
    auto result=env->NewByteArray(out.size());
    if(result) env->SetByteArrayRegion(result,0,out.size(),reinterpret_cast<jbyte*>(out.data()));
    return result;
}
extern "C" JNIEXPORT jboolean JNICALL
Java_local_mio_os4camerabridge_LegendaryPixelCodec_fromNv12(JNIEnv* env, jclass, jobject bitmap, jboolean portrait, jbyteArray buffer) {
    constexpr int w=4096,h=3072; constexpr size_t ySize=size_t(w)*h;
    AndroidBitmapInfo info{}; void* data=nullptr;
    if(!buffer||env->GetArrayLength(buffer)!=ySize*3/2||AndroidBitmap_getInfo(env,bitmap,&info)||!valid(info,portrait)) return false;
    std::vector<uint8_t> input(ySize*3/2);
    env->GetByteArrayRegion(buffer,0,input.size(),reinterpret_cast<jbyte*>(input.data()));
    if(env->ExceptionCheck()||AndroidBitmap_lockPixels(env,bitmap,&data)) return false;
    for(int y=0;y<h;y++) for(int x=0;x<w;x++) {
        int l=input[size_t(y)*w+x]; size_t uv=ySize+size_t(y/2)*w+(x&~1);
        int u=int(input[uv])-128,v=int(input[uv+1])-128;
        auto p=pixel(static_cast<uint8_t*>(data),info,portrait,x,y);
        p[0]=clip(l+((359*v+128)>>8));
        p[1]=clip(l+((-88*u-183*v+128)>>8));
        p[2]=clip(l+((454*u+128)>>8));p[3]=255;
    }
    AndroidBitmap_unlockPixels(env,bitmap);return true;
}
