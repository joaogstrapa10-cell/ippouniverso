$ErrorActionPreference="Stop"
$base="C:\Users\joaog\ippo-universo\capetown"
$jk = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\fonts\PlusJakartaSans.ttf"))
$bc = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\fonts\BarlowCondensed-Black.ttf"))
$cov = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\img\cover_players.jpg"))
$ney = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\img\neymar_s2.jpg"))
$bust = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\img\bust_s6.jpg"))

$open = @"
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="1080" height="1350" viewBox="0 0 1080 1350">
<defs>
<style>
@font-face{font-family:'Plus Jakarta Sans';src:url(data:font/ttf;base64,$jk) format('truetype');font-weight:200 800;}
@font-face{font-family:'Barlow Condensed';src:url(data:font/ttf;base64,$bc) format('truetype');font-weight:900;}
text{font-family:'Plus Jakarta Sans',sans-serif;}
.disp{font-family:'Barlow Condensed',sans-serif;font-weight:900;}
</style>
<clipPath id="clip"><rect width="1080" height="1350"/></clipPath>
<linearGradient id="accent" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="#5C3D30"/><stop offset="0.5" stop-color="#8B6355"/><stop offset="1" stop-color="#A8806F"/></linearGradient>
<linearGradient id="bgGrad" x1="0" y1="0" x2="0.3" y2="1"><stop offset="0" stop-color="#5C3D30"/><stop offset="0.5" stop-color="#8B6355"/><stop offset="1" stop-color="#A8806F"/></linearGradient>
</defs>
"@

# ============ SLIDE 1 — CAPA (foto dos jogadores) ============
$b1 = @"
<g clip-path="url(#clip)">
  <defs>
    <linearGradient id="capTop" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0" stop-color="#1A1210" stop-opacity="0.62"/>
      <stop offset="0.14" stop-color="#1A1210" stop-opacity="0"/>
    </linearGradient>
    <linearGradient id="capBot" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0" stop-color="#1A1210" stop-opacity="0"/>
      <stop offset="0.46" stop-color="#1A1210" stop-opacity="0"/>
      <stop offset="0.58" stop-color="#1A1210" stop-opacity="0.45"/>
      <stop offset="0.68" stop-color="#1A1210" stop-opacity="0.85"/>
      <stop offset="0.75" stop-color="#1A1210" stop-opacity="0.97"/>
      <stop offset="1" stop-color="#1A1210" stop-opacity="1"/>
    </linearGradient>
    <radialGradient id="capVig" gradientUnits="userSpaceOnUse" cx="540" cy="450" r="800" gradientTransform="translate(540 450) scale(1.12 1) translate(-540 -450)">
      <stop offset="0.32" stop-color="#1A1210" stop-opacity="0"/>
      <stop offset="0.72" stop-color="#1A1210" stop-opacity="0.20"/>
      <stop offset="1" stop-color="#1A1210" stop-opacity="0.48"/>
    </radialGradient>
  </defs>
  <rect width="1080" height="1350" fill="#1A1210"/>
  <image xlink:href="data:image/jpeg;base64,$cov" x="0" y="0" width="1080" height="1350" preserveAspectRatio="xMidYMid slice"/>
  <rect width="1080" height="1350" fill="url(#capVig)"/>
  <rect width="1080" height="1350" fill="url(#capTop)"/>
  <rect width="1080" height="1350" fill="url(#capBot)"/>

  <rect x="80" y="74" width="48" height="4" fill="#A8806F"/>
  <text x="80" y="116" font-size="20" font-weight="700" letter-spacing="3" fill="#F8F1E9" fill-opacity="0.92">HARMONIZA&#199;&#195;O MASCULINA &#183; COPA 2026</text>

  <g class="disp" letter-spacing="1.5">
    <text x="78" y="1018" font-size="78" fill="#FDF6ED">OS ROSTOS DA</text>
    <text x="78" y="1096" font-size="78" fill="#FDF6ED">SELE&#199;&#195;O VIROU</text>
    <text x="78" y="1174" font-size="78" fill="#A8806F">ASSUNTO</text>
  </g>
  <text x="80" y="1240" font-size="19" font-weight="700" letter-spacing="2" fill="#FDF6ED" fill-opacity="0.62">NEYMAR &#183; VINI JR. &#183; RAPHINHA &#183; L&#201;O PEREIRA</text>
  <text x="540" y="1312" font-size="19" font-weight="600" letter-spacing="1" text-anchor="middle" fill="#FDF6ED" fill-opacity="0.45">@drafrancinealmeida</text>
