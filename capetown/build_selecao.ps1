$ErrorActionPreference="Stop"
$base="C:\Users\joaog\ippo-universo\capetown"
$jk = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\fonts\PlusJakartaSans.ttf"))
$bc = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\fonts\BarlowCondensed-Black.ttf"))

$open = @"
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="1080" height="1350" viewBox="0 0 1080 1350">
<defs>
<style>
@font-face{font-family:'Plus Jakarta Sans';src:url(data:font/ttf;base64,$jk) format('truetype');font-weight:200 800;}
@font-face{font-family:'Barlow Condensed';src:url(data:font/ttf;base64,$bc) format('truetype');font-weight:900;}
text{font-family:'Plus Jakarta Sans',sans-serif;}
</style>
<clipPath id="clip"><rect width="1080" height="1350"/></clipPath>
<linearGradient id="accent" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="#5C3D30"/><stop offset="0.5" stop-color="#8B6355"/><stop offset="1" stop-color="#A8806F"/></linearGradient>
<linearGradient id="bgGrad" x1="0" y1="0" x2="0.3" y2="1"><stop offset="0" stop-color="#5C3D30"/><stop offset="0.5" stop-color="#8B6355"/><stop offset="1" stop-color="#A8806F"/></linearGradient>
<radialGradient id="glow" cx="0.72" cy="0.22" r="0.9"><stop offset="0" stop-color="#8B6355" stop-opacity="0.40"/><stop offset="0.55" stop-color="#5C3D30" stop-opacity="0"/></radialGradient>
<filter id="softShadow" x="-12%" y="-15%" width="124%" height="135%" color-interpolation-filters="sRGB"><feDropShadow dx="0" dy="8" stdDeviation="16" flood-color="#3A2A22" flood-opacity="0.12"/></filter>
</defs>
"@

# ============ SLIDE 1 — CAPA ============
$b1 = @"
<g clip-path="url(#clip)">
  <rect width="1080" height="1350" fill="#1A1210"/>
  <rect width="1080" height="1350" fill="url(#glow)"/>
  <rect width="1080" height="7" fill="url(#accent)"/>
  <text x="56" y="74" font-size="15" font-weight="700" letter-spacing="2.5" fill="#F8F1E9" fill-opacity="0.90">HARMONIZA&#199;&#195;O OROFACIAL</text>
  <text x="1024" y="74" font-size="15" font-weight="700" letter-spacing="2" text-anchor="end" fill="#F8F1E9" fill-opacity="0.50">2026 &#174;</text>

  <text x="56" y="694" font-size="13" font-weight="700" letter-spacing="3" fill="#A8806F">ESPECIAL &#183; COPA 2026</text>
  <text x="56" y="786" font-size="90" font-weight="400" letter-spacing="-2" fill="#FFFFFF">Os rostos da</text>
  <text x="56" y="874" font-size="90" font-weight="400" letter-spacing="-2" fill="#FFFFFF">Sele&#231;&#227;o</text>
  <text x="56" y="962" font-size="90" font-weight="800" letter-spacing="-2" fill="#A8806F">viraram assunto.</text>

  <g font-size="28" font-weight="400" letter-spacing="-0.2" fill="#FFFFFF" fill-opacity="0.55">
    <text x="56" y="1036">O "antes e depois" de Neymar, Vini Jr.,</text>
    <text x="56" y="1076">Raphinha e L&#233;o Pereira virou tema da Copa.</text>
  </g>

  <rect x="56" y="1118" width="392" height="58" rx="29" fill="#241813" stroke="#A8806F" stroke-opacity="0.30" stroke-width="1"/>
  <circle cx="89" cy="1147" r="18" fill="url(#accent)"/>
  <text x="89" y="1154" font-size="16" font-weight="800" text-anchor="middle" fill="#FFFFFF">F</text>
  <text x="120" y="1155" font-size="22" font-weight="700" fill="#FFFFFF">@drafrancinealmeida</text>
  <circle cx="418" cy="1147" r="11" fill="#8B6355"/>
  <text x="418" y="1151" font-size="12" font-weight="700" text-anchor="middle" fill="#FFFFFF">&#10003;</text>

  <rect x="56" y="1316" width="916" height="3" rx="1.5" fill="#FFFFFF" fill-opacity="0.18"/>
  <rect x="56" y="1316" width="183" height="3" rx="1.5" fill="#FFFFFF"/>
  <text x="1024" y="1322" font-size="15" font-weight="600" text-anchor="end" fill="#FFFFFF" fill-opacity="0.50">1/5</text>
</g>
"@

