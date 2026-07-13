param(
  [string]$Photo = 'C:\Users\joaog\ippo-universo\capetown\img\cover.jpg',
  [string]$Out   = 'AD_antesdepois'
)
Add-Type -AssemblyName System.Drawing
$dir = 'C:\Users\joaog\ippo-universo\capetown'
$fd  = "$dir\fonts"
function b64($p){ [Convert]::ToBase64String([IO.File]::ReadAllBytes($p)) }
$enc = New-Object System.Text.UTF8Encoding($false)
$chrome = "C:\Program Files\Google\Chrome\Application\chrome.exe"

# --- redimensiona a foto p/ ~1080 de largura (jpeg q88) p/ nao estourar o svg ---
$src = [System.Drawing.Bitmap]::FromFile($Photo)
$tw = 1080
$th = [int]([math]::Round($src.Height * $tw / $src.Width))
$bmp = New-Object System.Drawing.Bitmap $tw, $th
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.InterpolationMode = 'HighQualityBicubic'
$g.PixelOffsetMode = 'HighQuality'
$g.DrawImage($src, 0, 0, $tw, $th)
$g.Dispose(); $src.Dispose()
$tmp = "$dir\_photo_tmp.jpg"
$eps = New-Object System.Drawing.Imaging.EncoderParameters 1
$eps.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality, [long]88)
$codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
$bmp.Save($tmp, $codec, $eps); $bmp.Dispose()
"photo $tw x $th"

# --- injeta fontes + imagem ---
$t = [IO.File]::ReadAllText("$dir\${Out}_src.svg", $enc)
$t = $t.Replace('__FONT_SERIF__',  (b64 "$fd\PlayfairDisplay.ttf"))
$t = $t.Replace('__FONT_BODONI__', (b64 "$fd\BodoniModa.ttf"))
$t = $t.Replace('__FONT_BODONI_IT__', (b64 "$fd\BodoniModa-Italic.ttf"))
$t = $t.Replace('__FONT_REG__',    (b64 "$fd\Poppins-Regular.ttf"))
$t = $t.Replace('__FONT_SEMI__',   (b64 "$fd\Poppins-SemiBold.ttf"))
$t = $t.Replace('__AVATAR__',      (b64 "$dir\_extract\avatar_face.png"))
if(Test-Path "$dir\img\logo_fa_black.png"){ $t = $t.Replace('__LOGO__', (b64 "$dir\img\logo_fa_black.png")) }
$t = $t.Replace('__IMG__',         (b64 $tmp))
[IO.File]::WriteAllText("$dir\$Out.svg", $t, $enc)

# --- render Chrome headless ---
$svgInline = $t -replace '<\?xml[^>]*\?>',''
$html = "<!DOCTYPE html><html><head><meta charset='utf-8'><style>*{margin:0;padding:0}html,body{width:1080px;height:1350px;overflow:hidden}svg{display:block}</style></head><body>$svgInline</body></html>"
[IO.File]::WriteAllText("$dir\_render_ad.html", $html, $enc)
$udd = "$env:TEMP\chrome_ad_$(Get-Random)"
$fileUrl = "file:///" + ($dir -replace '\\','/') + "/_render_ad.html"
$p = Start-Process -FilePath $chrome -ArgumentList @("--headless=new","--disable-gpu","--no-sandbox","--hide-scrollbars","--force-device-scale-factor=1","--window-size=1080,1350","--screenshot=$dir\${Out}_preview.png","--user-data-dir=$udd",$fileUrl) -PassThru -Wait -WindowStyle Hidden
"{0}  exit {1}  svg {2:N0}b  png {3:N0}b" -f $Out,$p.ExitCode,(Get-Item "$dir\$Out.svg").Length,(Get-Item "$dir\${Out}_preview.png" -ErrorAction SilentlyContinue).Length
