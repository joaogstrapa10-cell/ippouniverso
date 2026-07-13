$ErrorActionPreference="Stop"
$base="C:\Users\joaog\ippo-universo\capetown"
$jk  = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\fonts\PlusJakartaSans.ttf"))
$bcB = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\fonts\BarlowCondensed-Black.ttf"))

$fonts = @"
@font-face{font-family:'Plus Jakarta Sans';src:url(data:font/ttf;base64,$jk) format('truetype');font-weight:200 800;}
@font-face{font-family:'Barlow Condensed';src:url(data:font/ttf;base64,$bcB) format('truetype');font-weight:900;}
text{font-family:'Plus Jakarta Sans',sans-serif;}
"@

# ===================== SLIDE 4 =====================
$svg4 = @"
<svg xmlns="http://www.w3.org/2000/svg" width="1080" height="1350" viewBox="0 0 1080 1350">
<defs><style>$fonts</style>
<linearGradient id="accent" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="#5C3D30"/><stop offset="0.5" stop-color="#8B6355"/><stop offset="1" stop-color="#A8806F"/></linearGradient>
<radialGradient id="vig4" gradientUnits="userSpaceOnUse" cx="540" cy="470" r="780" gradientTransform="translate(540 470) scale(1.15 1) translate(-540 -470)">
  <stop offset="0.35" stop-color="#000000" stop-opacity="0"/><stop offset="1" stop-color="#000000" stop-opacity="0.30"/></radialGradient>
</defs>
<rect x="0" y="0" width="1080" height="1350" fill="#1A1210"/>
<rect x="0" y="0" width="1080" height="1350" fill="url(#vig4)"/>
<rect x="0" y="0" width="1080" height="7" fill="url(#accent)"/>
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
  <text x="1024" y="903">57%</text>
  <text x="1024" y="1041">+20%</text>
  <text x="1024" y="1179">2025</text>
</g>
<g font-size="16" font-weight="500" fill="#FFFFFF" fill-opacity="0.35" text-anchor="end">
  <text x="1024" y="928">Vigitel, 2023</text>
  <text x="1024" y="1066">do peso corporal</text>
  <text x="1024" y="1204">registro Anvisa</text>
</g>
<rect x="56" y="1316" width="916" height="3" rx="1.5" fill="#FFFFFF" fill-opacity="0.12"/>
<rect x="56" y="1316" width="523" height="3" rx="1.5" fill="#FFFFFF"/>
<text x="1024" y="1322" font-size="15" font-weight="600" text-anchor="end" fill="#FFFFFF" fill-opacity="0.30">4/7</text>
</svg>
"@
[IO.File]::WriteAllText("$base\CT_04_numeros.svg", $svg4, (New-Object System.Text.UTF8Encoding($false)))

# ===================== SLIDE 6 =====================
$svg6 = @"
<svg xmlns="http://www.w3.org/2000/svg" width="1080" height="1350" viewBox="0 0 1080 1350">
<defs><style>$fonts</style>
<linearGradient id="bg6" x1="0.371" y1="0.017" x2="0.629" y2="0.983"><stop offset="0" stop-color="#5C3D30"/><stop offset="0.5" stop-color="#8B6355"/><stop offset="1" stop-color="#A8806F"/></linearGradient>
</defs>
<rect x="0" y="0" width="1080" height="1350" fill="url(#bg6)"/>
<text x="1098" y="1300" font-family="'Barlow Condensed',sans-serif" font-size="420" font-weight="900" letter-spacing="-16" text-anchor="end" fill="#FFFFFF" fill-opacity="0.07">06</text>
<rect x="0" y="0" width="1080" height="7" fill="#FFFFFF" fill-opacity="0.18"/>
<text x="56" y="52" font-size="14" font-weight="700" letter-spacing="1.5" fill="#FFFFFF" fill-opacity="0.60">HARMONIZA&#199;&#195;O OROFACIAL</text>
<text x="540" y="52" font-size="14" font-weight="700" letter-spacing="1.5" text-anchor="middle" fill="#FFFFFF" fill-opacity="0.60">@drafrancinealmeida</text>
<text x="1024" y="52" font-size="14" font-weight="700" letter-spacing="1.5" text-anchor="end" fill="#FFFFFF" fill-opacity="0.60">2026 &#174;</text>
<text x="56" y="638" font-size="13" font-weight="700" letter-spacing="3" fill="#FFFFFF" fill-opacity="0.65">A ORDEM CERTA</text>
<g font-size="72" font-weight="800" letter-spacing="-2" fill="#FFFFFF">
  <text x="56" y="733">Antes. Durante.</text>
  <text x="56" y="809">N&#227;o depois.</text>
</g>
<g font-size="34" fill="#FFFFFF" fill-opacity="0.5">
  <text x="56" y="900">&#8594;</text><text x="56" y="1022">&#8594;</text><text x="56" y="1145">&#8594;</text>
</g>
<g font-size="32" font-weight="500" letter-spacing="-0.2" fill="#FFFFFF" fill-opacity="0.78">
  <text x="108" y="900">A harmoniza&#231;&#227;o rep&#245;e o que o emagrecimento tirou:</text>
  <text x="108" y="946" font-weight="800" fill="#FFFFFF" fill-opacity="1">col&#225;geno e volume</text>
  <text x="108" y="1022">Bioestimulador devolve sustenta&#231;&#227;o. Preenchimento</text>
  <text x="108" y="1069">recupera as regi&#245;es malar e mandibular</text>
  <text x="108" y="1145">A janela &#233; curta &#8212; depois que as fibras el&#225;sticas rompem, a</text>
  <text x="108" y="1192">corre&#231;&#227;o fica <tspan font-weight="800" fill-opacity="1">mais complexa e cara</tspan></text>
</g>
<rect x="56" y="1316" width="916" height="3" rx="1.5" fill="#FFFFFF" fill-opacity="0.18"/>
<rect x="56" y="1316" width="785" height="3" rx="1.5" fill="#A8806F"/>
<text x="1024" y="1322" font-size="15" font-weight="600" text-anchor="end" fill="#FFFFFF" fill-opacity="0.40">6/7</text>
</svg>
"@
[IO.File]::WriteAllText("$base\CT_06_ordem.svg", $svg6, (New-Object System.Text.UTF8Encoding($false)))

Write-Output "SVGs gerados: CT_04_numeros.svg, CT_06_ordem.svg"

# render checks
$chrome="C:\Program Files\Google\Chrome\Application\chrome.exe"
foreach($s in @("04_numeros","06_ordem")){
  $svgp="$base\CT_$s.svg"; $out="$base\CT_$($s.Substring(0,2))_check.png"
  if(Test-Path $out){Remove-Item $out -Force}
  $udd="$env:TEMP\chrome_$($s)_$(Get-Random)"
  & $chrome --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 --window-size=1080,1350 --virtual-time-budget=2500 --default-background-color=00000000 --user-data-dir="$udd" --screenshot="$out" ("file:///"+($svgp -replace '\\','/')) 2>$null | Out-Null
  Start-Sleep -Milliseconds 250
  try{Remove-Item $udd -Recurse -Force -ErrorAction Stop}catch{}
}
Write-Output "checks renderizados"
