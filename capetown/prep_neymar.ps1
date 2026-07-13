$ErrorActionPreference="Stop"
Add-Type -AssemblyName System.Drawing
$base="C:\Users\joaog\ippo-universo\capetown"
$src=[System.Drawing.Image]::FromFile("$base\_paste\paste_2.jpg")
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

# leve dessat (s=0.92) — a foto ja esta no tom, so unifica
$s=0.92; $a=1-$s; $lr=0.3086; $lg=0.6094; $lb=0.0820
$cm=New-Object System.Drawing.Imaging.ColorMatrix
$cm.Matrix00=$s+$a*$lr; $cm.Matrix01=$a*$lr;    $cm.Matrix02=$a*$lr
$cm.Matrix10=$a*$lg;    $cm.Matrix11=$s+$a*$lg; $cm.Matrix12=$a*$lg
$cm.Matrix20=$a*$lb;    $cm.Matrix21=$a*$lb;    $cm.Matrix22=$s+$a*$lb
$cm.Matrix33=1; $cm.Matrix44=1
$ia=New-Object System.Drawing.Imaging.ImageAttributes; $ia.SetColorMatrix($cm)
$dest=New-Object System.Drawing.Rectangle(0,0,$W,$H)
$g.DrawImage($src,$dest,$cropX,$cropY,$cropW,$cropH,[System.Drawing.GraphicsUnit]::Pixel,$ia)

$g.Dispose()
$encj=[System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders()|Where-Object{$_.MimeType -eq 'image/jpeg'}
$p=New-Object System.Drawing.Imaging.EncoderParameters(1)
$p.Param[0]=New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality,90L)
$bm.Save("$base\img\neymar_s2.jpg",$encj,$p)
$bm.Dispose(); $src.Dispose()
Write-Output "OK -> img\neymar_s2.jpg"