// Private executable packaged in the module. Never injected into camera/provider/HAL address space.
#include <dlfcn.h>
#include <fcntl.h>
#include <unistd.h>
#include <cerrno>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <cstdint>
#include <cstddef>
#include <vector>
#include <string>
#include <chrono>
#include <cstdarg>
#include <sys/syscall.h>

// Keep dependency diagnostics in this short-lived worker's private log, even on ROMs
// which filter vendor algorithm tags out of logcat. This changes no log policy globally.
extern "C" __attribute__((visibility("default"))) int __android_log_print(int priority,const char* tag,const char* format,...) {
    fprintf(stderr,"NativeDependency[%d] %s: ",priority,tag?tag:"(no tag)");
    va_list args;va_start(args,format);int count=vfprintf(stderr,format,args);va_end(args);
    fputc('\n',stderr);return count;
}

// Existing module libvndksupport is intentionally beauty-only. Do not broaden it in Camera.
// In this executable only, OpenCL's real driver dependency belongs to the device vendor tree.
extern "C" __attribute__((visibility("default"))) void* android_load_sphal_library(const char* name,int flags) {
    if(!name)return nullptr;
    if(strcmp(name,"libgsl.so")==0 || strcmp(name,"libCB.so")==0
            || strcmp(name,"libllvm-qcom.so")==0 || strcmp(name,"libadreno_compiler_cl.so")==0) {
        std::string path=std::string("/vendor/lib64/")+name;
        void* library=dlopen(path.c_str(),flags);
        fprintf(stderr,"LegendWorker vendor GPU dependency %s %s%s\n",name,library?"loaded":"failed: ",library?"":dlerror());
        return library;
    }
    using Loader=void*(*)(const char*,int);
    auto original=reinterpret_cast<Loader>(dlsym(RTLD_NEXT,"android_load_sphal_library"));
    if(!original)fprintf(stderr,"LegendWorker unresolved sphal request: %s\n",name);
    return original?original(name,flags):nullptr;
}
extern "C" __attribute__((visibility("default"))) int android_unload_sphal_library(void* library) {
    return library?dlclose(library):0;
}

