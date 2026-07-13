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
  @{n='CT3_01_capa';      tok='__IMG_1__'; img='mj1.jpg'},
  @{n='CT3_02_entenda';   tok='__IMG_2__'; img='mj2.jpg'},
  @{n='CT3_03_acontece';  tok='__IMG_3__'; img='mj3.jpg'},
  @{n='CT3_04_naoeculpa'; tok='__IMG_4__'; img='mj4.jpg'},
  @{n='CT3_05_solucao';   tok='__IMG_5__'; img='mj5.jpg'},
  @{n='CT3_06_principio'; tok='__IMG_6__'; img='mj6.jpg'},
  @{n='CT3_07_cta';       tok='__IMG_7__'; img='mj7.jpg'}
)

foreach($it in $items){
  $n = $it.n
  $t = [IO.File]::ReadAllText("$dir\${n}_src.svg", $enc)
  $t = $t.Replace('__FONT_SERIF__',$serif).Replace('__FONT_REG__',$reg).Replace('__FONT_SEMI__',$semi)
  $imgPath = "$id\$($it.img)"
  if($it.tok -ne ''){
    if(Test-Path $imgPath){ $t = $t.Replace($it.tok, (b64 $imgPath)) }
    else { $t = $t -replace ('<image[^>]*' + [regex]::Escape($it.tok) + '[^>]*/>'), '' }  # sem foto: remove o <image> (area limpa)
  }
  [IO.File]::WriteAllText("$dir\$n.svg", $t, $enc)
  $svgInline = $t -replace '<\?xml[^>]*\?>',''
  $html = "<!DOCTYPE html><html><head><meta charset='utf-8'><style>*{margin:0;padding:0}html,body{width:1080px;height:1350px;overflow:hidden}svg{display:block}</style></head><body>$svgInline</body></html>"
  [IO.File]::WriteAllText("$dir\_render.html", $html, $enc)
  $udd = "$env:TEMP\chrome_ct_$(Get-Random)"
  $fileUrl = "file:///" + ($dir -replace '\\','/') + "/_render.html"
  $p = Start-Process -FilePath $chrome -ArgumentList @("--headless=new","--disable-gpu","--no-sandbox","--hide-scrollbars","--force-device-scale-factor=1","--window-size=1080,1350","--screenshot=$dir\${n}_preview.png","--user-data-dir=$udd",$fileUrl) -PassThru -Wait -WindowStyle Hidden
  "{0}  exit {1}  svg {2:N0}b  png {3:N0}b" -f $n,$p.ExitCode,(Get-Item "$dir\$n.svg").Length,(Get-Item "$dir\${n}_preview.png" -ErrorAction SilentlyContinue).Length
}
