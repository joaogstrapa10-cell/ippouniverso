param(
  [int]$PW = 2160, [int]$PX = -540, [int]$PY = -90
)
$ErrorActionPreference = "Stop"
$base = "C:\Users\joaog\ippo-universo\capetown"
$PH = [int]($PW * 1333 / 2000)

$fontB64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\fonts\PlusJakartaSans.ttf"))
$imgB64  = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\img\inject.jpg"))

$svg = @"
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="1080" height="1350" viewBox="0 0 1080 1350">
<defs>
<style>
@font-face{font-family:'Plus Jakarta Sans';src:url(data:font/ttf;base64,$fontB64) format('truetype');font-weight:200 800;font-style:normal;}
text{font-family:'Plus Jakarta Sans',sans-serif;}
</style>
<clipPath id="clip"><rect x="0" y="0" width="1080" height="1350"/></clipPath>
<linearGradient id="accent" x1="0" y1="0" x2="1" y2="1">
  <stop offset="0" stop-color="#5C3D30"/><stop offset="0.5" stop-color="#8B6355"/><stop offset="1" stop-color="#A8806F"/>
</linearGradient>
<!-- overlay escuro do design (slide-img-overlay) + reforco na base pro texto -->
<linearGradient id="ovl" x1="0" y1="0" x2="0" y2="1">
  <stop offset="0"    stop-color="#1A1210" stop-opacity="0.86"/>
  <stop offset="0.26" stop-color="#1A1210" stop-opacity="0.76"/>
  <stop offset="0.46" stop-color="#1A1210" stop-opacity="0.66"/>
  <stop offset="0.64" stop-color="#1A1210" stop-opacity="0.82"/>
  <stop offset="0.82" stop-color="#1A1210" stop-opacity="0.94"/>
  <stop offset="1"    stop-color="#1A1210" stop-opacity="0.99"/>
</linearGradient>
</defs>

<g clip-path="url(#clip)">
  <rect x="0" y="0" width="1080" height="1350" fill="#1A1210"/>
  <image xlink:href="data:image/jpeg;base64,$imgB64" x="$PX" y="$PY" width="$PW" height="$PH" preserveAspectRatio="xMidYMid slice"/>
  <rect x="0" y="0" width="1080" height="1350" fill="url(#ovl)"/>

  <!-- accent bar -->
  <rect x="0" y="0" width="1080" height="7" fill="url(#accent)"/>

  <!-- HEADER (on-dark) -->
  <text x="56" y="52" font-size="14" font-weight="700" letter-spacing="1.5" fill="#FFFFFF" fill-opacity="0.50">HARMONIZA&#199;&#195;O OROFACIAL</text>
  <text x="540" y="52" font-size="14" font-weight="700" letter-spacing="1.5" text-anchor="middle" fill="#FFFFFF" fill-opacity="0.50">@drafrancinealmeida</text>
  <text x="1024" y="52" font-size="14" font-weight="700" letter-spacing="1.5" text-anchor="end" fill="#FFFFFF" fill-opacity="0.50">2026 &#174;</text>

  <!-- CONTENT -->
  <text x="56" y="912" font-size="13" font-weight="700" letter-spacing="3" fill="#A8806F">O FEN&#212;MENO</text>
  <g font-size="38" font-weight="400" letter-spacing="-0.2" fill="#FFFFFF" fill-opacity="0.58">
    <text x="56" y="986">O Mounjaro virou a coisa mais procurada do Brasil para</text>
    <text x="56" y="1043">emagrecer, porque a perda de peso chega perto da</text>
    <text x="56" y="1100">de uma cirurgia bari&#225;trica. S&#243; que tem um detalhe que</text>
    <text x="56" y="1157">ningu&#233;m conta antes da primeira aplica&#231;&#227;o: junto com</text>
    <text x="56" y="1214">o corpo, o <tspan font-weight="700" fill="#FFFFFF" fill-opacity="1">rosto vai junto</tspan>.</text>
  </g>

  <!-- PROGRESS 2/7 -->
  <rect x="56" y="1316" width="916" height="3" rx="1.5" fill="#FFFFFF" fill-opacity="0.12"/>
  <rect x="56" y="1316" width="262" height="3" rx="1.5" fill="#FFFFFF"/>
  <text x="1024" y="1322" font-size="15" font-weight="600" text-anchor="end" fill="#FFFFFF" fill-opacity="0.30">2/7</text>
</g>
</svg>
"@

$svgPath = "$base\CT_02_fenomeno.svg"
[IO.File]::WriteAllText($svgPath, $svg, (New-Object System.Text.UTF8Encoding($false)))
Write-Output "SVG -> $svgPath ($([math]::Round((Get-Item $svgPath).Length/1KB)) KB)"

$chrome = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$out = "$base\CT_02_check.png"
if(Test-Path $out){ Remove-Item $out -Force }
$udd = "$env:TEMP\chrome_s2_$(Get-Random)"
& $chrome --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 --window-size=1080,1350 --virtual-time-budget=2500 --default-background-color=00000000 --user-data-dir="$udd" --screenshot="$out" ("file:///" + ($svgPath -replace '\\','/')) 2>$null | Out-Null
Start-Sleep -Milliseconds 300
if(Test-Path $out){ Write-Output "check -> $out" }
try{ Remove-Item $udd -Recurse -Force -ErrorAction Stop }catch{}
