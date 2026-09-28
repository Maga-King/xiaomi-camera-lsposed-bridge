param([Parameter(Mandatory=$true)][string]$TargetDirectory)
$ErrorActionPreference='Stop'
$resolved=[IO.Path]::GetFullPath($TargetDirectory)
if($resolved -notmatch '^E:\\MIO\\analysis\\camera_repair_wave_20260908\\native-r[0-9]+\\smali\\local\\mio\\os4camerabridge$'){
    throw 'Only a fresh generated narrow-build directory may be patched'
}
$file=Join-Path $resolved 'HookEntry.smali'
$text=[IO.File]::ReadAllText($file).Replace("`r`n","`n")
$begin=$text.IndexOf('.method private static hookDynamicPhotoPreviewCompletion(')
$end=$text.IndexOf('.end method',$begin)
if($begin -lt 0 -or $end -lt $begin){throw 'Live-photo bootstrap boundary'}
$method=$text.Substring($begin,$end-$begin)
$old='    const-string v0, "s7.f"'
if(([regex]::Matches($method,[regex]::Escape($old))).Count -ne 1){throw 'Exact live-photo bootstrap anchor not unique'}
$new="    invoke-static {p0}, Llocal/mio/os4camerabridge/RearLivePhotoBridge;->install(Ljava/lang/ClassLoader;)V`n`n"+$old
$method=$method.Replace($old,$new)
$text=$text.Substring(0,$begin)+$method+$text.Substring($end)
[IO.File]::WriteAllText($file,$text,(New-Object Text.UTF8Encoding($false)))
Write-Output 'Generated narrow remaining-mode bootstrap: scoped circular-audio helper only.'