# ============ SLIDE 2 — O FENOMENO ============
$b2 = @"
<g clip-path="url(#clip)">
  <rect width="1080" height="1350" fill="#1A1210"/>
  <rect width="1080" height="7" fill="url(#accent)"/>
  <text x="56" y="52" font-size="14" font-weight="700" letter-spacing="1.5" fill="#FFFFFF" fill-opacity="0.50">HARMONIZA&#199;&#195;O OROFACIAL</text>
  <text x="540" y="52" font-size="14" font-weight="700" letter-spacing="1.5" text-anchor="middle" fill="#FFFFFF" fill-opacity="0.50">@drafrancinealmeida</text>
  <text x="1024" y="52" font-size="14" font-weight="700" letter-spacing="1.5" text-anchor="end" fill="#FFFFFF" fill-opacity="0.50">2026 &#174;</text>

  <text x="56" y="606" font-size="13" font-weight="700" letter-spacing="3" fill="#A8806F">O QUE EST&#193; ROLANDO</text>
  <text x="56" y="694" font-size="58" font-weight="800" letter-spacing="-1.5" fill="#FFFFFF">O "antes e depois"</text>
  <text x="56" y="760" font-size="58" font-weight="800" letter-spacing="-1.5" fill="#FFFFFF">virou <tspan fill="#A8806F">assunto.</tspan></text>

  <g font-size="36" font-weight="400" letter-spacing="-0.2" fill="#FFFFFF" fill-opacity="0.62">
    <text x="56" y="868">&#192;s v&#233;speras da Copa, as redes resgataram fotos</text>
    <text x="56" y="922">antigas dos craques: mand&#237;bulas mais marcadas,</text>
    <text x="56" y="976">queixos projetados, pele mais firme.</text>
    <text x="56" y="1064">Ningu&#233;m confirmou nada &#8212; mas os especialistas</text>
    <text x="56" y="1118">j&#225; sabem o que est&#227;o vendo: <tspan font-weight="700" fill="#FFFFFF">gerenciamento</tspan></text>
    <text x="56" y="1172"><tspan font-weight="700" fill="#FFFFFF">de envelhecimento</tspan> com naturalidade.</text>
  </g>

  <rect x="56" y="1316" width="916" height="3" rx="1.5" fill="#FFFFFF" fill-opacity="0.12"/>
  <rect x="56" y="1316" width="366" height="3" rx="1.5" fill="#FFFFFF"/>
  <text x="1024" y="1322" font-size="15" font-weight="600" text-anchor="end" fill="#FFFFFF" fill-opacity="0.30">2/5</text>
</g>
"@

# ============ SLIDE 3 — OS PROCEDIMENTOS (tabela) ============
$b3 = @"
<g clip-path="url(#clip)">
  <rect width="1080" height="1350" fill="#1A1210"/>
  <rect width="1080" height="7" fill="url(#accent)"/>
  <text x="56" y="52" font-size="14" font-weight="700" letter-spacing="1.5" fill="#FFFFFF" fill-opacity="0.50">HARMONIZA&#199;&#195;O OROFACIAL</text>
  <text x="540" y="52" font-size="14" font-weight="700" letter-spacing="1.5" text-anchor="middle" fill="#FFFFFF" fill-opacity="0.50">@drafrancinealmeida</text>
  <text x="1024" y="52" font-size="14" font-weight="700" letter-spacing="1.5" text-anchor="end" fill="#FFFFFF" fill-opacity="0.50">2026 &#174;</text>

  <text x="56" y="600" font-size="13" font-weight="700" letter-spacing="3" fill="#A8806F">O QUE OS ESPECIALISTAS APONTAM</text>
  <g font-size="38" font-weight="400" letter-spacing="-0.2" fill="#FFFFFF" fill-opacity="0.58">
    <text x="56" y="657">Por tr&#225;s da "naturalidade" h&#225; tr&#234;s</text>
    <text x="56" y="714">procedimentos. E cada um resolve uma coisa.</text>
  </g>

  <line x1="56" y1="954" x2="1024" y2="954" stroke="#FFFFFF" stroke-opacity="0.12" stroke-width="1"/>
  <line x1="56" y1="1092" x2="1024" y2="1092" stroke="#FFFFFF" stroke-opacity="0.12" stroke-width="1"/>
  <g font-size="28" font-weight="500" fill="#FFFFFF" fill-opacity="0.62">
    <text x="56" y="895">Suaviza as linhas da testa e dos olhos</text>
    <text x="56" y="1033">Devolve firmeza e sustenta&#231;&#227;o &#224; pele</text>
    <text x="56" y="1171">Define a mand&#237;bula e projeta o queixo</text>
  </g>
  <g font-family="'Barlow Condensed',sans-serif" font-size="72" font-weight="900" letter-spacing="-2" fill="#A8806F" text-anchor="end">
    <text x="1024" y="903">BOTOX</text><text x="1024" y="1041">COL&#193;GENO</text><text x="1024" y="1179">CONTORNO</text>
  </g>
  <g font-size="16" font-weight="500" fill="#FFFFFF" fill-opacity="0.35" text-anchor="end">
    <text x="1024" y="928">toxina botul&#237;nica</text><text x="1024" y="1066">bioestimulador de col&#225;geno</text><text x="1024" y="1204">preenchimento / &#225;cido hialur&#244;nico</text>
  </g>

  <rect x="56" y="1316" width="916" height="3" rx="1.5" fill="#FFFFFF" fill-opacity="0.12"/>
  <rect x="56" y="1316" width="550" height="3" rx="1.5" fill="#FFFFFF"/>
  <text x="1024" y="1322" font-size="15" font-weight="600" text-anchor="end" fill="#FFFFFF" fill-opacity="0.30">3/5</text>
