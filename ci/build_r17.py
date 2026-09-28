"""Rebuild exact r17 Smali and our native sources, retain audited proprietary payloads."""
import base64
import json
import os
import platform
import shutil
import subprocess
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MAT = ROOT / '.materials'
BUILD = ROOT / 'build-ci'
OUT = ROOT / 'out'

def run(args, **kw):
    print('执行:', Path(str(args[0])).name, flush=True)
    subprocess.run([str(v) for v in args], check=True, **kw)

def main():
    if BUILD.exists(): raise RuntimeError('请使用新的构建工作区，避免重复 patch')
    BUILD.mkdir(); OUT.mkdir(exist_ok=True)
    classes = BUILD / 'classes'; classes.mkdir()
    sdk = Path(os.environ.get('ANDROID_HOME') or os.environ['ANDROID_SDK_ROOT'])
    host = 'windows-x86_64' if os.name=='nt' else 'linux-x86_64'
    ndk = sdk / 'ndk/28.2.13676358/toolchains/llvm/prebuilt' / host / 'bin'
    compiler = ndk / ('aarch64-linux-android30-clang++' + ('.cmd' if os.name=='nt' else ''))
    bt = sdk / 'build-tools/36.0.0'
    apktool = MAT / 'tools/apktool_3.0.3.jar'
    run(['javac','-encoding','UTF-8','-cp',apktool,'-d',classes,ROOT/'ci/AssembleSmali.java'])
    dex = BUILD / 'classes4.dex'
    run(['java','-cp',str(classes)+os.pathsep+str(apktool),'AssembleSmali',ROOT/'snapshots/native-r17/smali',dex])
    native = BUILD / 'native'; native.mkdir()
    for source, library, options in (
        ('legend_pixel_codec.cpp','liblegend_pixel_codec.so',['-O3','-shared','-fPIC','-ljnigraphics']),
        ('legend_raw_pack.cpp','liblegend_raw_pack.so',['-O3','-shared','-fPIC']),
        ('legend_native_worker.cpp','liblegend_native_worker.so',['-O2','-fPIE','-pie','-ldl'] +
         ['-Wl,--export-dynamic-symbol='+s for s in ('access','open','__android_log_print','android_load_sphal_library','android_unload_sphal_library')]),
    ):
        run([compiler,'-std=c++17','-static-libstdc++','-Wl,-z,max-page-size=16384',
             ROOT/'native'/source,*options,'-o',native/library])
    runtime = native / 'libmialgo_m9runtime.so'
    shutil.copy2(MAT/'donor/libmialgo_m9runtime.so',runtime)
    run(['javac','-encoding','UTF-8','-d',classes,ROOT/'historical/native-r17-build/PatchNativeNoMask.java'])
    run(['java','-cp',classes,'PatchNativeNoMask',runtime])
    replacement = {'classes4.dex':dex, **{'lib/arm64-v8a/'+p.name:p for p in native.iterdir()}}
    baseline = MAT / 'baseline/camera-legend-native-r17.apk'
    unsigned = BUILD / 'unsigned.apk'
    removed = []
    with zipfile.ZipFile(baseline) as original, zipfile.ZipFile(unsigned,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=6) as result:
        names = original.namelist()
        assert len(names)==len(set(names)), '基线存在重复 ZIP entry'
        assert set(replacement)<=set(names), '基线不匹配'
        for entry in original.infolist():
            upper=entry.filename.upper()
            if upper.startswith('META-INF/') and (upper.endswith(('.SF','.RSA','.DSA','.EC')) or upper=='META-INF/MANIFEST.MF'):
                removed.append(entry.filename);continue
            data=replacement[entry.filename].read_bytes() if entry.filename in replacement else original.read(entry)
            method=zipfile.ZIP_STORED if entry.filename=='resources.arsc' or entry.filename.endswith('.so') else entry.compress_type
            result.writestr(entry.filename,data,compress_type=method)
    # Prove none of the models, calibration data or dependencies disappeared during rebuilding.
    with zipfile.ZipFile(baseline) as original, zipfile.ZipFile(unsigned) as built:
        kept=[n for n in original.namelist() if n not in replacement and n not in removed]
        for name in kept:
            if original.read(name)!=built.read(name):raise RuntimeError('非预期修改: '+name)
        required=['assets/legendary/models/'+x for x in ('leica_m9s2_param.bin','styletrans_low_v81_arch79.bin',
                    'styletrans_high_v81_arch79.bin','styletrans_colorfix_v81_arch79.bin')]
        required += ['lib/arm64-v8a/'+x for x in ('libmialgo_monopan.so','libQnnHtp.so','libQnnSystem.so',
                    'libQnnHtpV79Stub.so','libQnnHtpV79Skel.so','libanc_single_bokeh.so','libc++_shared.so')]
        for name in required: assert built.getinfo(name).file_size>0, name
    aligned = BUILD / 'aligned.apk'
    run([bt/('zipalign.exe' if os.name=='nt' else 'zipalign'),'-P','16','4',unsigned,aligned])
    env=dict(os.environ)
    key=BUILD/'actions-signing.p12'
    supplied=env.get('CAMERA_SIGNING_KEYSTORE_B64')
    if supplied:
        if not env.get('CAMERA_SIGNING_PASSWORD'):raise RuntimeError('签名密码 Secret 缺失')
        key.write_bytes(base64.b64decode(supplied,validate=True)); signing='仓库独立 CI 签名（不是旧版私钥）'
    else:
        import secrets
        env['CAMERA_SIGNING_PASSWORD']=secrets.token_urlsafe(30)
        run(['keytool','-genkeypair','-keystore',key,'-storetype','PKCS12','-storepass:env','CAMERA_SIGNING_PASSWORD',
             '-keypass:env','CAMERA_SIGNING_PASSWORD','-alias','camera-actions','-keyalg','RSA','-keysize','3072',
             '-validity','10000','-dname','CN=Camera Research Local Build'],env=env)
        signing='临时本地签名；下次构建若换密钥不能直接覆盖安装'
    output=OUT/'XiaomiCameraLSPosed-native-r17-complete.apk'
    signer=bt/'lib/apksigner.jar'
    try:
        run(['java','-jar',signer,'sign','--ks',key,'--ks-pass','env:CAMERA_SIGNING_PASSWORD',
             '--key-pass','env:CAMERA_SIGNING_PASSWORD','--out',output,aligned],env=env)
    finally:
        key.unlink(missing_ok=True)
    run(['java','-jar',signer,'verify','--verbose',output])
    run([bt/('zipalign.exe' if os.name=='nt' else 'zipalign'),'-c','-P','16','4',output])
    report=dict(version='0.4.92-live-photo-r17',versionCode=202,signing=signing,
                rebuilt=list(replacement),preserved_payload_count=len(kept),
                scope='完整 r17 模块 APK；依赖兼容的小米相机、LSPosed 和设备欧加/高通环境，不是通用 HAL',
                device_test='CI 只验证构建和打包完整性，不代表新的手机实拍验收')
    (OUT/'构建说明.json').write_text(json.dumps(report,ensure_ascii=False,indent=2),encoding='utf8')
    print('已构建完整模块：',output,output.stat().st_size,flush=True)

if __name__=='__main__':main()
