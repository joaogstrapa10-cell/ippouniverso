$base = "C:\Users\joaog\ippo-universo\EMPREENDIMENTOS A10"
$chrome = "C:\Program Files\Google\Chrome\Application\chrome.exe"

function Preview($svg,$w,$h){
  $png = $svg -replace '\.svg$','_preview.png'
  $udd = Join-Path $env:TEMP ("cr_" + [Guid]::NewGuid().ToString("N"))
  & $chrome --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 --user-data-dir="$udd" --window-size="$w,$h" --virtual-time-budget=15000 --screenshot="$png" ([Uri]$svg).AbsoluteUri
  "PV " + (Split-Path $png -Leaf)
}

Preview (Join-Path $base "PatioEstaleiro_Navy_Combo_Feed_1080x1350.svg")    1080 1350
Preview (Join-Path $base "PatioEstaleiro_Navy_Combo_Stories_1080x1920.svg") 1080 1920
Preview (Join-Path $base "PatioEstaleiro_Navy_Fin_Feed_1080x1350.svg")      1080 1350
Preview (Join-Path $base "PatioEstaleiro_Navy_Fin_Stories_1080x1920.svg")   1080 1920
"DONE"
