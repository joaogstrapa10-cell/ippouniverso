param([string]$Src,[string]$Out,[string]$Preview,[int]$PW=1080,[int]$PH=1350)
Add-Type -AssemblyName System.Drawing
$base = 'C:\Users\joaog\ippo-universo\capetown\solenne_build'

function ResizeJpg($inPath,$outPath,$targetW,$q){
  if(Test-Path $outPath){ return }
  $img=[System.Drawing.Image]::FromFile($inPath)
  $scale=$targetW/$img.Width
  $nw=[int]$targetW; $nh=[int]($img.Height*$scale)
  $bmp=New-Object System.Drawing.Bitmap $nw,$nh
  $g=[System.Drawing.Graphics]::FromImage($bmp)
  $g.InterpolationMode=[System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $g.SmoothingMode=[System.Drawing.Drawing2D.SmoothingMode]::HighQuality
  $g.PixelOffsetMode=[System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
  $g.DrawImage($img,0,0,$nw,$nh)
  $g.Dispose(); $img.Dispose()
  $enc=[System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders()|?{$_.MimeType -eq 'image/jpeg'}
  $ep=New-Object System.Drawing.Imaging.EncoderParameters 1
  $ep.Param[0]=New-Object System.Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality,[long]$q)
  $bmp.Save($outPath,$enc,$ep); $bmp.Dispose()
}

ResizeJpg "$base\solenne.jpg" "$base\solenne_s.jpg" 940 88
ResizeJpg "C:\Users\joaog\Downloads\o-que-fazer-em-3-dias-em-balneario-camboriu-1170x650.jpg" "$base\bc_s.jpg" 980 88

$b64sol = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\solenne_s.jpg"))
$b64bc  = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\bc_s.jpg"))
$b64a10 = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\A10_Logo_carvao.png"))

$t = [IO.File]::ReadAllText($Src)
$t = $t.Replace('__A10__',$b64a10).Replace('__SOLENNE__',$b64sol).Replace('__BC__',$b64bc)
$enc = New-Object System.Text.UTF8Encoding($false)
[IO.File]::WriteAllText($Out,$t,$enc)
"WROTE $Out  (" + [Math]::Round((Get-Item $Out).Length/1KB) + " KB)"

# ---- preview via Chrome ----
$wrap = "$base\_wrap_prev.html"
$svgUri = ($Out -replace '\\','/')
@"
<!doctype html><html><head><meta charset='utf-8'><style>html,body{margin:0;padding:0}img{display:block;width:${PW}px;height:${PH}px}</style></head>
<body><img src='file:///$svgUri'></body></html>
"@ | Set-Content -Encoding UTF8 $wrap
if(Test-Path $Preview){ Remove-Item $Preview -Force }
$udd = "$base\udd_" + (Get-Random)
& "C:\Program Files\Google\Chrome\Application\chrome.exe" --headless --disable-gpu --hide-scrollbars --force-device-scale-factor=1 --default-background-color=00000000 --screenshot="$Preview" --window-size="$PW,$PH" --user-data-dir="$udd" $wrap 2>$null | Out-Null
Start-Sleep -Milliseconds 700
if(Test-Path $Preview){ "PREVIEW " + (Get-Item $Preview).Length + " bytes @ " + (Get-Item $Preview).LastWriteTime.ToString('HH:mm:ss') } else { "PREVIEW FAILED" }
