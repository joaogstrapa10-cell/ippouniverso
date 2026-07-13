param([string]$Slide="4")
$ErrorActionPreference="Stop"
$base="C:\Users\joaog\ippo-universo\capetown"
$css = [IO.File]::ReadAllText("$base\_css_extract.css")
$jk  = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\fonts\PlusJakartaSans.ttf"))
$bcB = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\fonts\BarlowCondensed-Black.ttf"))
$bcS = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\fonts\BarlowCondensed-SemiBold.ttf"))

$markup = @{}
$markup["4"] = @"
<div class="slide slide-dark on-dark with-img" id="slide-4">
  <div class="slide-img-ph"><div class="ph-icon">&#9635;</div><div class="ph-label">IMAGEM FUNDO &#183; discreta</div></div>
  <div class="slide-img-overlay heavy"></div>
  <div class="accent-bar"></div>
  <div class="brand-bar on-dark"><span>HARMONIZA&#199;&#195;O OROFACIAL</span><span>@drafrancinealmeida</span><span>2026 &#174;</span></div>
  <div class="content">
    <div class="tag">OS N&#218;MEROS</div>
    <div class="dark-body" style="margin-bottom:36px;">N&#227;o &#233; caso isolado. &#201; um fen&#244;meno que est&#225; chegando junto com a populariza&#231;&#227;o da caneta no Brasil inteiro.</div>
    <table class="data-table-dark">
      <tr><td class="dt-ind">Adultos brasileiros com excesso de peso</td><td class="dt-val">57%<span class="dt-src">Vigitel, 2023</span></td></tr>
      <tr><td class="dt-ind">Perda de peso com tirzepatida</td><td class="dt-val">+20%<span class="dt-src">do peso corporal</span></td></tr>
      <tr><td class="dt-ind">Chegada oficial do Mounjaro ao Brasil</td><td class="dt-val">2025<span class="dt-src">registro Anvisa</span></td></tr>
    </table>
  </div>
  <div class="prog"><div class="prog-track"><div class="prog-fill" style="width:57.1%;"></div></div><span class="prog-num">4/7</span></div>
</div>
"@
$markup["6"] = @"
<div class="slide slide-grad on-grad" id="slide-6">
  <div class="grad-bg-num">06</div>
  <div class="accent-bar on-grad"></div>
  <div class="brand-bar on-grad"><span>HARMONIZA&#199;&#195;O OROFACIAL</span><span>@drafrancinealmeida</span><span>2026 &#174;</span></div>
  <div class="content">
    <div class="tag">A ORDEM CERTA</div>
    <div class="grad-h1">Antes. Durante.<br>N&#227;o depois.</div>
    <div class="grad-row"><span class="grad-arrow">&#8594;</span><span class="grad-text">A harmoniza&#231;&#227;o rep&#245;e o que o emagrecimento tirou: <strong>col&#225;geno e volume</strong></span></div>
    <div class="grad-row"><span class="grad-arrow">&#8594;</span><span class="grad-text">Bioestimulador devolve sustenta&#231;&#227;o. Preenchimento recupera as regi&#245;es malar e mandibular</span></div>
    <div class="grad-row"><span class="grad-arrow">&#8594;</span><span class="grad-text">A janela &#233; curta &#8212; depois que as fibras el&#225;sticas rompem, a corre&#231;&#227;o fica <strong>mais complexa e cara</strong></span></div>
  </div>
  <div class="prog"><div class="prog-track"><div class="prog-fill" style="width:85.7%;background:var(--PL);"></div></div><span class="prog-num">6/7</span></div>
</div>
"@

$markup["5"] = @"
<div class="slide slide-light on-light" id="slide-5">
  <div class="accent-bar"></div>
  <div class="brand-bar on-light"><span>HARMONIZA&#199;&#195;O OROFACIAL</span><span>@drafrancinealmeida</span><span>2026 &#174;</span></div>
  <div class="content">
    <div class="img-box"><div class="placeholder ph-light" style="height:360px;"><div class="ph-icon">&#9635;</div><div class="ph-label">IMAGEM &#183; contorno facial / avalia&#231;&#227;o / procedimento</div></div></div>
    <div class="tag">O QUE OS ESPECIALISTAS VEEM</div>
    <div class="light-body">Profissionais j&#225; relatam a queda de col&#225;geno e a "face que despenca" antes mesmo de a paciente perceber a flacidez. A gordura que ningu&#233;m queria no corpo era exatamente a que segurava a <strong>jovialidade do rosto</strong>.</div>
  </div>
  <div class="prog"><div class="prog-track"><div class="prog-fill" style="width:71.4%;"></div></div><span class="prog-num">5/7</span></div>
</div>
"@
$markup["7"] = @"
<div class="slide slide-cta on-light" id="slide-7">
  <div class="accent-bar"></div>
  <div class="brand-bar on-light"><span>HARMONIZA&#199;&#195;O OROFACIAL</span><span>@drafrancinealmeida</span><span>2026 &#174;</span></div>
  <div class="content">
    <div class="cta-img-box"><div class="placeholder ph-light" style="height:300px;"><div class="ph-icon">&#9635;</div><div class="ph-label">IMAGEM &#183; Dra. Francine (fechamento com rosto humano)</div></div></div>
    <div class="cta-bridge">Emagrecer com Mounjaro &#233; uma decis&#227;o de corpo. Preservar o rosto &#233; uma decis&#227;o que precisa vir <strong>antes da primeira aplica&#231;&#227;o</strong>.</div>
    <div class="cta-kbox">
      <div class="cta-kinstr">Conhece algu&#233;m usando a caneta?</div>
      <div class="cta-kword-sm">Encaminha<br>esse post</div>
      <div class="cta-kbenefit">para quem precisa ver isso antes de come&#231;ar o tratamento.</div>
    </div>
    <div class="cta-footer"><div class="cta-footer-dot">F</div><span class="cta-footer-text">Dra. Francine Almeida &#183; Harmoniza&#231;&#227;o Orofacial</span></div>
  </div>
  <div class="prog"><div class="prog-track"><div class="prog-fill" style="width:100.0%;"></div></div><span class="prog-num">7/7</span></div>
</div>
"@

$html = @"
<!DOCTYPE html><html><head><meta charset="UTF-8"><style>
@font-face{font-family:'Plus Jakarta Sans';src:url(data:font/ttf;base64,$jk) format('truetype');font-weight:200 800;}
@font-face{font-family:'Barlow Condensed';src:url(data:font/ttf;base64,$bcB) format('truetype');font-weight:900;}
@font-face{font-family:'Barlow Condensed';src:url(data:font/ttf;base64,$bcS) format('truetype');font-weight:600;}
$css
html,body{margin:0!important;padding:0!important;background:#fff;}
</style></head><body>$($markup[$Slide])</body></html>
"@
$hp="$base\_faithful_$Slide.html"
[IO.File]::WriteAllText($hp,$html,(New-Object System.Text.UTF8Encoding($false)))
$chrome="C:\Program Files\Google\Chrome\Application\chrome.exe"
$out="$base\_faithful_$Slide.png"
if(Test-Path $out){Remove-Item $out -Force}
$udd="$env:TEMP\chrome_f$($Slide)_$(Get-Random)"
& $chrome --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 --window-size=1080,1350 --virtual-time-budget=2500 --user-data-dir="$udd" --screenshot="$out" ("file:///"+($hp -replace '\\','/')) 2>$null | Out-Null
Start-Sleep -Milliseconds 250
try{Remove-Item $udd -Recurse -Force -ErrorAction Stop}catch{}
if(Test-Path $out){Write-Output "rendered _faithful_$Slide.png"}