</g>
"@

# ============ SLIDE 4 — O QUE IMPORTA (gradiente) ============
$b4 = @"
<g clip-path="url(#clip)">
  <rect width="1080" height="1350" fill="url(#bgGrad)"/>
  <text x="1095" y="1300" font-family="'Barlow Condensed',sans-serif" font-size="430" font-weight="900" letter-spacing="-16" text-anchor="end" fill="#FFFFFF" fill-opacity="0.08">04</text>
  <rect width="1080" height="7" fill="#FFFFFF" fill-opacity="0.18"/>
  <text x="56" y="52" font-size="14" font-weight="700" letter-spacing="1.5" fill="#FFFFFF" fill-opacity="0.60">HARMONIZA&#199;&#195;O OROFACIAL</text>
  <text x="540" y="52" font-size="14" font-weight="700" letter-spacing="1.5" text-anchor="middle" fill="#FFFFFF" fill-opacity="0.60">@drafrancinealmeida</text>
  <text x="1024" y="52" font-size="14" font-weight="700" letter-spacing="1.5" text-anchor="end" fill="#FFFFFF" fill-opacity="0.60">2026 &#174;</text>

  <text x="56" y="600" font-size="13" font-weight="700" letter-spacing="3" fill="#FFFFFF" fill-opacity="0.65">O QUE REALMENTE IMPORTA</text>
  <text x="56" y="700" font-size="72" font-weight="800" letter-spacing="-2" fill="#FFFFFF">N&#227;o &#233; virar</text>
  <text x="56" y="776" font-size="72" font-weight="800" letter-spacing="-2" fill="#FFFFFF">outra pessoa.</text>

  <g font-size="32" font-weight="500" letter-spacing="-0.2">
    <text x="56" y="900" fill="#FFFFFF" fill-opacity="0.45">&#8212;</text>
    <text x="100" y="900" fill="#FFFFFF" fill-opacity="0.82">O objetivo n&#227;o &#233; mudar as fei&#231;&#245;es &#8212; &#233;</text>
    <text x="100" y="946" fill="#FFFFFF" fill-opacity="0.82"><tspan font-weight="800" fill="#FFFFFF">gerenciar o tempo</tspan>, n&#227;o apag&#225;-lo.</text>
    <text x="56" y="1042" fill="#FFFFFF" fill-opacity="0.45">&#8212;</text>
    <text x="100" y="1042" fill="#FFFFFF" fill-opacity="0.82"><tspan font-weight="800" fill="#FFFFFF">Naturalidade</tspan> acima de tudo: o bom</text>
    <text x="100" y="1088" fill="#FFFFFF" fill-opacity="0.82">resultado &#233; o que ningu&#233;m percebe.</text>
    <text x="56" y="1184" fill="#FFFFFF" fill-opacity="0.45">&#8212;</text>
    <text x="100" y="1184" fill="#FFFFFF" fill-opacity="0.82">Cuidar do rosto deixou de ser tabu &#8212;</text>
    <text x="100" y="1230" fill="#FFFFFF" fill-opacity="0.82">inclusive <tspan font-weight="800" fill="#FFFFFF">para os homens</tspan>.</text>
  </g>

  <rect x="56" y="1316" width="916" height="3" rx="1.5" fill="#FFFFFF" fill-opacity="0.18"/>
  <rect x="56" y="1316" width="733" height="3" rx="1.5" fill="#FFFFFF" fill-opacity="0.70"/>
  <text x="1024" y="1322" font-size="15" font-weight="600" text-anchor="end" fill="#FFFFFF" fill-opacity="0.40">4/5</text>
</g>
"@

