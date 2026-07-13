$base = "C:\Users\joaog\ippo-universo\EMPREENDIMENTOS A10"
$chrome = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$enc = New-Object System.Text.UTF8Encoding($false)

$mar    = [IO.File]::ReadAllText("$base\mar_real.b64")
$brisar = [IO.File]::ReadAllText("$base\brisa_real.b64")
$brisaf = [IO.File]::ReadAllText("$base\brisa_foto.b64")
$logo   = [IO.File]::ReadAllText("$base\patio_white.b64")
$a10    = [IO.File]::ReadAllText("$base\a10.b64")
$r21    = [IO.File]::ReadAllText("$base\r21.b64")

function Build($tpl,$out){
  $t = [IO.File]::ReadAllText($tpl)
  $t = $t.Replace('@@MAR@@',$mar).Replace('@@BRISAR@@',$brisar).Replace('@@BRISAF@@',$brisaf).Replace('@@LOGO@@',$logo).Replace('@@A10@@',$a10).Replace('@@R21@@',$r21)
  [IO.File]::WriteAllText($out,$t,$enc); "OK " + (Split-Path $out -Leaf)
}
function Preview($svg,$w,$h){
  $png = $svg -replace '\.svg$','_preview.png'
  $html = Join-Path $env:TEMP ("pv_" + [IO.Path]::GetFileNameWithoutExtension($svg) + ".html")
  "<html><body style='margin:0'><img src='$(([Uri]$svg).AbsoluteUri)' style='width:${w}px;height:${h}px;display:block'></body></html>" | Out-File $html -Encoding utf8
  $udd = Join-Path $env:TEMP ("cr_" + [Guid]::NewGuid().ToString("N"))
  & $chrome --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 --user-data-dir="$udd" --window-size="$w,$h" --virtual-time-budget=12000 --screenshot="$png" ([Uri]$html).AbsoluteUri
}

Build (Join-Path $base "_tpl_patio_navy_combo_feed.svg")    (Join-Path $base "PatioEstaleiro_Navy_Combo_Feed_1080x1350.svg")
Build (Join-Path $base "_tpl_patio_navy_combo_stories.svg") (Join-Path $base "PatioEstaleiro_Navy_Combo_Stories_1080x1920.svg")
Build (Join-Path $base "_tpl_patio_navy_fin_feed.svg")      (Join-Path $base "PatioEstaleiro_Navy_Fin_Feed_1080x1350.svg")
Build (Join-Path $base "_tpl_patio_navy_fin_stories.svg")   (Join-Path $base "PatioEstaleiro_Navy_Fin_Stories_1080x1920.svg")

Preview (Join-Path $base "PatioEstaleiro_Navy_Combo_Feed_1080x1350.svg")    1080 1350
Preview (Join-Path $base "PatioEstaleiro_Navy_Combo_Stories_1080x1920.svg") 1080 1920
Preview (Join-Path $base "PatioEstaleiro_Navy_Fin_Feed_1080x1350.svg")      1080 1350
Preview (Join-Path $base "PatioEstaleiro_Navy_Fin_Stories_1080x1920.svg")   1080 1920
"DONE"