</g>
"@

# ============ SLIDE 2 — O FENOMENO (foto Neymar) ============
$b2 = @"
<g clip-path="url(#clip)">
  <defs>
    <linearGradient id="s2Bot" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0" stop-color="#1A1210" stop-opacity="0"/>
      <stop offset="0.32" stop-color="#1A1210" stop-opacity="0"/>
      <stop offset="0.46" stop-color="#1A1210" stop-opacity="0.55"/>
      <stop offset="0.55" stop-color="#1A1210" stop-opacity="0.93"/>
      <stop offset="0.63" stop-color="#1A1210" stop-opacity="1"/>
      <stop offset="1" stop-color="#1A1210" stop-opacity="1"/>
    </linearGradient>
    <radialGradient id="s2Vig" gradientUnits="userSpaceOnUse" cx="540" cy="410" r="760" gradientTransform="translate(540 410) scale(1.1 1) translate(-540 -410)">
      <stop offset="0.40" stop-color="#1A1210" stop-opacity="0"/>
      <stop offset="1" stop-color="#1A1210" stop-opacity="0.40"/>
    </radialGradient>
  </defs>
  <rect width="1080" height="1350" fill="#1A1210"/>
  <image xlink:href="data:image/jpeg;base64,$ney" x="0" y="0" width="1080" height="1350" preserveAspectRatio="xMidYMid slice"/>
  <rect width="1080" height="1350" fill="url(#s2Vig)"/>
  <rect width="1080" height="1350" fill="url(#s2Bot)"/>

  <rect x="80" y="772" width="48" height="4" fill="#A8806F"/>
  <text x="80" y="814" font-size="20" font-weight="700" letter-spacing="4" fill="#A8806F">TEND&#202;NCIA EM ALTA</text>
  <g class="disp" letter-spacing="1.5" fill="#FDF6ED">
    <text x="78" y="896" font-size="72">A EST&#201;TICA MASCULINA</text>
    <text x="78" y="966" font-size="72" fill="#A8806F">ENTROU EM CAMPO</text>
  </g>
  <g font-size="28" font-weight="400" letter-spacing="-0.2" fill="#FDF6ED" fill-opacity="0.66">
    <text x="80" y="1064">Os rostos dos craques colocaram em pauta uma</text>
    <text x="80" y="1108">tend&#234;ncia que s&#243; cresce: a harmoniza&#231;&#227;o facial</text>
    <text x="80" y="1152">masculina. Cada vez mais homens buscam tra&#231;os</text>
    <text x="80" y="1196">definidos, pele firme e um ar descansado.</text>
    <text x="80" y="1240">Sem exagero e <tspan font-weight="800" fill="#FDF6ED">sem perder a masculinidade</tspan>.</text>
  </g>
</g>
"@

