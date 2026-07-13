param(
  [int]$IMGOFF = 195   # quanto sobe a foto dentro do card (enquadramento vertical)
)
$ErrorActionPreference = "Stop"
$base = "C:\Users\joaog\ippo-universo\capetown"

# salva a foto do slide 3
if(-not (Test-Path "$base\img\s3face.jpg")){
  Add-Type -AssemblyName System.Drawing
  $src=[System.Drawing.Image]::FromFile("C:\Users\joaog\Downloads\magnific_editorial-beauty-closeup-_iAsuTPQ3uK.png")
  # reduz pra jpg (2880 -> 1200) pra nao pesar
  $w=1200; $h=[int]($src.Height*$w/$src.Width)
  $bm=New-Object System.Drawing.Bitmap($w,$h)
  $g=[System.Drawing.Graphics]::FromImage($bm); $g.InterpolationMode='HighQualityBicubic'
  $g.DrawImage($src,0,0,$w,$h)
  $enc=[System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders()|?{$_.MimeType -eq 'image/jpeg'}
  $p=New-Object System.Drawing.Imaging.EncoderParameters(1)
  $p.Param[0]=New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality,90L)
  $bm.Save("$base\img\s3face.jpg",$enc,$p)
  $g.Dispose();$bm.Dispose();$src.Dispose()
}

$fontB64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\fonts\PlusJakartaSans.ttf"))
$imgB64  = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\img\s3face.jpg"))

# card geometry
$cardX=56; $cardY=458; $cardW=968; $cardH=360
$imgY = $cardY - $IMGOFF   # imagem quadrada escalada p/ largura do card (968x968)

$svg = @"
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="1080" height="1350" viewBox="0 0 1080 1350">
<defs>
<style>
@font-face{font-family:'Plus Jakarta Sans';src:url(data:font/ttf;base64,$fontB64) format('truetype');font-weight:200 800;font-style:normal;}
text{font-family:'Plus Jakarta Sans',sans-serif;}
</style>
<linearGradient id="accent" x1="0" y1="0" x2="1" y2="1">
  <stop offset="0" stop-color="#5C3D30"/><stop offset="0.5" stop-color="#8B6355"/><stop offset="1" stop-color="#A8806F"/>
</linearGradient>
<clipPath id="card"><rect x="$cardX" y="$cardY" width="$cardW" height="$cardH" rx="20"/></clipPath>
<filter id="cardShadow" x="-15%" y="-30%" width="130%" height="170%" color-interpolation-filters="sRGB">
  <feDropShadow dx="0" dy="8" stdDeviation="16" flood-color="#3A2A22" flood-opacity="0.16"/>
</filter>
</defs>

<rect x="0" y="0" width="1080" height="1350" fill="#FDF6ED"/>

<!-- accent bar -->
<rect x="0" y="0" width="1080" height="7" fill="url(#accent)"/>

<!-- HEADER (on-light) -->
<text x="56" y="52" font-size="14" font-weight="700" letter-spacing="1.5" fill="#0F0D0C" fill-opacity="0.45">HARMONIZA&#199;&#195;O OROFACIAL</text>
<text x="540" y="52" font-size="14" font-weight="700" letter-spacing="1.5" text-anchor="middle" fill="#0F0D0C" fill-opacity="0.45">@drafrancinealmeida</text>
<text x="1024" y="52" font-size="14" font-weight="700" letter-spacing="1.5" text-anchor="end" fill="#0F0D0C" fill-opacity="0.45">2026 &#174;</text>

<!-- IMG CARD -->
<rect x="$cardX" y="$cardY" width="$cardW" height="$cardH" rx="20" fill="#EBE0D2" filter="url(#cardShadow)"/>
<g clip-path="url(#card)">
  <image xlink:href="data:image/jpeg;base64,$imgB64" x="$cardX" y="$imgY" width="$cardW" height="$cardW" preserveAspectRatio="xMidYMid slice"/>
</g>

<!-- TAG + BODY -->
<text x="56" y="864" font-size="13" font-weight="700" letter-spacing="3" fill="#8B6355">POR QUE ACONTECE</text>
<g font-size="38" font-weight="400" letter-spacing="-0.2" fill="#0F0D0C" fill-opacity="0.62">
  <text x="56" y="921">O rosto tem coxins de gordura que d&#227;o volume &#224;s</text>
  <text x="56" y="980">bochechas e sustentam a pele por baixo. Quando a</text>
  <text x="56" y="1039">tirzepatida acelera o emagrecimento, essa gordura</text>
  <text x="56" y="1098">some r&#225;pido &#8212; e a pele n&#227;o consegue se retrair na</text>
  <text x="56" y="1157">mesma velocidade. O que sobra &#233; flacidez, sulco</text>
  <text x="56" y="1216">fundo e o contorno da mand&#237;bula que <tspan font-weight="800" fill="#1A1210" fill-opacity="1">desaparece</tspan>.</text>
</g>

<!-- PROGRESS 3/7 -->
<rect x="56" y="1316" width="916" height="3" rx="1.5" fill="#000000" fill-opacity="0.08"/>
<rect x="56" y="1316" width="393" height="3" rx="1.5" fill="#8B6355"/>
<text x="1024" y="1322" font-size="15" font-weight="600" text-anchor="end" fill="#000000" fill-opacity="0.30">3/7</text>
</svg>
"@

$svgPath = "$base\CT_03_acontece.svg"
[IO.File]::WriteAllText($svgPath, $svg, (New-Object System.Text.UTF8Encoding($false)))
Write-Output "SVG -> $svgPath ($([math]::Round((Get-Item $svgPath).Length/1KB)) KB)"

$chrome = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$out = "$base\CT_03_check.png"
if(Test-Path $out){ Remove-Item $out -Force }
$udd = "$env:TEMP\chrome_s3_$(Get-Random)"
& $chrome --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 --window-size=1080,1350 --virtual-time-budget=2500 --default-background-color=00000000 --user-data-dir="$udd" --screenshot="$out" ("file:///" + ($svgPath -replace '\\','/')) 2>$null | Out-Null
Start-Sleep -Milliseconds 300
if(Test-Path $out){ Write-Output "check -> $out" }
try{ Remove-Item $udd -Recurse -Force -ErrorAction Stop }catch{}
