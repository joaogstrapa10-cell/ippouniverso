Add-Type -AssemblyName System.Drawing
$ErrorActionPreference = 'Stop'

# ---------- CONFIG ----------
$W = 1080; $H = 1920
$work    = "C:\Users\joaog\ippo-universo\capetown"
$aptPath    = "C:\Users\joaog\Downloads\CAPE TOWN - ROBERTO PANDOLFO 13.jpg" # apartment interior (top)
$facadePath = "C:\Users\joaog\Downloads\CAPE TOWN - FACHADA DIURNA.jpg"      # facade close-up (bottom)
$overlayPath = "$work\overlay.png"
$outPath = "$work\final.png"

# Apartment panel (floating over the facade) - same size, clean thin gold hairline
$ratio  = 1600.0/868.0        # apartment image aspect (w/h)
$mx     = 34.0                # side margin
$cardX  = $mx
$cardW  = $W - 2*$mx          # 1012
$cardH  = $cardW / $ratio     # complete image, no crop
$cardY  = 44.0
$r      = 20.0

# ---------- HELPERS ----------
function New-Bitmap([int]$w,[int]$h){
  $b = New-Object System.Drawing.Bitmap $w,$h
  return $b
}
function Get-HQGraphics($bmp){
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.InterpolationMode = 'HighQualityBicubic'
  $g.PixelOffsetMode   = 'HighQuality'
  $g.SmoothingMode     = 'AntiAlias'
  $g.CompositingQuality= 'HighQuality'
  return $g
}
# draw $img covering dest rect. focusY: 0=top .. 0.5=center .. 1=bottom. zoom>=1 crops in.
function Draw-Cover($g,$img,[double]$dx,[double]$dy,[double]$dw,[double]$dh,[double]$focusY=0.5,[double]$zoom=1.0){
  $scale = [Math]::Max($dw/$img.Width, $dh/$img.Height) * $zoom
  $sw = $dw/$scale; $sh = $dh/$scale
  $sx = ($img.Width - $sw)/2.0
  $sy = ($img.Height - $sh) * $focusY
  if($sy -lt 0){$sy=0}; if($sy -gt ($img.Height-$sh)){$sy=$img.Height-$sh}
  $dest = New-Object System.Drawing.RectangleF ([float]$dx),([float]$dy),([float]$dw),([float]$dh)
  $srcR = New-Object System.Drawing.RectangleF ([float]$sx),([float]$sy),([float]$sw),([float]$sh)
  $g.DrawImage($img, $dest, $srcR, [System.Drawing.GraphicsUnit]::Pixel)
}
function New-RoundedPath([double]$x,[double]$y,[double]$w,[double]$h,[double]$r){
  $p = New-Object System.Drawing.Drawing2D.GraphicsPath
  $d = $r*2
  $p.AddArc([float]$x,[float]$y,[float]$d,[float]$d,180,90)
  $p.AddArc([float]($x+$w-$d),[float]$y,[float]$d,[float]$d,270,90)
  $p.AddArc([float]($x+$w-$d),[float]($y+$h-$d),[float]$d,[float]$d,0,90)
  $p.AddArc([float]$x,[float]($y+$h-$d),[float]$d,[float]$d,90,90)
  $p.CloseFigure()
  return $p
}

# ---------- BUILD ----------
$canvas = New-Bitmap $W $H
$g = Get-HQGraphics $canvas
$g.Clear([System.Drawing.Color]::FromArgb(255,12,23,34))   # #0C1722 base

# 1) Facade FULL-BLEED -> single cohesive background, edge to edge. The sky/building
#    fill behind the panel (harmonizes - no black), facade reads across the whole piece.
$facade = [System.Drawing.Image]::FromFile($facadePath)
Draw-Cover $g $facade 0 0 $W $H 0.5 1.0
$facade.Dispose()