# ============ SLIDE 3 — PROCEDIMENTOS (cafe) ============
$b3 = @"
<g clip-path="url(#clip)">
  <rect width="1080" height="1350" fill="#1A1210"/>
  <text x="1030" y="1300" class="disp" font-size="300" letter-spacing="-8" text-anchor="end" fill="#FFFFFF" fill-opacity="0.05">03</text>
  <rect x="80" y="150" width="56" height="5" fill="#A8806F"/>
  <text x="80" y="194" font-size="22" font-weight="700" letter-spacing="4" fill="#A8806F">O PROTOCOLO MASCULINO</text>
  <g font-size="31" font-weight="400" letter-spacing="-0.2" fill="#FDF6ED" fill-opacity="0.60">
    <text x="80" y="270">Por tr&#225;s dos rostos deles, tr&#234;s procedimentos</text>
    <text x="80" y="314">que estruturam o rosto masculino.</text>
  </g>

  <rect x="80" y="396" width="40" height="4" fill="#8B6355"/>
  <text x="80" y="438" font-size="17" font-weight="700" letter-spacing="2.5" fill="#A8806F">TOXINA BOTUL&#205;NICA</text>
  <text x="78" y="512" class="disp" font-size="72" letter-spacing="1" fill="#FDF6ED">BOTOX</text>
  <g font-size="25" font-weight="400" fill="#FDF6ED" fill-opacity="0.55">
    <text x="80" y="558">Relaxa a musculatura e suaviza as linhas da</text>
    <text x="80" y="590">testa e do olhar, prevenindo marcas.</text>
  </g>

  <rect x="80" y="660" width="40" height="4" fill="#8B6355"/>
  <text x="80" y="702" font-size="17" font-weight="700" letter-spacing="2.5" fill="#A8806F">BIOESTIMULADOR DE COL&#193;GENO</text>
  <text x="78" y="776" class="disp" font-size="72" letter-spacing="1" fill="#FDF6ED">COL&#193;GENO</text>
  <g font-size="25" font-weight="400" fill="#FDF6ED" fill-opacity="0.55">
    <text x="80" y="822">Ativa a produ&#231;&#227;o do seu pr&#243;prio col&#225;geno,</text>
    <text x="80" y="854">devolvendo firmeza e sustenta&#231;&#227;o &#224; pele.</text>
  </g>

  <rect x="80" y="924" width="40" height="4" fill="#8B6355"/>
  <text x="80" y="966" font-size="17" font-weight="700" letter-spacing="2.5" fill="#A8806F">PREENCHIMENTO / &#193;CIDO HIALUR&#212;NICO</text>
  <text x="78" y="1040" class="disp" font-size="72" letter-spacing="1" fill="#FDF6ED">CONTORNO</text>
  <g font-size="25" font-weight="400" fill="#FDF6ED" fill-opacity="0.55">
    <text x="80" y="1086">Define a mand&#237;bula, projeta o queixo e</text>
    <text x="80" y="1118">equilibra os tra&#231;os do rosto masculino.</text>
  </g>
</g>
"@

# ============ SLIDE 4 — O QUE BUSCAM (creme) ============
$b4 = @"
<g clip-path="url(#clip)">
  <rect width="1080" height="1350" fill="#FDF6ED"/>
  <text x="1030" y="1300" class="disp" font-size="300" letter-spacing="-8" text-anchor="end" fill="#5C3D30" fill-opacity="0.06">04</text>
  <rect x="80" y="150" width="56" height="5" fill="#8B6355"/>
  <text x="80" y="194" font-size="22" font-weight="700" letter-spacing="4" fill="#8B6355">O QUE ELES BUSCAM</text>
  <g class="disp" letter-spacing="1.5" fill="#1A1210">
    <text x="78" y="318" font-size="90">RESULTADO QUE</text>
    <text x="78" y="406" font-size="90" fill="#8B6355">N&#195;O GRITA</text>
  </g>
  <g font-size="31" font-weight="400" letter-spacing="-0.2" fill="#1A1210" fill-opacity="0.62">
    <text x="80" y="496">O foco n&#227;o &#233; chamar aten&#231;&#227;o. &#201; parecer a sua</text>
    <text x="80" y="540">melhor vers&#227;o &#8212; descansado e no controle.</text>
  </g>

  <g fill="#1A1210" fill-opacity="0.80" font-size="30" font-weight="500">
    <rect x="80" y="630" width="24" height="4" fill="#8B6355"/>
    <text x="120" y="642">Mand&#237;bula e queixo mais definidos</text>
    <rect x="80" y="708" width="24" height="4" fill="#8B6355"/>
    <text x="120" y="720">Olhar descansado, sem cara de cansa&#231;o</text>
    <rect x="80" y="786" width="24" height="4" fill="#8B6355"/>
    <text x="120" y="798">Pele firme, com mais fotogenia</text>
    <rect x="80" y="864" width="24" height="4" fill="#8B6355"/>
    <text x="120" y="876">Express&#245;es suaves, sem travar o rosto</text>
  </g>

  <text x="80" y="990" font-size="32" font-weight="700" letter-spacing="-0.3" fill="#1A1210">A diferen&#231;a aparece. O procedimento, n&#227;o.</text>