// Per-process adapter for the donor's hard-coded flags: matching range, no global vendor files.
// These are NOT the UI Gamma switch. BT.601 range is a buffer contract, not a creative option.
extern "C" __attribute__((visibility("default"))) int access(const char* path, int mode) {
    constexpr const char* prefix="/data/vendor/camera/offlinelog/module256_m9_";
    if(path && strncmp(path,prefix,strlen(prefix))==0) {
        if(strcmp(path+strlen(prefix),"range_fix.flag")==0) {
            fprintf(stdout,"LegendWorker runtime requested range flag: full-range contract selected\n");
            return 0;
        }
        errno=ENOENT; return -1;
    }
    return faccessat(AT_FDCWD,path,mode,0);
}
extern "C" __attribute__((visibility("default"))) int open(const char* path,int flags,...) {
    if(path && strncmp(path,"/data/vendor/camera/offlinelog/",29)==0) { errno=EACCES;return -1; }
    mode_t mode=0;
    if((flags&O_CREAT)==O_CREAT || (flags&O_TMPFILE)==O_TMPFILE) {
        va_list args;va_start(args,flags);mode=va_arg(args,int);va_end(args);
    }
    return syscall(SYS_openat,AT_FDCWD,path,flags,mode);
}
struct DipsInit { int32_t reserved,height,width,stride,trigger,reserved2; const char* assets; const char* parameters; };
struct DipsRun {
    uint8_t *inY,*inUV; uint32_t inYBytes,inUVBytes;
    uint8_t *outY,*outUV; uint32_t outYBytes,outUVBytes;
    const char* name; int32_t orientation,lux; uint32_t cct,reserved;
};
struct MiImage {
    uint32_t format,width,height,planeCount,strides[4],sliceHeights[4],sizes[4];
    uint8_t* planes[4]; int32_t fds[4];
};
static_assert(sizeof(DipsInit)==40 && sizeof(DipsRun)==72 && sizeof(MiImage)==112);
template<class T> static T sym(void* library,const char* name) {
    auto pointer=dlsym(library,name); if(!pointer){fprintf(stderr,"Missing native export %s\n",name);exit(3);}return reinterpret_cast<T>(pointer);
}
int main(int argc,char** argv) {
    if(argc!=8)return 2;
    constexpr int width=4096,height=3072;constexpr size_t yBytes=size_t(width)*height,total=yBytes*3/2;
    int mode=atoi(argv[5]),lux=atoi(argv[6]),cct=atoi(argv[7]);
    if((mode!=1&&mode!=2)||lux<0||cct<1500||cct>20000)return 2;
    std::vector<uint8_t> input(total),output(total,0xa5);
    FILE* file=fopen(argv[3],"rb");if(!file)return 2;
    size_t got=fread(input.data(),1,total,file);int extra=fgetc(file);fclose(file);if(got!=total||extra!=EOF)return 2;
    auto start=std::chrono::steady_clock::now();
    // PhotoAPS has no downstream MIVI LeicaFilter node. Use its donor snapshot table here once.
    // The old user M9 cube is not applied anywhere in this capture route.
    std::string snapshotLut=std::string(argv[2])+"/leica_m9s2_param.bin";
    setenv("M9_LUT_FILE",snapshotLut.c_str(),1);
    setenv("M9_LUT_DISABLE","0",1);
    setenv("M9_MASK_DISABLE","1",1); // Exact r16 no-person-mask contract; segmentation input is not fabricated.
    printf("LegendWorker personMask=disabled; private runtime skips unused EGL initialization and reports mask dimensions 0x0\n");
    fflush(stdout);
    std::string path=std::string(argv[1])+(mode==1?"/libmialgo_m9runtime.so":"/libmialgo_monopan.so");
    void* library=dlopen(path.c_str(),RTLD_NOW|RTLD_LOCAL);
    if(!library){fprintf(stderr,"dlopen: %s\n",dlerror());return 3;}
    int status=-1;
    long long initMs=0,runMs=0,releaseMs=0;
    auto elapsed=[](auto begin){return (long long)std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now()-begin).count();};
    if(mode==1) {
        auto init=sym<int(*)(void**,DipsInit*)>(library,"MialgoAi_DIPS_Init");
        auto run=sym<int(*)(void**,DipsRun*)>(library,"MialgoAi_DIPS_Run");
        auto unit=sym<int(*)(void**)>(library,"MialgoAi_DIPS_Unit");
        void* handle=nullptr;DipsInit setup{0,height,width,width,1,0,argv[2],argv[2]};
        auto initStart=std::chrono::steady_clock::now();
        status=init(&handle,&setup);initMs=elapsed(initStart);if(status||!handle)return 4;
        DipsRun request{input.data(),input.data()+yBytes,uint32_t(yBytes),uint32_t(yBytes/2),
            output.data(),output.data()+yBytes,uint32_t(yBytes),uint32_t(yBytes/2),"legend-local",0,lux,uint32_t(cct),0};
        auto runStart=std::chrono::steady_clock::now();status=run(&handle,&request);runMs=elapsed(runStart);
        auto releaseStart=std::chrono::steady_clock::now();unit(&handle);releaseMs=elapsed(releaseStart);
    } else {
        auto init=sym<void*(*)(void*)>(library,"MonopanInit");
        auto run=sym<int(*)(void*,MiImage*,MiImage*)>(library,"MonopanProcess");
        auto unit=sym<void(*)(void**)>(library,"MonopanDeinit");
        alignas(8) uint8_t params[168]{};uint32_t p0=20,p3=3;float p1=.8f,p2=.3f,p4=.2f;
        memcpy(params,&p0,4);memcpy(params+4,&p1,4);memcpy(params+8,&p2,4);memcpy(params+12,&p3,4);memcpy(params+16,&p4,4);
        auto initStart=std::chrono::steady_clock::now();
        void* handle=init(params);initMs=elapsed(initStart);if(!handle)return 4;
        MiImage src{},dst{};src.format=dst.format=2000;src.width=dst.width=width;src.height=dst.height=height;src.planeCount=dst.planeCount=2;
        for(int p=0;p<4;p++)src.fds[p]=dst.fds[p]=-1;
        for(int p=0;p<2;p++) {
            src.strides[p]=dst.strides[p]=width;src.sliceHeights[p]=dst.sliceHeights[p]=p?height/2:height;
            src.sizes[p]=dst.sizes[p]=p?yBytes/2:yBytes;
            src.planes[p]=input.data()+(p?yBytes:0);dst.planes[p]=output.data()+(p?yBytes:0);
        }
        auto runStart=std::chrono::steady_clock::now();status=run(handle,&src,&dst);runMs=elapsed(runStart);
        auto releaseStart=std::chrono::steady_clock::now();unit(&handle);releaseMs=elapsed(releaseStart);
        memset(output.data()+yBytes,128,yBytes/2);
    }
    size_t changed=0;uint64_t delta=0;
    for(size_t i=0;i<total;i++){int difference=abs(int(output[i])-int(input[i]));changed+=difference!=0;delta+=difference;}
    auto ms=std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now()-start).count();
    printf("LegendWorker mode=%d status=%d changed=%zu/%zu meanAbs=%.5f ms=%lld range=BT601_FULL customB2Y=0 extraAispGamma=not-applicable\n",mode,status,changed,total,double(delta)/total,(long long)ms);
    printf("LegendWorker timing init=%lld run=%lld release=%lld ms; watermark-stage=after-this-worker\n",initMs,runMs,releaseMs);
    fflush(stdout);
    if(status||changed<total/100)return 5;
    int fd=open(argv[4],O_WRONLY|O_TRUNC|O_NOFOLLOW|O_CLOEXEC);if(fd<0)return 6;
    size_t position=0;while(position<total){ssize_t count=write(fd,output.data()+position,total-position);if(count<=0){close(fd);return 6;}position+=size_t(count);}fsync(fd);close(fd);return 0;
}
