Add-Type -AssemblyName System.Drawing
$base = 'C:\Users\joaog\ippo-universo\capetown\solenne_build'
$logoDir = 'C:\Users\joaog\ippo-universo\EMPREENDIMENTOS A10'

# ---------- 1) bbox-crop the Solenne render (remove white letterbox) ----------
$src = [System.Drawing.Bitmap]::FromFile("$base\solenne_raw.png")
$w = $src.Width; $h = $src.Height
$rect = New-Object System.Drawing.Rectangle 0,0,$w,$h
$data = $src.LockBits($rect,[System.Drawing.Imaging.ImageLockMode]::ReadOnly,[System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$stride = $data.Stride
$bytes = New-Object byte[] ($stride*$h)
[System.Runtime.InteropServices.Marshal]::Copy($data.Scan0,$bytes,0,$bytes.Length)
$src.UnlockBits($data)
$minX=$w; $minY=$h; $maxX=0; $maxY=0
for($y=0;$y -lt $h;$y++){
  $row=$y*$stride
  for($x=0;$x -lt $w;$x++){
    $i=$row+$x*4
    $b=$bytes[$i]; $g=$bytes[$i+1]; $r=$bytes[$i+2]
    if(-not($r -gt 248 -and $g -gt 248 -and $b -gt 248)){
      if($x -lt $minX){$minX=$x}; if($x -gt $maxX){$maxX=$x}
      if($y -lt $minY){$minY=$y}; if($y -gt $maxY){$maxY=$y}
    }
  }
}
"crop bbox: $minX,$minY -> $maxX,$maxY"
$cw=$maxX-$minX+1; $ch=$maxY-$minY+1
$crop=New-Object System.Drawing.Bitmap $cw,$ch
$gfx=[System.Drawing.Graphics]::FromImage($crop)
$gfx.DrawImage($src, (New-Object System.Drawing.Rectangle 0,0,$cw,$ch), (New-Object System.Drawing.Rectangle $minX,$minY,$cw,$ch), [System.Drawing.GraphicsUnit]::Pixel)
$gfx.Dispose(); $src.Dispose()
$enc=[System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object {$_.MimeType -eq 'image/jpeg'}
$ep=New-Object System.Drawing.Imaging.EncoderParameters 1
$ep.Param[0]=New-Object System.Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality, [long]92)
$crop.Save("$base\solenne.jpg",$enc,$ep)
$crop.Dispose()
"solenne.jpg = ${cw}x${ch}"

# ---------- 2) recolor A10 logo gold -> carvao (#2A2620), keep alpha ----------
function Recolor($inPath,$outPath,$cr,$cg,$cb){
  $b=[System.Drawing.Bitmap]::FromFile($inPath)
  $lw=$b.Width; $lh=$b.Height
  $r2=New-Object System.Drawing.Rectangle 0,0,$lw,$lh
  $d=$b.LockBits($r2,[System.Drawing.Imaging.ImageLockMode]::ReadWrite,[System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
  $st=$d.Stride
  $buf=New-Object byte[] ($st*$lh)
  [System.Runtime.InteropServices.Marshal]::Copy($d.Scan0,$buf,0,$buf.Length)
  for($p=0;$p -lt $buf.Length;$p+=4){
    if($buf[$p+3] -gt 0){ $buf[$p]=$cb; $buf[$p+1]=$cg; $buf[$p+2]=$cr }
  }
  [System.Runtime.InteropServices.Marshal]::Copy($buf,0,$d.Scan0,$buf.Length)
  $b.UnlockBits($d)
  $b.Save($outPath,[System.Drawing.Imaging.ImageFormat]::Png)
  $b.Dispose()
  "$outPath = ${lw}x${lh}"
}
Recolor "$logoDir\A10_Logo_gold.png" "$base\A10_Logo_carvao.png" 0x2A 0x26 0x20
Recolor "$logoDir\A10_Logo_gold.png" "$base\A10_Logo_cream.png" 0xF7 0xF2 0xEA
"done"