</g>
"@

# ============ SLIDE 5 — NATURALIDADE (gradiente) ============
$b5 = @"
<g clip-path="url(#clip)">
  <rect width="1080" height="1350" fill="url(#bgGrad)"/>
  <text x="1040" y="1300" class="disp" font-size="320" letter-spacing="-10" text-anchor="end" fill="#FFFFFF" fill-opacity="0.10">05</text>
  <rect x="80" y="186" width="56" height="5" fill="#FFFFFF" fill-opacity="0.6"/>
  <text x="80" y="230" font-size="22" font-weight="700" letter-spacing="4" fill="#FFFFFF" fill-opacity="0.70">O QUE REALMENTE IMPORTA</text>
  <g class="disp" letter-spacing="1.5" fill="#FFFFFF">
    <text x="78" y="350" font-size="94">N&#195;O &#201; VIRAR</text>
    <text x="78" y="438" font-size="94">OUTRA PESSOA</text>
  </g>
  <g font-size="31" font-weight="500" letter-spacing="-0.2">
    <text x="80" y="556" fill="#FFFFFF" fill-opacity="0.45">&#8212;</text>
    <text x="124" y="556" fill="#FFFFFF" fill-opacity="0.88">O objetivo n&#227;o &#233; mudar as fei&#231;&#245;es &#8212; &#233;</text>
    <text x="124" y="600" fill="#FFFFFF" fill-opacity="0.88"><tspan font-weight="800">gerenciar o tempo</tspan>, n&#227;o apag&#225;-lo.</text>
    <text x="80" y="690" fill="#FFFFFF" fill-opacity="0.45">&#8212;</text>
    <text x="124" y="690" fill="#FFFFFF" fill-opacity="0.88"><tspan font-weight="800">Naturalidade</tspan> acima de tudo: o bom</text>
    <text x="124" y="734" fill="#FFFFFF" fill-opacity="0.88">resultado &#233; o que ningu&#233;m percebe.</text>
    <text x="80" y="824" fill="#FFFFFF" fill-opacity="0.45">&#8212;</text>
    <text x="124" y="824" fill="#FFFFFF" fill-opacity="0.88">Cuidar do rosto deixou de ser tabu &#8212;</text>
    <text x="124" y="868" fill="#FFFFFF" fill-opacity="0.88">inclusive <tspan font-weight="800">para os homens</tspan>.</text>
    <text x="80" y="958" fill="#FFFFFF" fill-opacity="0.45">&#8212;</text>
    <text x="124" y="958" fill="#FFFFFF" fill-opacity="0.88">Tudo come&#231;a com um <tspan font-weight="800">planejamento</tspan></text>
    <text x="124" y="1002" fill="#FFFFFF" fill-opacity="0.88"><tspan font-weight="800">individual</tspan> &#8212; nada de f&#243;rmula pronta.</text>
  </g>
</g>
"@

