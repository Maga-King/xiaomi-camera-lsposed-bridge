// Integer-only replacement for the deployed RGGB packer's pixel loop.
// Java supplies its unchanged 1024-entry transfer table and retains RC4/metadata/calibration ownership.
#include <jni.h>
#include <cstdint>
#include <vector>
#include <new>
static int sample(const uint8_t* data,int p){return (int(data[p])<<2)|((data[4]>>(2*p))&3);}
static void group(uint8_t* d,int a,int b,int c,int e){
    d[0]=a>>2;d[1]=b>>2;d[2]=c>>2;d[3]=e>>2;
    d[4]=(a&3)|((b&3)<<2)|((c&3)<<4)|((e&3)<<6);
}
extern "C" JNIEXPORT jbyteArray JNICALL
Java_local_mio_os4camerabridge_LegendaryRawPackBridge_packPixels(JNIEnv* env,jclass,jbyteArray input,jintArray table){
    constexpr int stride=5120,height=3072,bytes=stride*height;
    if(!input || !table || env->GetArrayLength(input)!=bytes || env->GetArrayLength(table)!=1024)return nullptr;
    jint lut[1024];env->GetIntArrayRegion(table,0,1024,lut);if(env->ExceptionCheck())return nullptr;
    for(int v:lut)if(v<0||v>1023)return nullptr;
    try {
        std::vector<uint8_t> source(bytes),out(bytes);
        env->GetByteArrayRegion(input,0,bytes,reinterpret_cast<jbyte*>(source.data()));
        if(env->ExceptionCheck())return nullptr;
        for(int y=0;y<height;y+=2)for(int x=0;x<stride;x+=5){
            int top=y*stride+x,bottom=top+stride;
            const uint8_t* a=source.data()+top;const uint8_t* b=source.data()+bottom;
            group(out.data()+top,lut[sample(b,1)],lut[sample(b,0)],lut[sample(b,3)],lut[sample(b,2)]);
            group(out.data()+bottom,lut[sample(a,1)],lut[sample(a,0)],lut[sample(a,3)],lut[sample(a,2)]);
        }
        auto result=env->NewByteArray(bytes);
        if(result)env->SetByteArrayRegion(result,0,bytes,reinterpret_cast<jbyte*>(out.data()));
        return result;
    }catch(const std::bad_alloc&){return nullptr;}
}
