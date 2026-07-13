$ErrorActionPreference = "Stop"
$base = "C:\Users\joaog\ippo-universo\capetown"

$fontB64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\fonts\PlusJakartaSans.ttf"))
$imgB64  = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\img\capa_face.jpg"))

$svg = @"
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="1080" height="1350" viewBox="0 0 1080 1350">
<defs>
<style>
@font-face{font-family:'Plus Jakarta Sans';src:url(data:font/ttf;base64,$fontB64) format('truetype');font-weight:200 800;font-style:normal;}
text{font-family:'Plus Jakarta Sans',sans-serif;}
</style>
<clipPath id="clipSlide"><rect x="0" y="0" width="1080" height="1350"/></clipPath>
<linearGradient id="accent" x1="0" y1="0" x2="1" y2="1">
  <stop offset="0" stop-color="#5C3D30"/><stop offset="0.5" stop-color="#8B6355"/><stop offset="1" stop-color="#A8806F"/>
</linearGradient>
<!-- scrim SO na base, pro titulo (sem faixa no topo) -->
<linearGradient id="grad" x1="0" y1="0" x2="0" y2="1">
  <stop offset="0"    stop-color="#1A1210" stop-opacity="0"/>
  <stop offset="0.44" stop-color="#1A1210" stop-opacity="0"/>
  <stop offset="0.53" stop-color="#1A1210" stop-opacity="0.30"/>
  <stop offset="0.63" stop-color="#1A1210" stop-opacity="0.74"/>
  <stop offset="0.72" stop-color="#1A1210" stop-opacity="0.93"/>
  <stop offset="0.82" stop-color="#1A1210" stop-opacity="1"/>
  <stop offset="1"    stop-color="#1A1210" stop-opacity="1"/>
</linearGradient>
<!-- sombra suave da imagem: vinheta cafe, leve, centrada no rosto -->
<radialGradient id="vig" gradientUnits="userSpaceOnUse" cx="540" cy="400" r="780"
  gradientTransform="translate(540 400) scale(1.14 1) translate(-540 -400)">
  <stop offset="0.30" stop-color="#1A1210" stop-opacity="0"/>
  <stop offset="0.68" stop-color="#1A1210" stop-opacity="0.24"/>
  <stop offset="1"    stop-color="#1A1210" stop-opacity="0.54"/>
</radialGradient>
<filter id="badgeShadow" x="-60%" y="-80%" width="220%" height="260%" color-interpolation-filters="sRGB">
  <feDropShadow dx="0" dy="6" stdDeviation="13" flood-color="#1A1210" flood-opacity="0.45"/>
</filter>
<!-- halo cafe sutil pro header ficar legivel sem faixa -->
<filter id="textGlow" x="-40%" y="-130%" width="180%" height="360%" color-interpolation-filters="sRGB">
  <feDropShadow dx="0" dy="0" stdDeviation="5" flood-color="#1A1210" flood-opacity="0.85"/>
</filter>
</defs>

<g clip-path="url(#clipSlide)">
  <rect x="0" y="0" width="1080" height="1350" fill="#1A1210"/>
  <image xlink:href="data:image/jpeg;base64,$imgB64" x="-319" y="0" width="1717" height="959" preserveAspectRatio="xMidYMid slice"/>
  <rect x="0" y="0" width="1080" height="1350" fill="url(#vig)"/>
  <rect x="0" y="0" width="1080" height="1350" fill="url(#grad)"/>

  <!-- HEADER -->
  <text x="52" y="74" font-size="15" font-weight="700" letter-spacing="2.5" fill="#F8F1E9" fill-opacity="0.92" filter="url(#textGlow)">HARMONIZA&#199;&#195;O OROFACIAL</text>
  <text x="1028" y="74" font-size="15" font-weight="700" letter-spacing="2" text-anchor="end" fill="#F8F1E9" fill-opacity="0.55" filter="url(#textGlow)">2026 &#174;</text>

  <!-- BADGE -->
  <g filter="url(#badgeShadow)">
    <rect x="52" y="843" width="352" height="60" rx="30" fill="#1A1210" fill-opacity="0.78"/>
    <circle cx="84" cy="873" r="18" fill="url(#accent)"/>
    <text x="84" y="880" font-size="16" font-weight="800" text-anchor="middle" fill="#FFFFFF">F</text>
    <text x="116" y="881" font-size="22" font-weight="700" fill="#FFFFFF">@drafrancinealmeida</text>
    <circle cx="366" cy="873" r="11" fill="#8B6355"/>
    <text x="366" y="877" font-size="12" font-weight="700" text-anchor="middle" fill="#FFFFFF">&#10003;</text>
  </g>

  <!-- HEADLINE -->
  <text x="50" y="1010" font-size="92" font-weight="400" letter-spacing="-2" fill="#FFFFFF"><tspan>O rosto que </tspan><tspan font-weight="800" fill="#A8806F">derrete</tspan></text>
  <text x="50" y="1107" font-size="92" font-weight="400" letter-spacing="-2" fill="#FFFFFF">enquanto o corpo</text>
  <text x="50" y="1204" font-size="92" font-weight="400" letter-spacing="-2" fill="#FFFFFF">muda</text>

  <!-- PROGRESS -->
  <rect x="56" y="1316" width="916" height="3" rx="1.5" fill="#FFFFFF" fill-opacity="0.18"/>
  <rect x="56" y="1316" width="131" height="3" rx="1.5" fill="#FFFFFF"/>
  <text x="1024" y="1322" font-size="15" font-weight="600" text-anchor="end" fill="#FFFFFF" fill-opacity="0.7">1/7</text>
</g>
</svg>
"@

$svgPath = "$base\CAPA1_capa.svg"
[IO.File]::WriteAllText($svgPath, $svg, (New-Object System.Text.UTF8Encoding($false)))
Write-Output "SVG -> $svgPath  ($([math]::Round((Get-Item $svgPath).Length/1KB)) KB)"

# render check
$chrome = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$out = "$base\CAPA1_svg_check.png"
if(Test-Path $out){ Remove-Item $out -Force }
$udd = "$env:TEMP\chrome_svg_$(Get-Random)"
& $chrome --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 --window-size=1080,1350 --virtual-time-budget=2500 --default-background-color=00000000 --user-data-dir="$udd" --screenshot="$out" ("file:///" + ($svgPath -replace '\\','/')) 2>$null | Out-Null
Start-Sleep -Milliseconds 300
if(Test-Path $out){ Write-Output "check -> $out" }
try{ Remove-Item $udd -Recurse -Force -ErrorAction Stop }catch{}
