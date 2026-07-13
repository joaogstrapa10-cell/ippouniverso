Add-Type -AssemblyName System.Drawing
$strs = @([string]([char]72+[char]105+[char]115+[char]116+[char]243+[char]114+[char]105+[char]97),
          'que constr'+[char]243+'i',
          'significado')
function measure($ttf){
  $pfc=New-Object System.Drawing.Text.PrivateFontCollection
  $pfc.AddFontFile($ttf)
  $fam=$pfc.Families[0]
  $style=[System.Drawing.FontStyle]::Regular
  foreach($st in @([System.Drawing.FontStyle]::Regular,[System.Drawing.FontStyle]::Bold)){ if($fam.IsStyleAvailable($st)){ $style=$st; break } }
  $font=New-Object System.Drawing.Font($fam,200.0,$style)
  $bmp=New-Object System.Drawing.Bitmap 10,10
  $g=[System.Drawing.Graphics]::FromImage($bmp)
  $sf=[System.Drawing.StringFormat]::GenericTypographic
  $out=@()
  foreach($s in $strs){ $sz=$g.MeasureString($s,$font,2147483647,$sf); $out += [math]::Round($sz.Width,1) }
  $g.Dispose();$bmp.Dispose();$font.Dispose()
  ,$out
}
$dir="C:\Users\joaog\ippo-universo\capetown\fonts"
foreach($f in 'Poppins-SemiBold.ttf','Montserrat-SemiBold.ttf'){
  try{
    $r=measure "$dir\$f"
    '{0}:  L1={1} L2={2} L3={3}  | L1/L2={4:N3}  L3/L2={5:N3}' -f $f,$r[0],$r[1],$r[2],($r[0]/$r[1]),($r[2]/$r[1])
  }catch{ "ERR $f : $($_.Exception.Message)" }
}
'SOURCE ratios:                                          | L1/L2=0.606  L3/L2=0.995'
