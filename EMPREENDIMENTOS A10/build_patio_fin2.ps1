$base = "C:\Users\joaog\ippo-universo\EMPREENDIMENTOS A10"
$b64dir = $args[0]
if (-not $b64dir) { $b64dir = $base }
$chrome = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$enc = New-Object System.Text.UTF8Encoding($false)

$mar   = [IO.File]::ReadAllText("$b64dir\mar.b64")
$brisa = [IO.File]::ReadAllText("$b64dir\brisa.b64")
$logo  = [IO.File]::ReadAllText("$b64dir\patio_white.b64")
$a10   = [IO.File]::ReadAllText("$b64dir\a10.b64")
$r21   = [IO.File]::ReadAllText("$b64dir\r21.b64")

function Build($tpl,$out){
  $t = [IO.File]::ReadAllText($tpl)
  $t = $t.Replace('@@MAR@@',$mar).Replace('@@BRISA@@',$brisa).Replace('@@LOGO@@',$logo).Replace('@@A10@@',$a10).Replace('@@R21@@',$r21)
  [IO.File]::WriteAllText($out,$t,$enc); "OK " + (Split-Path $out -Leaf)
}
function Preview($svg,$w,$h){
  $png = $svg -replace '\.svg$','_preview.png'
  $html = Join-Path $env:TEMP ("pv_" + [IO.Path]::GetFileNameWithoutExtension($svg) + ".html")
  "<html><body style='margin:0'><img src='$(([Uri]$svg).AbsoluteUri)' style='width:${w}px;height:${h}px;display:block'></body></html>" | Out-File $html -Encoding utf8
  $udd = Join-Path $env:TEMP ("cr_" + [Guid]::NewGuid().ToString("N"))
  & $chrome --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 --user-data-dir="$udd" --window-size="$w,$h" --screenshot="$png" ([Uri]$html).AbsoluteUri
}

Build (Join-Path $base "_tpl_patio_fin2_feed.svg")    (Join-Path $base "PatioEstaleiro_Financiamento_v2_Feed_1080x1350.svg")
Build (Join-Path $base "_tpl_patio_fin2_stories.svg") (Join-Path $base "PatioEstaleiro_Financiamento_v2_Stories_1080x1920.svg")

Preview (Join-Path $base "PatioEstaleiro_Financiamento_v2_Feed_1080x1350.svg")    1080 1350
Preview (Join-Path $base "PatioEstaleiro_Financiamento_v2_Stories_1080x1920.svg") 1080 1920
"DONE"
