# Mounjaro carousel -> overlay SVGs for Canva (photo-swap workflow)
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing
$dir   = 'C:\Users\joaog\ippo-universo\capetown'
$fd    = "$dir\fonts"
$out   = "$dir\MJ_canva"
New-Item -ItemType Directory -Force -Path $out | Out-Null
$enc   = New-Object System.Text.UTF8Encoding($false)
$chrome= "C:\Program Files\Google\Chrome\Application\chrome.exe"

function b64($p){ [Convert]::ToBase64String([IO.File]::ReadAllBytes($p)) }
$PF = b64 "$fd\PlayfairDisplay.ttf"      # variable 400-900
$JK = b64 "$fd\PlusJakartaSans.ttf"      # variable 200-800

# ---------- crop slide-1 photo to 1080x1350 (face upper-middle) ----------
$srcImg = [System.Drawing.Image]::FromFile("$dir\img\mj1.jpg")
$sw=$srcImg.Width; $sh=$srcImg.Height
$cw=[int]($sh*0.8); if($cw -gt $sw){ $cw=$sw }
$ch=[int]($cw/0.8); if($ch -gt $sh){ $ch=$sh; $cw=[int]($ch*0.8) }
$cx=[int](($sw-$cw)/2); $cy=0
$bmp=New-Object System.Drawing.Bitmap(1080,1350)
$g=[System.Drawing.Graphics]::FromImage($bmp)
$g.InterpolationMode=[System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.SmoothingMode=[System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$destR=New-Object System.Drawing.Rectangle(0,0,1080,1350)
$srcR=New-Object System.Drawing.Rectangle($cx,$cy,$cw,$ch)
$g.DrawImage($srcImg,$destR,$srcR,[System.Drawing.GraphicsUnit]::Pixel)
$g.Dispose()
$jpgEnc=[System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders()|Where-Object{$_.MimeType -eq 'image/jpeg'}
$ep=New-Object System.Drawing.Imaging.EncoderParameters(1)
$ep.Param[0]=New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality,92L)
$bmp.Save("$out\MJ_01_fundo.jpg",$jpgEnc,$ep)
$IMG1=b64 "$out\MJ_01_fundo.jpg"
$bmp.Dispose(); $srcImg.Dispose()
"crop src ${sw}x${sh} -> 1080x1350 (crop ${cw}x${ch} @ $cx)"

# ---------- shared defs ----------
$defs = @()
$defs += "<defs>"
$defs += "<style type='text/css'>"
$defs += "@font-face{font-family:'PF';src:url(data:font/ttf;base64,$PF) format('truetype');font-weight:400 900;}"
$defs += "@font-face{font-family:'JK';src:url(data:font/ttf;base64,$JK) format('truetype');font-weight:200 800;}"
$defs += "</style>"
# cream scrim from TOP (text at top): cream #FAF6F2 strong at y=0
$defs += "<linearGradient id='scrimTop' x1='0' y1='0' x2='0' y2='1'>"
$defs += "<stop offset='0' stop-color='#FAF6F2' stop-opacity='0.97'/><stop offset='0.28' stop-color='#FAF6F2' stop-opacity='0.95'/><stop offset='0.44' stop-color='#FAF6F2' stop-opacity='0.74'/><stop offset='0.58' stop-color='#FAF6F2' stop-opacity='0.25'/><stop offset='0.72' stop-color='#FAF6F2' stop-opacity='0.04'/><stop offset='1' stop-color='#FAF6F2' stop-opacity='0'/></linearGradient>"
# cream scrim from BOTTOM (text at bottom)
$defs += "<linearGradient id='scrimBot' x1='0' y1='0' x2='0' y2='1'>"
$defs += "<stop offset='0' stop-color='#FAF6F2' stop-opacity='0'/><stop offset='0.28' stop-color='#FAF6F2' stop-opacity='0.04'/><stop offset='0.42' stop-color='#FAF6F2' stop-opacity='0.25'/><stop offset='0.56' stop-color='#FAF6F2' stop-opacity='0.74'/><stop offset='0.72' stop-color='#FAF6F2' stop-opacity='0.95'/><stop offset='1' stop-color='#FAF6F2' stop-opacity='0.97'/></linearGradient>"
# dark scrim (cover / cta) strong at bottom
$defs += "<linearGradient id='scrimDark' x1='0' y1='0' x2='0' y2='1'>"
$defs += "<stop offset='0' stop-color='#000000' stop-opacity='0.10'/><stop offset='0.22' stop-color='#000000' stop-opacity='0.04'/><stop offset='0.44' stop-color='#1A1210' stop-opacity='0.34'/><stop offset='0.64' stop-color='#1A1210' stop-opacity='0.80'/><stop offset='0.84' stop-color='#1A1210' stop-opacity='0.96'/><stop offset='1' stop-color='#120C0A' stop-opacity='1'/></linearGradient>"
$defs += "</defs>"
$DEFS = $defs -join "`n"

# ---------- helpers ----------
function Esc($s){ ($s -replace '<','&lt;') -replace '>','&gt;' }  # keep numeric entities (&#225;) intact
function HL($lines,$x,$y0,$lh,$size,$fill,$op,$anchor,$ls){
  $t="<text font-family='PF' font-weight='900' font-size='$size' fill='$fill' fill-opacity='$op' text-anchor='$anchor' letter-spacing='$ls'>"
  $yy=$y0
  foreach($ln in $lines){ $t+="<tspan x='$x' y='$yy'>$(Esc $ln)</tspan>"; $yy=[math]::Round($yy+$lh,1) }
  $t+"</text>"
}
function BODY($lines,$x,$y0,$lh,$size,$fill,$op,$anchor,$ls){
  $t="<text font-family='JK' font-weight='400' font-size='$size' fill='$fill' fill-opacity='$op' text-anchor='$anchor' letter-spacing='$ls'>"
  $yy=$y0
  foreach($ln in $lines){ $t+="<tspan x='$x' y='$yy'>$(Esc $ln)</tspan>"; $yy=[math]::Round($yy+$lh,1) }
  $t+"</text>"
}
function TAG($txt,$x,$y,$fill,$anchor){
  "<text font-family='JK' font-weight='800' font-size='24' letter-spacing='5' fill='$fill' text-anchor='$anchor'><tspan x='$x' y='$y'>$(Esc $txt)</tspan></text>"
}
function HANDLE($x,$y,$fill,$op,$anchor){
  "<text font-family='JK' font-weight='700' font-size='30' letter-spacing='0.3' fill='$fill' fill-opacity='$op' text-anchor='$anchor'><tspan x='$x' y='$y'>@drafrancinealmeida</tspan></text>"
}
# brand bar: dark=$true -> light text on dark photo
function BRAND($n,$dark){
  if($dark){ $c1='#FFFFFF'; $o1='0.55'; $o2='0.32'; $pillBg='#FFFFFF'; $pillBo='0.10'; $pillT='#FFFFFF'; $pillTo='0.6' }
  else     { $c1='#0F0D0C'; $o1='0.50'; $o2='0.30'; $pillBg='#5C4033'; $pillBo='0.12'; $pillT='#0F0D0C'; $pillTo='0.5' }
  $s =  "<text font-family='JK' font-weight='700' font-size='24' letter-spacing='2' fill='$c1'><tspan x='64' y='72' fill-opacity='$o1'>DRA. FRANCINE ALMEIDA</tspan><tspan fill-opacity='$o2'> &#183; HARMONIZA&#199;&#195;O FACIAL</tspan></text>"
  $s += "<rect x='952' y='40' width='64' height='40' rx='20' fill='$pillBg' fill-opacity='$pillBo'/>"
  $s += "<text font-family='JK' font-weight='700' font-size='22' fill='$pillT' fill-opacity='$pillTo' text-anchor='middle'><tspan x='984' y='68'>$n/7</tspan></text>"
  $s
}

# ---------- per-slide content (returns body markup, no defs/photo) ----------
$PD='#5C4033'; $P='#8B6E5A'; $PL='#D4A8A0'; $cream='#FAF6F2'
$bodyDark='#0F0D0C'; $bodyOp='0.62'
$slides = @{}

# S1 cover (dark)
$s=@()
$s += "<rect x='0' y='0' width='1080' height='1350' fill='url(#scrimDark)'/>"
$s += (BRAND 1 $true)
$s += (HL @('O MOUNJARO') 64 874 0 128 '#FFFFFF' '1' 'start' '-3')
$s += "<rect x='64' y='905' width='452' height='78' rx='4' fill='$P'/>"
$s += "<text font-family='PF' font-weight='800' font-size='46' letter-spacing='4' fill='#FFFFFF'><tspan x='88' y='962'>DERRETE O SEU</tspan></text>"
$s += (HL @('ROSTO?') 64 1095 0 128 $PL '1' 'start' '-3')
$s += (HANDLE 64 1290 '#FFFFFF' '1' 'start')
$slides['MJ_01_capa']=@{dark=$true; body=($s -join "`n")}

# S2 entenda (light, top-left)
$s=@()
$s += "<rect x='0' y='0' width='1080' height='1350' fill='url(#scrimTop)'/>"
$s += (BRAND 2 $false)
$s += (TAG 'ENTENDA' 64 168 $P 'start')
$s += (HL @('O CHAMADO','"MOUNJARO FACE"') 64 270 86 88 $PD '1' 'start' '-1')
$s += (BODY @('O emagrecimento r&#225;pido esvazia a','gordura que d&#225; sustenta&#231;&#227;o e','contorno ao rosto.') 64 462 50 37 $bodyDark $bodyOp 'start' '-0.2')
$s += (HANDLE 64 1290 $P '1' 'start')
$slides['MJ_02_entenda']=@{dark=$false; body=($s -join "`n")}

# S3 acontece (light, bottom-right)
$s=@()
$s += "<rect x='0' y='0' width='1080' height='1350' fill='url(#scrimBot)'/>"
$s += (BRAND 3 $false)
$s += (TAG 'O QUE ACONTECE' 1016 771 $P 'end')
$s += (HL @('A FACE PERDE','VOLUME E SUPORTE') 1016 873 86 88 $PD '1' 'end' '-1')
$s += (BODY @('Bochechas fundas, olhar cansado,','contorno fl&#225;cido &#8212; o rosto','parece envelhecer anos.') 1016 1036 50 37 $bodyDark $bodyOp 'end' '-0.2')
$s += (HANDLE 64 1290 $P '1' 'start')
$slides['MJ_03_acontece']=@{dark=$false; body=($s -join "`n")}

# S4 naoeculpa (light, top-right)
$s=@()
$s += "<rect x='0' y='0' width='1080' height='1350' fill='url(#scrimTop)'/>"
$s += (BRAND 4 $false)
$s += (TAG 'IMPORTANTE' 1016 168 $P 'end')
$s += (HL @('O PROBLEMA N&#195;O','&#201; EMAGRECER') 1016 270 86 88 $PD '1' 'end' '-1')
$s += (BODY @('&#201; emagrecer r&#225;pido demais. O','rosto n&#227;o acompanha a','velocidade do corpo.') 1016 462 50 37 $bodyDark $bodyOp 'end' '-0.2')
$s += (HANDLE 64 1290 $P '1' 'start')
$slides['MJ_04_naoeculpa']=@{dark=$false; body=($s -join "`n")}

# S5 solucao (light, bottom-left)
$s=@()
$s += "<rect x='0' y='0' width='1080' height='1350' fill='url(#scrimBot)'/>"
$s += (BRAND 5 $false)
$s += (TAG 'O QUE FAZEMOS' 64 771 $P 'start')
$s += (HL @('D&#193; PARA DEVOLVER','O QUE SE PERDEU') 64 873 86 88 $PD '1' 'start' '-1')
$s += (BODY @('O &#225;cido hialur&#244;nico rep&#245;e o volume','e o bioestimulador reativa o seu','col&#225;geno.') 64 1036 50 37 $bodyDark $bodyOp 'start' '-0.2')
$s += (HANDLE 1016 1290 $P '1' 'end')
$slides['MJ_05_solucao']=@{dark=$false; body=($s -join "`n")}

# S6 principio (light, top-left)
$s=@()
$s += "<rect x='0' y='0' width='1080' height='1350' fill='url(#scrimTop)'/>"
$s += (BRAND 6 $false)
$s += (TAG 'O PRINC&#205;PIO' 64 168 $P 'start')
$s += (HL @('EMAGRECER N&#195;O','PRECISA ENVELHECER') 64 270 86 88 $PD '1' 'start' '-1')
$s += (BODY @('Com planejamento, o rosto acompanha','a sua nova fase &#8212; com leveza e','naturalidade.') 64 462 50 37 $bodyDark $bodyOp 'start' '-0.2')
$s += (HANDLE 64 1290 $P '1' 'start')
$slides['MJ_06_principio']=@{dark=$false; body=($s -join "`n")}

# S7 cta (dark)
$s=@()
$s += "<rect x='0' y='0' width='1080' height='1350' fill='url(#scrimDark)'/>"
$s += (BRAND 7 $true)
$s += (TAG 'O PR&#211;XIMO PASSO' 64 858 $PL 'start')
$s += (HL @('RECUPERE O','SEU ROSTO') 64 958 92 96 '#FFFFFF' '1' 'start' '-1')
$s += (BODY @('Planejamento facial para quem emagreceu,','com produtos absorv&#237;veis e seguran&#231;a.') 64 1130 48 34 '#FFFFFF' '0.72' 'start' '-0.2')
$s += "<text font-family='JK' font-weight='800' font-size='36' fill='#FFFFFF'><tspan x='64' y='1252'>Agende sua avalia&#231;&#227;o</tspan></text>"
$s += (HANDLE 64 1298 '#FFFFFF' '0.6' 'start')
$slides['MJ_07_cta']=@{dark=$true; body=($s -join "`n")}

# ---------- write + render ----------
$order = 'MJ_01_capa','MJ_02_entenda','MJ_03_acontece','MJ_04_naoeculpa','MJ_05_solucao','MJ_06_principio','MJ_07_cta'
function RenderPng($svgInline,$pngPath,$transparent,$bg){
  if($transparent){ $bodybg='transparent'; $extra="--default-background-color=00000000" }
  else { $bodybg=$bg; $extra='' }
  $html="<!DOCTYPE html><html><head><meta charset='utf-8'><style>*{margin:0;padding:0}html,body{width:1080px;height:1350px;overflow:hidden;background:$bodybg}svg{display:block}</style></head><body>$svgInline</body></html>"
  [IO.File]::WriteAllText("$out\_render.html",$html,$enc)
  $udd="$env:TEMP\chrome_mj_$(Get-Random)"
  $fileUrl="file:///"+($out -replace '\\','/')+"/_render.html"
  $cargs=@("--headless=new","--disable-gpu","--no-sandbox","--hide-scrollbars","--force-device-scale-factor=1","--window-size=1080,1350","--screenshot=$pngPath","--user-data-dir=$udd")
  if($extra){ $cargs+=$extra }
  $cargs+=$fileUrl
  $p=Start-Process -FilePath $chrome -ArgumentList $cargs -PassThru -Wait -WindowStyle Hidden
  return $p.ExitCode
}

foreach($k in $order){
  $sl=$slides[$k]
  # overlay SVG (transparent, no photo)
  $svg="<?xml version='1.0' encoding='UTF-8'?>`n<svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='1080' height='1350' viewBox='0 0 1080 1350'>`n$DEFS`n$($sl.body)`n</svg>"
  [IO.File]::WriteAllText("$out\$k.svg",$svg,$enc)
  $svgInline=$svg -replace '<\?xml[^>]*\?>',''
  # transparent overlay PNG (Canva-safe)
  $e1=RenderPng $svgInline "$out\${k}_overlay.png" $true ''
  # check PNG over grey so I can see it
  $cbg= if($sl.dark){'#6b5d55'} else {'#b9a99b'}
  $e2=RenderPng $svgInline "$out\_check_$k.png" $false $cbg
  "{0}  ov:{1} chk:{2}  svg {3:N0}b" -f $k,$e1,$e2,(Get-Item "$out\$k.svg").Length
}

# slide-1 WITH photo embedded (ready to post)
$sl=$slides['MJ_01_capa']
$photo="<image x='0' y='0' width='1080' height='1350' preserveAspectRatio='xMidYMid slice' xlink:href='data:image/jpeg;base64,$IMG1'/>"
$svg="<?xml version='1.0' encoding='UTF-8'?>`n<svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='1080' height='1350' viewBox='0 0 1080 1350'>`n$DEFS`n$photo`n$($sl.body)`n</svg>"
[IO.File]::WriteAllText("$out\MJ_01_capa_COM_FOTO.svg",$svg,$enc)
$svgInline=$svg -replace '<\?xml[^>]*\?>',''
$e=RenderPng $svgInline "$out\MJ_01_capa_COM_FOTO.png" $false '#000000'
"MJ_01_capa_COM_FOTO  render:$e  svg {0:N0}b" -f (Get-Item "$out\MJ_01_capa_COM_FOTO.svg").Length
"DONE -> $out"
