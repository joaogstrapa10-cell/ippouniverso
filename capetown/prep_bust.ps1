$ErrorActionPreference="Stop"
Add-Type -AssemblyName System.Drawing
$base="C:\Users\joaog\ippo-universo\capetown"
$src=[System.Drawing.Image]::FromFile("$base\_paste\paste_3.jpg")
$sw=$src.Width; $sh=$src.Height
Write-Output "source = ${sw}x${sh}"

$ratio=1080.0/1350.0
$cropH=$sh
$cropW=[int]($cropH*$ratio)
if($cropW -gt $sw){ $cropW=$sw; $cropH=[int]($cropW/$ratio) }
$cropX=[int](($sw-$cropW)*0.50)
$cropY=0
Write-Output "crop = ${cropW}x${cropH} @ ($cropX,$cropY)"

$W=1080; $H=1350
$bm=New-Object System.Drawing.Bitmap($W,$H)
$g=[System.Drawing.Graphics]::FromImage($bm)
$g.InterpolationMode='HighQualityBicubic'; $g.SmoothingMode='HighQuality'; $g.PixelOffsetMode='HighQuality'
$g.DrawImage($src,(New-Object System.Drawing.Rectangle(0,0,$W,$H)),$cropX,$cropY,$cropW,$cropH,[System.Drawing.GraphicsUnit]::Pixel)
$g.Dispose()
$encj=[System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders()|Where-Object{$_.MimeType -eq 'image/jpeg'}
$p=New-Object System.Drawing.Imaging.EncoderParameters(1)
$p.Param[0]=New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality,90L)
$bm.Save("$base\img\bust_s6.jpg",$encj,$p)
$bm.Dispose(); $src.Dispose()
Write-Output "OK -> img\bust_s6.jpg"