# 1b) Subtle top vignette so the apartment panel reads cleanly (keeps the sky, not black)
$topRect = New-Object System.Drawing.RectangleF 0,0,$W,340
$tp = New-Object System.Drawing.Drawing2D.LinearGradientBrush $topRect, ([System.Drawing.Color]::White),([System.Drawing.Color]::White),90.0
$ctp = New-Object System.Drawing.Drawing2D.ColorBlend 2
$ctp.Colors = @([System.Drawing.Color]::FromArgb(70,9,17,26),[System.Drawing.Color]::FromArgb(0,9,17,26))
$ctp.Positions = @(0.0,1.0)
$tp.InterpolationColors = $ctp
$g.FillRectangle($tp,$topRect); $tp.Dispose()

# 1c) Very subtle unifying tint (keeps facade sharp, ties it to the warm interior)
$tint = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(12,12,23,34))
$g.FillRectangle($tint,(New-Object System.Drawing.RectangleF 0,0,$W,$H)); $tint.Dispose()

# 1d) Medium reading shadow at the bottom: copy reads perfectly, facade still visible.
$vRect = New-Object System.Drawing.RectangleF 0,0,$W,$H
$v = New-Object System.Drawing.Drawing2D.LinearGradientBrush $vRect, ([System.Drawing.Color]::White),([System.Drawing.Color]::White),90.0
$cv = New-Object System.Drawing.Drawing2D.ColorBlend 6
$cv.Colors = @(
  [System.Drawing.Color]::FromArgb(0,9,17,26),
  [System.Drawing.Color]::FromArgb(0,9,17,26),     # facade fully clear (building/bamboo/signage)
  [System.Drawing.Color]::FromArgb(110,9,17,26),
  [System.Drawing.Color]::FromArgb(205,9,17,26),    # location line / headline (strong shadow)
  [System.Drawing.Color]::FromArgb(240,9,17,26),
  [System.Drawing.Color]::FromArgb(255,9,17,26)
)
$cv.Positions = @(0.0, 0.48, 0.56, 0.63, 0.82, 1.0)
$v.InterpolationColors = $cv
$g.FillRectangle($v, $vRect)
$v.Dispose()

# 2) Apartment panel floating over the facade ------------------------------
# 2a) Soft, diffuse, realistic drop shadow (low-alpha expanding layers, offset down)
for($i=20; $i -ge 1; $i--){
  $exp = $i*1.7
  $sp = New-RoundedPath ($cardX-$exp) ($cardY-$exp*0.30+15) ($cardW+2*$exp) ($cardH+2*$exp) ($r+$exp*0.7)
  $a = [int](38 - $i*1.6); if($a -lt 0){$a=0}
  $sb = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb($a,0,0,0))
  $g.FillPath($sb,$sp); $sb.Dispose(); $sp.Dispose()
}
# 2b) Apartment image clipped to the rounded panel (complete - ratio matches exactly)
$apt = [System.Drawing.Image]::FromFile($aptPath)
$ip = New-RoundedPath $cardX $cardY $cardW $cardH $r
$g.SetClip($ip)
Draw-Cover $g $apt $cardX $cardY $cardW $cardH
$g.ResetClip(); $ip.Dispose()
$apt.Dispose()
# 2c) Clean thin gold hairline (brand stroke) - elegant, lets the image breathe
$framePath = New-RoundedPath $cardX $cardY $cardW $cardH $r
$goldPen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(225,198,168,118)), 1.8   # #C6A876
$g.DrawPath($goldPen,$framePath); $goldPen.Dispose(); $framePath.Dispose()

# 4) Overlay (text/icons/buttons)
$ov = [System.Drawing.Image]::FromFile($overlayPath)
$g.DrawImage($ov, (New-Object System.Drawing.Rectangle 0,0,$W,$H), 0,0,$ov.Width,$ov.Height, [System.Drawing.GraphicsUnit]::Pixel)
$ov.Dispose()

$g.Dispose()
$canvas.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
$canvas.Dispose()
Write-Host "Saved $outPath ($((Get-Item $outPath).Length) bytes)"
