param([Parameter(Mandatory=$true)][string]$TargetDirectory)
$ErrorActionPreference='Stop'
$resolved=[IO.Path]::GetFullPath($TargetDirectory)
if($resolved -notmatch '^E:\\MIO\\analysis\\camera_repair_wave_20260908\\native-r[0-9]+\\smali\\local\\mio\\os4camerabridge$'){
    throw 'Only a fresh generated narrow-build directory may be patched'
}
$file=Join-Path $resolved 'LegendM9Container.smali'
$text=[IO.File]::ReadAllText($file).Replace("`r`n","`n")
function Replace-Once([string]$inputText,[string]$old,[string]$new) {
    if(([regex]::Matches($inputText,[regex]::Escape($old))).Count -ne 1){throw 'Exact baseline patch did not match once'}
    return $inputText.Replace($old,$new)
}
$begin=$text.IndexOf('.method static wrap(')
$end=$text.IndexOf('.end method',$begin)
if($begin -lt 0 -or $end -lt $begin){throw 'wrap boundary'}
$method=$text.Substring($begin,$end-$begin)
$method=Replace-Once $method ":goto_0`n    new-instance v3, Ljava/lang/StringBuilder;" @'
:goto_0
    invoke-static {p0}, Llocal/mio/os4camerabridge/LegendaryWatermarkContainer;->primaryGeometryValid([B)Z

    move-result v2

    new-instance v3, Ljava/lang/StringBuilder;
'@
$method=$method.Replace('M9 primary must be 4096x3072 or 3072x4096, got ','M9 primary must retain a native full-size image ROI, got ')
$text=$text.Substring(0,$begin)+$method+$text.Substring($end)
$begin=$text.IndexOf('.method private static verify(')
$end=$text.IndexOf('.end method',$begin)
if($begin -lt 0 -or $end -lt $begin){throw 'verify boundary'}
$method=$text.Substring($begin,$end-$begin)
$method=Replace-Once $method 'if-ne v7, v5, :cond_2' 'if-gt v7, v5, :cond_2'
$method=$method.Replace('M9 must own one Madrid payload','M9 must not duplicate native watermark metadata')
$text=$text.Substring(0,$begin)+$method+$text.Substring($end)
[IO.File]::WriteAllText($file,$text,(New-Object Text.UTF8Encoding($false)))
Write-Output 'Generated exact container patch: native ROI admission + optional single Madrid property; RAW pack/protobuf untouched.'

# Fix only the Legendary save gate, not the shared JPEG checks used by other modes.
$entryFile=Join-Path $resolved 'HookEntry.smali'
$entryText=[IO.File]::ReadAllText($entryFile).Replace("`r`n","`n")
$begin=$entryText.IndexOf('.method private static tagLegendaryStoreTask(')
$end=$entryText.IndexOf('.end method',$begin)
if($begin -lt 0 -or $end -lt $begin){throw 'Legendary store gate boundary'}
$method=$entryText.Substring($begin,$end-$begin)
$method=Replace-Once $method 'invoke-static {v2}, Llocal/mio/os4camerabridge/HookEntry;->isJpeg([B)Z' 'invoke-static {v2}, Llocal/mio/os4camerabridge/LegendaryContainerIntegrity;->hasCompletePrimaryJpeg([B)Z'
$entryText=$entryText.Substring(0,$begin)+$method+$entryText.Substring($end)
[IO.File]::WriteAllText($entryFile,$entryText,(New-Object Text.UTF8Encoding($false)))
Write-Output 'Generated exact Legendary store gate: accept complete primary JPEG with unchanged native watermark tail.'
