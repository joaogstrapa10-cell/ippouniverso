$base = "C:\Users\joaog\ippo-universo\EMPREENDIMENTOS A10"
Add-Type -AssemblyName System.Drawing

function ResizeJpg($src,$dst,$maxW,$quality){
  $img=[System.Drawing.Image]::FromFile($src)
  $w=$img.Width;$h=$img.Height
  if($w -gt $maxW){$nw=$maxW;$nh=[int]([math]::Round($h*$maxW/$w))}else{$nw=$w;$nh=$h}
  $bmp=New-Object System.Drawing.Bitmap($nw,$nh)
  $g=[System.Drawing.Graphics]::FromImage($bmp)
  $g.InterpolationMode=[System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $g.SmoothingMode=[System.Drawing.Drawing2D.SmoothingMode]::HighQuality
  $g.DrawImage($img,0,0,$nw,$nh)
  $enc=[System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders()|Where-Object{$_.MimeType -eq 'image/jpeg'}
  $ep=New-Object System.Drawing.Imaging.EncoderParameters(1)
  $ep.Param[0]=New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality,[long]$quality)
  $bmp.Save($dst,$enc,$ep)
  $g.Dispose();$bmp.Dispose();$img.Dispose()
  "resized: " + (Split-Path $dst -Leaf) + " " + ((Get-Item $dst).Length) + " bytes"
}

ResizeJpg "$base\PatioEstaleiro_CasaMar_real.jpg"   "$base\_navy_mar.jpg"    1600 80
ResizeJpg "$base\PatioEstaleiro_CasaBrisa_real.jpg" "$base\_navy_brisar.jpg" 1600 80
ResizeJpg "$base\PatioEstaleiro_CasaBrisa_foto.jpg" "$base\_navy_brisaf.jpg" 1600 80

[IO.File]::WriteAllText("$base\mar_real.b64",   [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\_navy_mar.jpg")))
[IO.File]::WriteAllText("$base\brisa_real.b64", [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\_navy_brisar.jpg")))
[IO.File]::WriteAllText("$base\brisa_foto.b64", [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\_navy_brisaf.jpg")))
"b64 sizes: " + (Get-Item "$base\mar_real.b64").Length + " / " + (Get-Item "$base\brisa_real.b64").Length + " / " + (Get-Item "$base\brisa_foto.b64").Length
"DONE"