# ============ SLIDE 6 — FECHAMENTO (busto de marmore) ============
$b6 = @"
<g clip-path="url(#clip)">
  <defs>
    <linearGradient id="bustLeft" x1="0" y1="0" x2="1" y2="0">
      <stop offset="0" stop-color="#FDF6ED" stop-opacity="0.94"/>
      <stop offset="0.30" stop-color="#FDF6ED" stop-opacity="0.84"/>
      <stop offset="0.46" stop-color="#FDF6ED" stop-opacity="0.34"/>
      <stop offset="0.54" stop-color="#FDF6ED" stop-opacity="0.06"/>
      <stop offset="0.60" stop-color="#FDF6ED" stop-opacity="0"/>
    </linearGradient>
  </defs>
  <rect width="1080" height="1350" fill="#FDF6ED"/>
  <image xlink:href="data:image/jpeg;base64,$bust" x="0" y="0" width="1080" height="1350" preserveAspectRatio="xMidYMid slice"/>
  <rect width="1080" height="1350" fill="url(#bustLeft)"/>

  <circle cx="124" cy="430" r="42" fill="url(#accent)"/>
  <text x="124" y="446" font-size="40" font-weight="800" text-anchor="middle" fill="#FFFFFF">F</text>
  <text x="80" y="556" font-size="22" font-weight="700" letter-spacing="4" fill="#8B6355">DRA. FRANCINE ALMEIDA</text>
  <g class="disp" letter-spacing="1.5">
    <text x="78" y="660" font-size="70" fill="#1A1210">CUIDAR &#201; O</text>
    <text x="78" y="730" font-size="70" fill="#8B6355">NOVO PADR&#195;O</text>
  </g>
  <g font-size="24" font-weight="400" letter-spacing="-0.2" fill="#1A1210" fill-opacity="0.62">
    <text x="80" y="808">Harmoniza&#231;&#227;o facial masculina,</text>
    <text x="80" y="842">com naturalidade.</text>
  </g>
  <g font-size="21" font-weight="400" letter-spacing="-0.1" fill="#1A1210" fill-opacity="0.52">
    <text x="80" y="914">Planejamento individual, t&#233;cnica e bom</text>
    <text x="80" y="946">senso para valorizar o seu rosto sem</text>
    <text x="80" y="978">mudar quem voc&#234; &#233;.</text>
  </g>
  <text x="80" y="1050" font-size="22" font-weight="700" letter-spacing="0.5" fill="#1A1210">@drafrancinealmeida</text>
</g>
"@

$order = @(
  @("SC2_01_capa",$b1),
  @("SC2_02_fenomeno",$b2),
  @("SC2_03_procedimentos",$b3),
  @("SC2_04_buscam",$b4),
  @("SC2_05_naturalidade",$b5),
  @("SC2_06_fechamento",$b6)
)
$enc = New-Object System.Text.UTF8Encoding($false)
foreach($it in $order){
  $svg = $open + $it[1] + "`n</svg>"
  [IO.File]::WriteAllText("$base\$($it[0]).svg",$svg,$enc)
  Write-Output "SVG -> $($it[0]).svg ($([math]::Round((Get-Item "$base\$($it[0]).svg").Length/1KB)) KB)"
}

$ErrorActionPreference="Continue"
$chrome="C:\Program Files\Google\Chrome\Application\chrome.exe"
foreach($it in $order){
  $k=$it[0]; $udd="$env:TEMP\sc2_$($k)_$(Get-Random)"
  try{ & $chrome --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 --window-size=1080,1350 --virtual-time-budget=2500 --default-background-color=00000000 --user-data-dir="$udd" --screenshot="$base\${k}_check.png" ("file:///"+("$base\$k.svg" -replace '\\','/')) 2>$null | Out-Null }catch{}
  Start-Sleep -Milliseconds 250
  try{ Remove-Item $udd -Recurse -Force -ErrorAction Stop }catch{}
  Write-Output "check -> ${k}_check.png"
}
Write-Output "DONE"
