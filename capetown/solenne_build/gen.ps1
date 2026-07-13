Add-Type -AssemblyName System.Drawing
$base = 'C:\Users\joaog\ippo-universo\capetown\solenne_build'
$dl   = 'C:\Users\joaog\Downloads'
$out  = 'C:\Users\joaog\ippo-universo\capetown'
$chrome = 'C:\Program Files\Google\Chrome\Application\chrome.exe'

function ResizeJpg($inPath,$outPath,$targetW,$q){
  $img=[System.Drawing.Image]::FromFile($inPath)
  if($img.Width -le $targetW){ $img.Dispose(); Copy-Item $inPath $outPath -Force; return }
  $scale=$targetW/$img.Width; $nw=[int]$targetW; $nh=[int]($img.Height*$scale)
  $bmp=New-Object System.Drawing.Bitmap $nw,$nh
  $g=[System.Drawing.Graphics]::FromImage($bmp)
  $g.InterpolationMode=[System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $g.SmoothingMode=[System.Drawing.Drawing2D.SmoothingMode]::HighQuality
  $g.PixelOffsetMode=[System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
  $g.DrawImage($img,0,0,$nw,$nh); $g.Dispose(); $img.Dispose()
  $enc=[System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders()|?{$_.MimeType -eq 'image/jpeg'}
  $ep=New-Object System.Drawing.Imaging.EncoderParameters 1
  $ep.Param[0]=New-Object System.Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality,[long]$q)
  $bmp.Save($outPath,$enc,$ep); $bmp.Dispose()
}

# prepare images
ResizeJpg "$dl\balneario-camboriu-skyline-camboriu-santa-catarina-brazil.jpg" "$base\bc_skyline.jpg" 1500 88
Copy-Item "$dl\360_F_1528005530_ZNz1dNIZzrcgAn4Ai9OdsGANcXTCwRkD.jpg" "$base\bc_torres.jpg" -Force
Copy-Item "$dl\45d9b0608b3d7d21015224b43e050356.jpg" "$base\bc_golden.jpg" -Force
$logoB64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\A10_Logo_carvao.png"))

$DEFS = @'
    <style>
      @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&amp;family=Cormorant+Garamond:wght@500;600;700&amp;display=swap');
      .sans  { font-family: 'Poppins','Helvetica Neue',Arial,sans-serif; }
      .serif { font-family: 'Cormorant Garamond','Times New Roman',serif; }
    </style>
    <linearGradient id="paper" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0" stop-color="#F8F3EB"/><stop offset="1" stop-color="#EFE6D6"/>
    </linearGradient>
    <linearGradient id="goldT" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0" stop-color="#C49A4A"/><stop offset="1" stop-color="#9B7528"/>
    </linearGradient>
    <filter id="cardSh" x="-15%" y="-15%" width="130%" height="135%">
      <feDropShadow dx="0" dy="13" stdDeviation="24" flood-color="#2A2014" flood-opacity="0.22"/>
    </filter>
    <filter id="ctaSh" x="-20%" y="-60%" width="140%" height="220%">
      <feDropShadow dx="0" dy="9" stdDeviation="16" flood-color="#2A2014" flood-opacity="0.28"/>
    </filter>
'@

function FeedSVG($img,$kicker,$hook){
@"
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="1080" height="1350" viewBox="0 0 1080 1350">
  <defs>
$DEFS
    <clipPath id="cImg"><rect x="72" y="180" width="936" height="400" rx="22"/></clipPath>
  </defs>
  <rect width="1080" height="1350" fill="url(#paper)"/>
  <rect x="26" y="26" width="1028" height="1298" rx="10" fill="none" stroke="#C6AD6E" stroke-width="1" opacity="0.55"/>

  <image x="72" y="60" width="200" height="79" xlink:href="data:image/png;base64,$logoB64" preserveAspectRatio="xMidYMid meet"/>
  <line x1="72" y1="162" x2="1008" y2="162" stroke="#C6AD6E" stroke-width="1" opacity="0.30"/>

  <g filter="url(#cardSh)">
    <image clip-path="url(#cImg)" x="72" y="180" width="936" height="400"
           xlink:href="data:image/jpeg;base64,$img" preserveAspectRatio="xMidYMid slice"/>
  </g>
  <rect x="72" y="180" width="936" height="400" rx="22" fill="none" stroke="#C6AD6E" stroke-width="1.5" opacity="0.7"/>

  <text class="sans" x="74" y="636" fill="#B5904E" font-size="21" font-weight="600" letter-spacing="2">$kicker</text>
  <text class="serif" x="70" y="716" fill="#2A2620" font-size="76" font-weight="600">Via <tspan fill="#A9772A">SCP</tspan>, em</text>
  <text class="serif" x="70" y="790" fill="#2A2620" font-size="76" font-weight="600">Balne&#225;rio Cambori&#250;</text>
  <text class="sans" x="74" y="832" fill="#9B7528" font-size="18" font-weight="600" letter-spacing="1">SCP &#183; SOCIEDADE EM CONTA DE PARTICIPA&#199;&#195;O</text>
  <text class="sans" x="74" y="876" fill="#2A2620" font-size="25" font-weight="600">$hook</text>

  <text class="sans" x="74" y="934" fill="#3A352E" font-size="23" font-weight="400"><tspan fill="#B5904E" font-size="16">&#9670;</tspan>&#160;&#160;Seu capital entra no terreno, antes do lan&#231;amento.</text>
  <text class="sans" x="74" y="978" fill="#3A352E" font-size="23" font-weight="400"><tspan fill="#B5904E" font-size="16">&#9670;</tspan>&#160;&#160;Voc&#234; participa da margem de toda a opera&#231;&#227;o.</text>
  <text class="sans" x="74" y="1022" fill="#3A352E" font-size="23" font-weight="400"><tspan fill="#B5904E" font-size="16">&#9670;</tspan>&#160;&#160;Do terreno ao VGV: voc&#234; captura cada fase do ciclo.</text>

  <g filter="url(#ctaSh)"><rect x="72" y="1082" width="580" height="94" rx="47" fill="#2A2620"/></g>
  <text class="sans" x="362" y="1139" text-anchor="middle" fill="#F4EEE2" font-size="26" font-weight="600" letter-spacing="2">FALAR COM ESPECIALISTA<tspan fill="#E2C77E" font-size="29">&#160;&#160;&#8250;</tspan></text>
</svg>
"@
}

function StoriesSVG($img,$kicker,$hook){
@"
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="1080" height="1920" viewBox="0 0 1080 1920">
  <defs>
$DEFS
    <clipPath id="cImg"><rect x="80" y="222" width="920" height="720" rx="28"/></clipPath>
  </defs>
  <rect width="1080" height="1920" fill="url(#paper)"/>
  <rect x="30" y="30" width="1020" height="1860" rx="12" fill="none" stroke="#C6AD6E" stroke-width="1" opacity="0.55"/>

  <image x="80" y="92" width="224" height="88" xlink:href="data:image/png;base64,$logoB64" preserveAspectRatio="xMidYMid meet"/>
  <line x1="80" y1="206" x2="1000" y2="206" stroke="#C6AD6E" stroke-width="1" opacity="0.30"/>

  <g filter="url(#cardSh)">
    <image clip-path="url(#cImg)" x="80" y="222" width="920" height="720"
           xlink:href="data:image/jpeg;base64,$img" preserveAspectRatio="xMidYMid slice"/>
  </g>
  <rect x="80" y="222" width="920" height="720" rx="28" fill="none" stroke="#C6AD6E" stroke-width="1.5" opacity="0.7"/>

  <text class="sans" x="82" y="1032" fill="#B5904E" font-size="27" font-weight="600" letter-spacing="3">$kicker</text>
  <text class="serif" x="78" y="1138" fill="#2A2620" font-size="94" font-weight="600">Via <tspan fill="#A9772A">SCP</tspan>, em</text>
  <text class="serif" x="78" y="1234" fill="#2A2620" font-size="94" font-weight="600">Balne&#225;rio Cambori&#250;</text>
  <text class="sans" x="82" y="1284" fill="#9B7528" font-size="21" font-weight="600" letter-spacing="1">SCP &#183; SOCIEDADE EM CONTA DE PARTICIPA&#199;&#195;O</text>
  <text class="sans" x="82" y="1336" fill="#2A2620" font-size="31" font-weight="600">$hook</text>

  <text class="sans" x="82" y="1414" fill="#3A352E" font-size="29" font-weight="400"><tspan fill="#B5904E" font-size="20">&#9670;</tspan>&#160;&#160;Seu capital entra no terreno, antes do lan&#231;amento.</text>
  <text class="sans" x="82" y="1470" fill="#3A352E" font-size="29" font-weight="400"><tspan fill="#B5904E" font-size="20">&#9670;</tspan>&#160;&#160;Voc&#234; participa da margem de toda a opera&#231;&#227;o.</text>
  <text class="sans" x="82" y="1526" fill="#3A352E" font-size="29" font-weight="400"><tspan fill="#B5904E" font-size="20">&#9670;</tspan>&#160;&#160;Do terreno ao VGV: voc&#234; captura cada fase do ciclo.</text>

  <g filter="url(#ctaSh)"><rect x="80" y="1606" width="660" height="104" rx="52" fill="#2A2620"/></g>
  <text class="sans" x="410" y="1670" text-anchor="middle" fill="#F4EEE2" font-size="29" font-weight="600" letter-spacing="2">FALAR COM ESPECIALISTA<tspan fill="#E2C77E" font-size="32">&#160;&#160;&#8250;</tspan></text>
</svg>
"@
}

$models = @(
  @{ key='Mercado';    img='bc_skyline.jpg'; kicker='O M&#178; MAIS VALORIZADO DO BRASIL';
     hook='Invista na incorpora&#231;&#227;o como s&#243;cio, n&#227;o como comprador.' }
  @{ key='Escassez';   img='bc_torres.jpg'; kicker='A CIDADE QUE N&#195;O TEM ONDE CRESCER';
     hook='Invista na incorpora&#231;&#227;o como s&#243;cio, n&#227;o como comprador.' }
  @{ key='Patrimonio'; img='bc_golden.jpg'; kicker='PATRIM&#212;NIO ONDE O BRASIL OLHA';
     hook='Invista na incorpora&#231;&#227;o como s&#243;cio, n&#227;o como comprador.' }
)

$encU = New-Object System.Text.UTF8Encoding($false)
foreach($m in $models){
  $b64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\$($m.img)"))
  $feed = FeedSVG $b64 $m.kicker $m.hook
  $story = StoriesSVG $b64 $m.kicker $m.hook
  $fF = "$out\BalnearioCamboriu_$($m.key)_Feed_1080x1350.svg"
  $fS = "$out\BalnearioCamboriu_$($m.key)_Stories_1080x1920.svg"
  [IO.File]::WriteAllText($fF,$feed,$encU)
  [IO.File]::WriteAllText($fS,$story,$encU)
  "WROTE $($m.key)  feed=$([Math]::Round((Get-Item $fF).Length/1KB))KB  stories=$([Math]::Round((Get-Item $fS).Length/1KB))KB"
}
"ASSETS DONE"
