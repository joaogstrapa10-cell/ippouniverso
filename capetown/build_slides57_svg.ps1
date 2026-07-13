$ErrorActionPreference="Stop"
$base="C:\Users\joaog\ippo-universo\capetown"
$jk = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\fonts\PlusJakartaSans.ttf"))
$fonts="@font-face{font-family:'Plus Jakarta Sans';src:url(data:font/ttf;base64,$jk) format('truetype');font-weight:200 800;}`ntext{font-family:'Plus Jakarta Sans',sans-serif;}"

$defsCommon = @"
<linearGradient id="accent" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="#5C3D30"/><stop offset="0.5" stop-color="#8B6355"/><stop offset="1" stop-color="#A8806F"/></linearGradient>
"@

# Placeholder helper (dashed editavel) -> string
function PH($x,$y,$w,$h,$label){
@"
<rect x="$x" y="$y" width="$w" height="$h" rx="20" fill="#EBE0D2" stroke="#C9B49E" stroke-width="2" stroke-dasharray="9 7"/>
<rect x="$($x+$w/2-22)" y="$($y+$h/2-46)" width="44" height="44" rx="4" fill="none" stroke="#9A8164" stroke-width="3"/>
<rect x="$($x+$w/2-9)" y="$($y+$h/2-33)" width="18" height="18" fill="#9A8164"/>
<text x="$($x+$w/2)" y="$($y+$h/2+34)" font-size="20" font-weight="600" text-anchor="middle" fill="#9A8164">$label</text>
"@
}

# ===================== SLIDE 5 =====================
$ph5 = PH 56 576 968 360 "IMAGEM &#183; contorno facial / avalia&#231;&#227;o / procedimento"
$svg5 = @"
<svg xmlns="http://www.w3.org/2000/svg" width="1080" height="1350" viewBox="0 0 1080 1350">
<defs><style>$fonts</style>$defsCommon</defs>
<rect width="1080" height="1350" fill="#FDF6ED"/>
<rect width="1080" height="7" fill="url(#accent)"/>
<text x="56" y="52" font-size="14" font-weight="700" letter-spacing="1.5" fill="#0F0D0C" fill-opacity="0.45">HARMONIZA&#199;&#195;O OROFACIAL</text>
<text x="540" y="52" font-size="14" font-weight="700" letter-spacing="1.5" text-anchor="middle" fill="#0F0D0C" fill-opacity="0.45">@drafrancinealmeida</text>
<text x="1024" y="52" font-size="14" font-weight="700" letter-spacing="1.5" text-anchor="end" fill="#0F0D0C" fill-opacity="0.45">2026 &#174;</text>
$ph5
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
[IO.File]::WriteAllText("$base\CT_05_especialistas.svg", $svg5, (New-Object System.Text.UTF8Encoding($false)))

# ===================== SLIDE 7 (CTA) =====================
$ph7 = PH 56 359 968 300 "IMAGEM &#183; Dra. Francine (fechamento com rosto humano)"
$svg7 = @"
<svg xmlns="http://www.w3.org/2000/svg" width="1080" height="1350" viewBox="0 0 1080 1350">
<defs><style>$fonts</style>$defsCommon</defs>
<rect width="1080" height="1350" fill="#FDF6ED"/>
<rect width="1080" height="7" fill="url(#accent)"/>
<text x="56" y="52" font-size="14" font-weight="700" letter-spacing="1.5" fill="#0F0D0C" fill-opacity="0.45">HARMONIZA&#199;&#195;O OROFACIAL</text>
<text x="540" y="52" font-size="14" font-weight="700" letter-spacing="1.5" text-anchor="middle" fill="#0F0D0C" fill-opacity="0.45">@drafrancinealmeida</text>
<text x="1024" y="52" font-size="14" font-weight="700" letter-spacing="1.5" text-anchor="end" fill="#0F0D0C" fill-opacity="0.45">2026 &#174;</text>
$ph7
<g font-size="36" font-weight="500" letter-spacing="-0.2" fill="#0F0D0C" fill-opacity="0.58">
  <text x="56" y="723">Emagrecer com Mounjaro &#233; uma decis&#227;o de corpo.</text>
  <text x="56" y="777">Preservar o rosto &#233; uma decis&#227;o que precisa vir <tspan font-weight="800" fill="#1A1210" fill-opacity="1">antes da</tspan></text>
  <text x="56" y="831"><tspan font-weight="800" fill="#1A1210" fill-opacity="1">primeira aplica&#231;&#227;o</tspan>.</text>
</g>
<rect x="56" y="880" width="968" height="276" rx="20" fill="#FFFFFF" stroke="#8B6355" stroke-opacity="0.15" stroke-width="3"/>
<text x="104" y="945" font-size="22" font-weight="500" fill="#0F0D0C" fill-opacity="0.45">Conhece algu&#233;m usando a caneta?</text>
<g font-size="60" font-weight="800" letter-spacing="-1.5" fill="#8B6355">
  <text x="104" y="1010">Encaminha</text>
  <text x="104" y="1070">esse post</text>
</g>
<text x="104" y="1118" font-size="24" font-weight="500" fill="#0F0D0C" fill-opacity="0.55">para quem precisa ver isso antes de come&#231;ar o tratamento.</text>
<circle cx="76" cy="1208" r="20" fill="url(#accent)"/>
<text x="76" y="1214" font-size="16" font-weight="800" text-anchor="middle" fill="#FFFFFF">F</text>
<text x="112" y="1214" font-size="18" font-weight="500" fill="#0F0D0C" fill-opacity="0.40">Dra. Francine Almeida &#183; Harmoniza&#231;&#227;o Orofacial</text>
<rect x="56" y="1316" width="916" height="3" rx="1.5" fill="#000000" fill-opacity="0.08"/>
<rect x="56" y="1316" width="916" height="3" rx="1.5" fill="#8B6355"/>
<text x="1024" y="1322" font-size="15" font-weight="600" text-anchor="end" fill="#000000" fill-opacity="0.30">7/7</text>
</svg>
"@
[IO.File]::WriteAllText("$base\CT_07_cta.svg", $svg7, (New-Object System.Text.UTF8Encoding($false)))
Write-Output "gerados CT_05 e CT_07"

$chrome="C:\Program Files\Google\Chrome\Application\chrome.exe"
foreach($s in @("05_especialistas","07_cta")){
  $udd="$env:TEMP\c_$($s)_$(Get-Random)"
  & $chrome --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 --window-size=1080,1350 --virtual-time-budget=2000 --default-background-color=00000000 --user-data-dir="$udd" --screenshot="$base\CT_$($s.Substring(0,2))_check.png" ("file:///"+("$base\CT_$s.svg" -replace '\\','/')) 2>$null | Out-Null
  Start-Sleep -Milliseconds 250; try{Remove-Item $udd -Recurse -Force -ErrorAction Stop}catch{}
}
Write-Output "checks ok"