# ============ SLIDE 5 — CTA ============
$b5 = @"
<g clip-path="url(#clip)">
  <rect width="1080" height="1350" fill="#FDF6ED"/>
  <rect width="1080" height="7" fill="url(#accent)"/>
  <text x="56" y="52" font-size="14" font-weight="700" letter-spacing="1.5" fill="#0F0D0C" fill-opacity="0.45">HARMONIZA&#199;&#195;O OROFACIAL</text>
  <text x="540" y="52" font-size="14" font-weight="700" letter-spacing="1.5" text-anchor="middle" fill="#0F0D0C" fill-opacity="0.45">@drafrancinealmeida</text>
  <text x="1024" y="52" font-size="14" font-weight="700" letter-spacing="1.5" text-anchor="end" fill="#0F0D0C" fill-opacity="0.45">2026 &#174;</text>

  <text x="56" y="556" font-size="13" font-weight="700" letter-spacing="3" fill="#8B6355">A SUA VEZ</text>
  <g font-size="36" font-weight="500" letter-spacing="-0.2" fill="#0F0D0C" fill-opacity="0.58">
    <text x="56" y="624">Seu rosto n&#227;o precisa de uma Copa para</text>
    <text x="56" y="678">merecer aten&#231;&#227;o. Precisa de um <tspan font-weight="800" fill="#1A1210">plano</tspan>.</text>
  </g>

  <rect x="56" y="744" width="968" height="300" rx="20" fill="#FFFFFF" stroke="#8B6355" stroke-opacity="0.20" stroke-width="3" filter="url(#softShadow)"/>
  <text x="104" y="818" font-size="20" font-weight="600" letter-spacing="2" fill="#0F0D0C" fill-opacity="0.45">O PRIMEIRO PASSO &#201;</text>
  <text x="104" y="888" font-size="58" font-weight="800" letter-spacing="-1.5" fill="#8B6355">ENTENDER SEU ROSTO</text>
  <g font-size="24" font-weight="500" line-height="1.5" fill="#0F0D0C" fill-opacity="0.55">
    <text x="104" y="952">Uma avalia&#231;&#227;o que desenha o que faz sentido</text>
    <text x="104" y="988">para voc&#234; &#8212; com naturalidade e seguran&#231;a.</text>
  </g>

  <circle cx="76" cy="1116" r="20" fill="url(#accent)"/>
  <text x="76" y="1123" font-size="18" font-weight="800" text-anchor="middle" fill="#FFFFFF">F</text>
  <text x="110" y="1115" font-size="20" font-weight="700" fill="#1A1210">Dra. Francine Almeida</text>
  <text x="110" y="1143" font-size="17" font-weight="500" fill="#0F0D0C" fill-opacity="0.45">Agende sua avalia&#231;&#227;o &#183; @drafrancinealmeida</text>

  <rect x="56" y="1316" width="916" height="3" rx="1.5" fill="#000000" fill-opacity="0.08"/>
  <rect x="56" y="1316" width="916" height="3" rx="1.5" fill="#8B6355"/>
  <text x="1024" y="1322" font-size="15" font-weight="600" text-anchor="end" fill="#000000" fill-opacity="0.30">5/5</text>
</g>
"@

$slides = @{
  "SC_01_capa"        = $b1
  "SC_02_fenomeno"    = $b2
  "SC_03_procedimentos" = $b3
  "SC_04_naturalidade" = $b4
  "SC_05_cta"         = $b5
}
$enc = New-Object System.Text.UTF8Encoding($false)
foreach($k in $slides.Keys){
  $svg = $open + $slides[$k] + "`n</svg>"
  [IO.File]::WriteAllText("$base\$k.svg",$svg,$enc)
  Write-Output "SVG -> $k.svg ($([math]::Round((Get-Item "$base\$k.svg").Length/1KB)) KB)"
}

# ---- render checks (1 chrome call por slide; ignora stderr/exit) ----
$ErrorActionPreference="Continue"
$chrome="C:\Program Files\Google\Chrome\Application\chrome.exe"
foreach($k in $slides.Keys){
  $udd="$env:TEMP\sc_$($k)_$(Get-Random)"
  try{ & $chrome --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 --window-size=1080,1350 --virtual-time-budget=2500 --default-background-color=00000000 --user-data-dir="$udd" --screenshot="$base\${k}_check.png" ("file:///"+("$base\$k.svg" -replace '\\','/')) 2>$null | Out-Null }catch{}
  Start-Sleep -Milliseconds 250
  try{ Remove-Item $udd -Recurse -Force -ErrorAction Stop }catch{}
  Write-Output "check -> ${k}_check.png"
}
Write-Output "DONE"
