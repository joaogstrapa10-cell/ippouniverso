param([int]$IMGOFF=20,[int]$CARDY=224,[int]$CARDH=712)
$ErrorActionPreference="Stop"
$base="C:\Users\joaog\ippo-universo\capetown"
if(-not (Test-Path "$base\img\s5assess.jpg")){
  Add-Type -AssemblyName System.Drawing
  $src=[System.Drawing.Image]::FromFile("C:\Users\joaog\Downloads\magnific_editorial-closeup-photogr_Pi1a0PX42C.png")
  $w=1300;$h=[int]($src.Height*$w/$src.Width)
  $bm=New-Object System.Drawing.Bitmap($w,$h);$g=[System.Drawing.Graphics]::FromImage($bm);$g.InterpolationMode='HighQualityBicubic'
  $g.DrawImage($src,0,0,$w,$h)
  $enc=[System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders()|Where-Object{$_.MimeType -eq 'image/jpeg'}
  $p=New-Object System.Drawing.Imaging.EncoderParameters(1);$p.Param[0]=New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality,90L)
  $bm.Save("$base\img\s5assess.jpg",$enc,$p);$g.Dispose();$bm.Dispose();$src.Dispose()
}
$jk = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\fonts\PlusJakartaSans.ttf"))
$img= [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\img\s5assess.jpg"))
$cardX=56;$cardW=968
$imgY=$CARDY-$IMGOFF   # imagem quadrada na largura do card (968x968)

$svg = @"
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="1080" height="1350" viewBox="0 0 1080 1350">
<defs><style>
@font-face{font-family:'Plus Jakarta Sans';src:url(data:font/ttf;base64,$jk) format('truetype');font-weight:200 800;}
text{font-family:'Plus Jakarta Sans',sans-serif;}
</style>
<linearGradient id="accent" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="#5C3D30"/><stop offset="0.5" stop-color="#8B6355"/><stop offset="1" stop-color="#A8806F"/></linearGradient>
<clipPath id="card"><rect x="$cardX" y="$CARDY" width="$cardW" height="$CARDH" rx="20"/></clipPath>
<filter id="cardShadow" x="-12%" y="-15%" width="124%" height="135%" color-interpolation-filters="sRGB"><feDropShadow dx="0" dy="8" stdDeviation="16" flood-color="#3A2A22" flood-opacity="0.16"/></filter>
</defs>
<rect width="1080" height="1350" fill="#FDF6ED"/>
<rect width="1080" height="7" fill="url(#accent)"/>
<text x="56" y="52" font-size="14" font-weight="700" letter-spacing="1.5" fill="#0F0D0C" fill-opacity="0.45">HARMONIZA&#199;&#195;O OROFACIAL</text>
<text x="540" y="52" font-size="14" font-weight="700" letter-spacing="1.5" text-anchor="middle" fill="#0F0D0C" fill-opacity="0.45">@drafrancinealmeida</text>
<text x="1024" y="52" font-size="14" font-weight="700" letter-spacing="1.5" text-anchor="end" fill="#0F0D0C" fill-opacity="0.45">2026 &#174;</text>
<rect x="$cardX" y="$CARDY" width="$cardW" height="$CARDH" rx="20" fill="#EBE0D2" filter="url(#cardShadow)"/>
<g clip-path="url(#card)">
  <image xlink:href="data:image/jpeg;base64,$img" x="$cardX" y="$imgY" width="$cardW" height="$cardW" preserveAspectRatio="xMidYMid slice"/>
</g>
<text x="56" y="982" font-size="13" font-weight="700" letter-spacing="3" fill="#8B6355">O QUE OS ESPECIALISTAS VEEM</text>
<g font-size="38" font-weight="400" letter-spacing="-0.2" fill="#0F0D0C" fill-opacity="0.62">
  <text x="56" y="1039">Profissionais j&#225; relatam a queda de col&#225;geno e a "face</text>
  <text x="56" y="1098">que despenca" antes mesmo de a paciente perceber</text>
  <text x="56" y="1157">a flacidez. A gordura que ningu&#233;m queria no corpo era</text>
  <text x="56" y="1216">exatamente a que segurava a <tspan font-weight="800" fill="#1A1210" fill-opacity="1">jovialidade do rosto</tspan>.</text>
</g>
<rect x="56" y="1316" width="916" height="3" rx="1.5" fill="#000000" fill-opacity="0.08"/>
<rect x="56" y="1316" width="654" height="3" rx="1.5" fill="#8B6355"/>
<text x="1024" y="1322" font-size="15" font-weight="600" text-anchor="end" fill="#000000" fill-opacity="0.30">5/7</text>
</svg>
"@
[IO.File]::WriteAllText("$base\CT_05_especialistas.svg",$svg,(New-Object System.Text.UTF8Encoding($false)))
Write-Output "CT_05 com foto (CARDY=$CARDY CARDH=$CARDH IMGOFF=$IMGOFF)"
$chrome="C:\Program Files\Google\Chrome\Application\chrome.exe";$udd="$env:TEMP\c5_$(Get-Random)"
& $chrome --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 --window-size=1080,1350 --virtual-time-budget=2500 --default-background-color=00000000 --user-data-dir="$udd" --screenshot="$base\CT_05_check.png" ("file:///"+("$base\CT_05_especialistas.svg" -replace '\\','/')) 2>$null | Out-Null
Start-Sleep -Milliseconds 300; try{Remove-Item $udd -Recurse -Force -ErrorAction Stop}catch{}
Write-Output "check ok"
