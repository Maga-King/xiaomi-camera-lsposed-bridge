$ErrorActionPreference = "Stop"

$workspace = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$ndkRoot = Join-Path $workspace "tools\android-ndk\android-ndk-r27d"
$clang = Join-Path $ndkRoot `
    "toolchains\llvm\prebuilt\windows-x86_64\bin\aarch64-linux-android30-clang++.cmd"
$source = Join-Path $PSScriptRoot "aps_jpeg_copy.cpp"
$output = Join-Path (Split-Path -Parent $PSScriptRoot) `
    "app\src\main\jniLibs\arm64-v8a\libos4apsjpeg.so"

if (-not (Test-Path -LiteralPath $clang)) {
    throw "Android NDK compiler missing: $clang"
}

& $clang -shared -fPIC -O2 -std=c++17 -nostdlib++ `
    -Wall -Wextra -Werror `
    $source -o $output `
    -landroid -lnativewindow -llog `
    "-Wl,-soname,libos4apsjpeg.so"
if ($LASTEXITCODE -ne 0) {
    throw "native compiler failed with exit code $LASTEXITCODE"
}

Get-Item -LiteralPath $output
