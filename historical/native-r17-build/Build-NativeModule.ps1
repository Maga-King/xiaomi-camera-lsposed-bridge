param([string]$Revision='native-r2')
$ErrorActionPreference='Stop'
if($Revision -notmatch '^native-r[0-9]+$'){throw 'Unexpected build name'}
$sourceRoot='E:\MIO\os4_camera_lsp'
$source=Join-Path $sourceRoot 'app\src\main\java\local\mio\os4camerabridge'
$build=Join-Path $PSScriptRoot $Revision
if(Test-Path -LiteralPath $build){throw 'Fresh build directory required'}
$java='E:\MIO\ace3\tools\temurin17\bin'
$sdk='C:\Users\YOUR_USER\AppData\Local\Android\Sdk'
$clang=Join-Path $sdk 'ndk\android-ndk-r28c\toolchains\llvm\prebuilt\windows-x86_64\bin\aarch64-linux-android30-clang++.cmd'
$xposed='C:\Users\YOUR_USER\.gradle\caches\modules-2\files-2.1\de.robv.android.xposed\api\82\35866b507b360d4789ff389ad7386b6e8bbf6cc4\api-82.jar'
$binding='E:\MIO\analysis\xiaomi_module_binding_repair_20260905'
$baseline=Join-Path $PSScriptRoot 'container-r1\camera-legend-container-r1.apk'
$donor='E:\MIO\analysis\leica_r16_full_reverse_20260908\exact\modules\m9-savebridge-7604-portable'
function Run([string]$program,[string[]]$arguments) { & $program @arguments; if($LASTEXITCODE -ne 0){throw "Command failed ($LASTEXITCODE): $program"} }
New-Item -ItemType Directory -Path $build,"$build\classes","$build\dex","$build\overlay","$build\overlay\lib\arm64-v8a","$build\overlay\assets\legendary\models" | Out-Null
Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'container-r1\smali') -Destination "$build\smali" -Recurse
$replace=@('LegendaryPhotoCaptureBridge','LegendaryLocalLookBridge','JpegWatermarkMetadataPolicy','LegendaryContainerIntegrity')
$compile=@('LegendaryPhotoCaptureBridge','LegendaryLocalLookBridge','LegendaryNativeCaptureBridge','LegendaryProcessingProvider','LegendarySettingsActivity','LegendaryBootReceiver','LegendaryPixelCodec','LegendarySensorCalibration','LegendaryCalibrationBridge','PackedRaw10Copy','LegendaryJpegColorMetadata','JpegWatermarkMetadataPolicy','LegendaryContainerIntegrity','LegendaryWatermarkContainer','LegendaryWatermarkBridge','LegendaryWatermarkResources','LegendaryWatermarkUpdateBridge','LegendaryRawPackBridge')
$compile += 'LegendaryRawPackValidation'
$compile += 'RearLivePhotoBridge'
$compile += 'LivePhotoCapturePathPolicy'
$files=@($compile | ForEach-Object {Join-Path $source ($_+'.java')})
$dexkit='E:\MIO\analysis\camera_modes_offline_20260907\dexkit_compat\classes.jar'
$kotlin=@(Get-ChildItem -LiteralPath 'C:\Users\YOUR_USER\.gradle\caches\modules-2\files-2.1\org.jetbrains.kotlin\kotlin-stdlib\2.2.10' -Recurse -Filter 'kotlin-stdlib-2.2.10.jar' -File)
if($kotlin.Count -ne 1){throw 'Kotlin compile classpath is not unique'}
$helperClasspath="$sdk\platforms\android-36\android.jar;$xposed;$dexkit;$($kotlin[0].FullName)"
Run "$java\javac.exe" (@('-encoding','UTF-8','-source','17','-target','17','-cp',$helperClasspath,'-d',"$build\classes")+$files)
Run "$java\jar.exe" @('--create','--file',"$build\helpers.jar",'-C',"$build\classes",'.')
Run "$java\java.exe" @('-cp',"$sdk\build-tools\36.0.0\lib\d8.jar",'com.android.tools.r8.D8','--min-api','30','--lib',"$sdk\platforms\android-36\android.jar",'--classpath',$xposed,'--classpath',$dexkit,'--classpath',$kotlin[0].FullName,'--output',"$build\dex","$build\helpers.jar")
Run "$java\java.exe" @('-jar','E:\MIO\ace3\tools\baksmali-3.0.9-fat-release.jar','d',"$build\dex\classes.dex",'--use-locals','--sequential-labels','-o',"$build\new-smali")
$target=Join-Path $build 'smali\local\mio\os4camerabridge'
foreach($file in (Get-ChildItem -LiteralPath $target -File)) {
    $class=$file.BaseName.Split('$')[0]
    if($replace -contains $class) {
        if(!$file.FullName.StartsWith($build+'\',[StringComparison]::OrdinalIgnoreCase)){throw 'Generated target escaped build'}
        Remove-Item -LiteralPath $file.FullName
    }
}
foreach($file in (Get-ChildItem -LiteralPath "$build\new-smali\local\mio\os4camerabridge" -File)) {
    if($file.BaseName -in @('PackedRaw10Copy','LegendaryJpegColorMetadata')){continue}
    $destination=Join-Path $target $file.Name
    if(Test-Path -LiteralPath $destination){throw "Unexpected existing helper $($file.Name)"}
    Copy-Item -LiteralPath $file.FullName -Destination $destination
}
foreach($patch in (Get-ChildItem -LiteralPath "$PSScriptRoot\native-smali-patches" -Filter '*.smali' -File)) {
    if($patch.Name -notin @('HookEntry$76.smali','LegendM9Container.smali')){throw 'Unknown exact smali patch'}
    Copy-Item -LiteralPath $patch.FullName -Destination (Join-Path $target $patch.Name) -Force
}
& "$PSScriptRoot\Patch-WatermarkContainer.ps1" -TargetDirectory $target
& "$PSScriptRoot\Patch-RemainingModes.ps1" -TargetDirectory $target
Run "$java\java.exe" @('-cp',"$binding\build_tools;E:\MIO\tools\apktool_3.0.3.jar",'AssembleSmali',"$build\smali","$build\overlay\classes4.dex")
$libs=Join-Path $build 'overlay\lib\arm64-v8a'
Run $clang @('-std=c++17','-O3','-shared','-fPIC','-static-libstdc++','-Wl,-z,max-page-size=16384',"$sourceRoot\native\legend_pixel_codec.cpp",'-ljnigraphics','-o',"$libs\liblegend_pixel_codec.so")
Run $clang @('-std=c++17','-O3','-shared','-fPIC','-static-libstdc++','-Wl,-z,max-page-size=16384',"$sourceRoot\native\legend_raw_pack.cpp",'-o',"$libs\liblegend_raw_pack.so")
Run $clang @('-std=c++17','-O2','-fPIE','-pie','-static-libstdc++','-Wl,-z,max-page-size=16384','-Wl,--export-dynamic-symbol=access','-Wl,--export-dynamic-symbol=open','-Wl,--export-dynamic-symbol=__android_log_print','-Wl,--export-dynamic-symbol=android_load_sphal_library','-Wl,--export-dynamic-symbol=android_unload_sphal_library',"$sourceRoot\native\legend_native_worker.cpp",'-ldl','-o',"$libs\liblegend_native_worker.so")
foreach($name in @('libmialgo_m9runtime.so','libQnnHtp.so','libQnnSystem.so','libQnnHtpV79Stub.so')) {
    Copy-Item -LiteralPath "$donor\system\odm\lib64\m9s2qnn\$name" -Destination $libs
}
Run "$java\javac.exe" @('-encoding','UTF-8','-d',"$build\classes","$PSScriptRoot\PatchNativeNoMask.java")
Run "$java\java.exe" @('-cp',"$build\classes",'PatchNativeNoMask',"$libs\libmialgo_m9runtime.so")
Copy-Item -LiteralPath "$donor\system\odm\lib64\m9s2qnn\dsp\libQnnHtpV79Skel.so" -Destination $libs
Copy-Item -LiteralPath "$donor\system\odm\lib64\libmialgo_monopan.so" -Destination $libs
Copy-Item -LiteralPath 'E:\MIO\os3xiaomi15u\odm\lib64\libanc_single_bokeh.so' -Destination $libs
Copy-Item -LiteralPath "$sdk\ndk\android-ndk-r28c\toolchains\llvm\prebuilt\windows-x86_64\sysroot\usr\lib\aarch64-linux-android\libc++_shared.so" -Destination $libs
foreach($name in @('styletrans_low_v81_arch79.bin','styletrans_high_v81_arch79.bin','styletrans_colorfix_v81_arch79.bin')) {
    Copy-Item -LiteralPath "$donor\system\odm\etc\camera\m9s2style\$name" -Destination "$build\overlay\assets\legendary\models"
}
Copy-Item -LiteralPath "$donor\system\odm\etc\camera\leica_m9s2_param.bin" -Destination "$build\overlay\assets\legendary\models"
New-Item -ItemType Directory -Path "$build\overlay\assets\legendary\watermarks" | Out-Null
Copy-Item -LiteralPath "$sourceRoot\app\src\main\assets\legendary\watermarks\leica-135.zip" -Destination "$build\overlay\assets\legendary\watermarks"
Run "$java\java.exe" @('-jar','E:\MIO\tools\apktool_3.0.3.jar','b',"$PSScriptRoot\settings-resources",'-o',"$build\manifest-build.apk")
Add-Type -AssemblyName System.IO.Compression, System.IO.Compression.FileSystem
$zip=[IO.Compression.ZipFile]::OpenRead("$build\manifest-build.apk")
try{[IO.Compression.ZipFileExtensions]::ExtractToFile($zip.GetEntry('AndroidManifest.xml'),"$build\overlay\AndroidManifest.xml",$false)}finally{$zip.Dispose()}
# javac requires the public class filename, preserved in build tools only.
Copy-Item -LiteralPath "$PSScriptRoot\Repack-NativeModule.java" -Destination "$build\RepackNativeModule.java"
Run "$java\javac.exe" @('-encoding','UTF-8','-d',"$build\classes","$build\RepackNativeModule.java")
Run "$java\java.exe" @('-cp',"$build\classes",'RepackNativeModule',$baseline,"$build\overlay","$build\unsigned.apk")
Run "$sdk\build-tools\36.0.0\zipalign.exe" @('-P','16','4',"$build\unsigned.apk","$build\aligned.apk")
Run "$java\java.exe" @('-jar',"$sdk\build-tools\36.0.0\lib\apksigner.jar",'sign','--key','E:\MIO\os4_camera_patch_work_20260814\camera_dpi_patch\keys\testkey.pk8','--cert','E:\MIO\os4_camera_patch_work_20260814\camera_dpi_patch\keys\testkey.x509.pem','--out',"$build\camera-legend-$Revision.apk","$build\aligned.apk")
Run "$java\java.exe" @('-jar',"$sdk\build-tools\36.0.0\lib\apksigner.jar",'verify',"$build\camera-legend-$Revision.apk")
Run "$sdk\build-tools\36.0.0\zipalign.exe" @('-c','-P','16','4',"$build\camera-legend-$Revision.apk")
Run "$java\java.exe" @('-jar','E:\MIO\ace3\tools\baksmali-3.0.9-fat-release.jar','d',"$build\overlay\classes4.dex",'--use-locals','--sequential-labels','-o',"$build\roundtrip")
Get-Item -LiteralPath "$build\camera-legend-$Revision.apk" | Select-Object FullName,Length
