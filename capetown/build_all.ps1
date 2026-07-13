$dir = 'C:\Users\joaog\ippo-universo\capetown'
$fd  = "$dir\fonts"
$id  = "$dir\img"
function b64($p){ [Convert]::ToBase64String([IO.File]::ReadAllBytes($p)) }
$serif = b64 "$fd\PlayfairDisplay.ttf"
$reg  = b64 "$fd\Poppins-Regular.ttf"
$semi = b64 "$fd\Poppins-SemiBold.ttf"
$enc  = New-Object System.Text.UTF8Encoding($false)
$chrome = "C:\Program Files\Google\Chrome\Application\chrome.exe"

$items = @(
  @{n='CT2_01_capa';       tok='__IMG_1__'; img='m1.jpg'},
  @{n='CT2_02_claro';      tok='__IMG_2__'; img='m2.jpg'},
  @{n='CT2_03_decisao';    tok='__IMG_3__'; img='m3.jpg'},
  @{n='CT2_04_excecao';    tok='__IMG_4__'; img='m4.jpg'},
  @{n='CT2_05_absorvivel'; tok='__IMG_5__'; img='m5.jpg'},
  @{n='CT2_06_escuro';     tok='__IMG_6__'; img='m6.jpg'},
  @{n='CT2_07_cta';        tok='__IMG_7__'; img='m7.jpg'}
)

foreach($it in $items){
  $n = $it.n
  $t = [IO.File]::ReadAllText("$dir\${n}_src.svg", $enc)
  $t = $t.Replace('__FONT_SERIF__',$serif).Replace('__FONT_REG__',$reg).Replace('__FONT_SEMI__',$semi)
  if($it.tok -ne ''){ $t = $t.Replace($it.tok, (b64 "$id\$($it.img)")) }
  [IO.File]::WriteAllText("$dir\$n.svg", $t, $enc)
  $svgInline = $t -replace '<\?xml[^>]*\?>',''
  $html = "<!DOCTYPE html><html><head><meta charset='utf-8'><style>*{margin:0;padding:0}html,body{width:1080px;height:1350px;overflow:hidden}svg{display:block}</style></head><body>$svgInline</body></html>"
  [IO.File]::WriteAllText("$dir\_render.html", $html, $enc)
  $udd = "$env:TEMP\chrome_ct_$(Get-Random)"
  $fileUrl = "file:///" + ($dir -replace '\\','/') + "/_render.html"
  $p = Start-Process -FilePath $chrome -ArgumentList @("--headless=new","--disable-gpu","--no-sandbox","--hide-scrollbars","--force-device-scale-factor=1","--window-size=1080,1350","--screenshot=$dir\${n}_preview.png","--user-data-dir=$udd",$fileUrl) -PassThru -Wait -WindowStyle Hidden
  "{0}  exit {1}  svg {2:N0}b  png {3:N0}b" -f $n,$p.ExitCode,(Get-Item "$dir\$n.svg").Length,(Get-Item "$dir\${n}_preview.png" -ErrorAction SilentlyContinue).Length
}
