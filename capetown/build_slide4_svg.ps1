param([int]$PW=1700,[int]$PX=-310,[int]$PY=-535)
$ErrorActionPreference="Stop"
$base="C:\Users\joaog\ippo-universo\capetown"

if(-not (Test-Path "$base\img\pen.jpg")){
  Add-Type -AssemblyName System.Drawing
  $src=[System.Drawing.Image]::FromFile("C:\Users\joaog\Downloads\magnific_cinematic-closeup-of-a-sl_l7uX7etgv9.png")
  $w=1400;$h=[int]($src.Height*$w/$src.Width)
  $bm=New-Object System.Drawing.Bitmap($w,$h);$g=[System.Drawing.Graphics]::FromImage($bm);$g.InterpolationMode='HighQualityBicubic'
  $g.DrawImage($src,0,0,$w,$h)
  $enc=[System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders()|?{$_.MimeType -eq 'image/jpeg'}
  $p=New-Object System.Drawing.Imaging.EncoderParameters(1);$p.Param[0]=New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality,90L)
  $bm.Save("$base\img\pen.jpg",$enc,$p);$g.Dispose();$bm.Dispose();$src.Dispose()
}
$PH=[int]($PW*1)  # imagem quadrada
$jk = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\fonts\PlusJakartaSans.ttf"))
$bcB= [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\fonts\BarlowCondensed-Black.ttf"))
$img= [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\img\pen.jpg"))

$svg = @"
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="1080" height="1350" viewBox="0 0 1080 1350">
<defs><style>
@font-face{font-family:'Plus Jakarta Sans';src:url(data:font/ttf;base64,$jk) format('truetype');font-weight:200 800;}
@font-face{font-family:'Barlow Condensed';src:url(data:font/ttf;base64,$bcB) format('truetype');font-weight:900;}
text{font-family:'Plus Jakarta Sans',sans-serif;}
</style>
<clipPath id="clip"><rect width="1080" height="1350"/></clipPath>
<linearGradient id="accent" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="#5C3D30"/><stop offset="0.5" stop-color="#8B6355"/><stop offset="1" stop-color="#A8806F"/></linearGradient>
<linearGradient id="ovl" x1="0" y1="0" x2="0" y2="1">
  <stop offset="0"    stop-color="#1A1210" stop-opacity="0.60"/>
  <stop offset="0.12" stop-color="#1A1210" stop-opacity="0.42"/>
  <stop offset="0.28" stop-color="#1A1210" stop-opacity="0.34"/>
  <stop offset="0.42" stop-color="#1A1210" stop-opacity="0.52"/>
  <stop offset="0.50" stop-color="#1A1210" stop-opacity="0.74"/>
  <stop offset="0.58" stop-color="#1A1210" stop-opacity="0.88"/>
  <stop offset="0.70" stop-color="#1A1210" stop-opacity="0.94"/>
  <stop offset="1"    stop-color="#1A1210" stop-opacity="0.97"/>
</linearGradient>
</defs>
<g clip-path="url(#clip)">
  <rect width="1080" height="1350" fill="#1A1210"/>
  <image xlink:href="data:image/jpeg;base64,$img" x="$PX" y="$PY" width="$PW" height="$PH" preserveAspectRatio="xMidYMid slice"/>
  <rect width="1080" height="1350" fill="url(#ovl)"/>
  <rect width="1080" height="7" fill="url(#accent)"/>
  <text x="56" y="52" font-size="14" font-weight="700" letter-spacing="1.5" fill="#FFFFFF" fill-opacity="0.50">HARMONIZA&#199;&#195;O OROFACIAL</text>
  <text x="540" y="52" font-size="14" font-weight="700" letter-spacing="1.5" text-anchor="middle" fill="#FFFFFF" fill-opacity="0.50">@drafrancinealmeida</text>
  <text x="1024" y="52" font-size="14" font-weight="700" letter-spacing="1.5" text-anchor="end" fill="#FFFFFF" fill-opacity="0.50">2026 &#174;</text>
  <text x="56" y="600" font-size="13" font-weight="700" letter-spacing="3" fill="#A8806F">OS N&#218;MEROS</text>
  <g font-size="38" font-weight="400" letter-spacing="-0.2" fill="#FFFFFF" fill-opacity="0.58">
    <text x="56" y="657">N&#227;o &#233; caso isolado. &#201; um fen&#244;meno que est&#225;</text>
    <text x="56" y="714">chegando junto com a populariza&#231;&#227;o da caneta no</text>
    <text x="56" y="771">Brasil inteiro.</text>
  </g>
  <line x1="56" y1="954" x2="1024" y2="954" stroke="#FFFFFF" stroke-opacity="0.12" stroke-width="1"/>
  <line x1="56" y1="1092" x2="1024" y2="1092" stroke="#FFFFFF" stroke-opacity="0.12" stroke-width="1"/>
  <g font-size="28" font-weight="500" fill="#FFFFFF" fill-opacity="0.62">
    <text x="56" y="895">Adultos brasileiros com excesso de peso</text>
    <text x="56" y="1033">Perda de peso com tirzepatida</text>
    <text x="56" y="1171">Chegada oficial do Mounjaro ao Brasil</text>
  </g>
  <g font-family="'Barlow Condensed',sans-serif" font-size="72" font-weight="900" letter-spacing="-2" fill="#A8806F" text-anchor="end">
    <text x="1024" y="903">57%</text><text x="1024" y="1041">+20%</text><text x="1024" y="1179">2025</text>
  </g>
  <g font-size="16" font-weight="500" fill="#FFFFFF" fill-opacity="0.35" text-anchor="end">
    <text x="1024" y="928">Vigitel, 2023</text><text x="1024" y="1066">do peso corporal</text><text x="1024" y="1204">registro Anvisa</text>
  </g>
  <rect x="56" y="1316" width="916" height="3" rx="1.5" fill="#FFFFFF" fill-opacity="0.12"/>
  <rect x="56" y="1316" width="523" height="3" rx="1.5" fill="#FFFFFF"/>
  <text x="1024" y="1322" font-size="15" font-weight="600" text-anchor="end" fill="#FFFFFF" fill-opacity="0.30">4/7</text>
</g>
</svg>
"@
[IO.File]::WriteAllText("$base\CT_04_numeros.svg",$svg,(New-Object System.Text.UTF8Encoding($false)))
Write-Output "CT_04 reconstruido com a caneta (PW=$PW PX=$PX PY=$PY)"
$chrome="C:\Program Files\Google\Chrome\Application\chrome.exe";$udd="$env:TEMP\c4_$(Get-Random)"
& $chrome --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 --window-size=1080,1350 --virtual-time-budget=2500 --default-background-color=00000000 --user-data-dir="$udd" --screenshot="$base\CT_04_check.png" ("file:///"+("$base\CT_04_numeros.svg" -replace '\\','/')) 2>$null | Out-Null
Start-Sleep -Milliseconds 300; try{Remove-Item $udd -Recurse -Force -ErrorAction Stop}catch{}
Write-Output "check ok"
