$ErrorActionPreference = "Stop"
$base = "C:\Users\joaog\ippo-universo\EMPREENDIMENTOS A10"
$chrome = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$enc = New-Object System.Text.UTF8Encoding($false)

function Build($tplPath, $outPath, $imgPath, $repl) {
  $t = [IO.File]::ReadAllText($tplPath)
  foreach ($k in $repl.Keys) { $t = $t.Replace($k, $repl[$k]) }
  $b64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes($imgPath))
  $t = [Text.RegularExpressions.Regex]::Replace($t, '(?<=base64,)__IMG__', { param($m) $b64 })
  [IO.File]::WriteAllText($outPath, $t, $enc)
  Write-Output ("OK  {0}  ({1:N0} KB)" -f (Split-Path $outPath -Leaf), ((Get-Item $outPath).Length/1KB))
}

function Preview($svgPath, $w, $h) {
  $png = [IO.Path]::ChangeExtension($svgPath, $null) + "preview.png"
  $png = $svgPath -replace '\.svg$', '_preview.png'
  $name = Split-Path $svgPath -Leaf
  $html = Join-Path $env:TEMP ("pv_" + [IO.Path]::GetFileNameWithoutExtension($svgPath) + ".html")
  $uri = ([Uri]$svgPath).AbsoluteUri
  "<html><body style='margin:0'><img src='$uri' style='width:${w}px;height:${h}px;display:block'></body></html>" | Out-File $html -Encoding utf8
  $udd = Join-Path $env:TEMP ("cr_" + [Guid]::NewGuid().ToString("N"))
  & $chrome --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 `
    --user-data-dir="$udd" --window-size="$w,$h" --default-background-color=00000000 `
    --screenshot="$png" ([Uri]$html).AbsoluteUri 2>$null | Out-Null
  Remove-Item $udd -Recurse -Force -ErrorAction SilentlyContinue
  if (Test-Path $png) { Write-Output ("    preview {0} ({1:N0} KB)" -f (Split-Path $png -Leaf), ((Get-Item $png).Length/1KB)) }
}

$tplF = Join-Path $base "_tpl_patio_feed.svg"
$tplS = Join-Path $base "_tpl_patio_stories.svg"
$imgBrisa = "C:\Users\joaog\Downloads\casa brisa.jpg"
$imgMar   = "C:\Users\joaog\Downloads\wmremove-transformed (1).jpeg"

$amenPriv = "Living &#183; Cozinha &#183; Deck &#183; Piscina privativa &#8212; integrados"
$amenMar  = "Living &#183; Cozinha &#183; Adega &#183; Deck &#183; Piscina privativa"

# CASA BRISA
$brisa = @{ "__NAME__"="Brisa"; "__AREA__"="350"; "__SUITES__"="5"; "__PRICE__"="6.890.000,00" }
Build $tplF (Join-Path $base "PatioEstaleiro_Brisa_Feed_1080x1350.svg")     $imgBrisa $brisa
Build $tplS (Join-Path $base "PatioEstaleiro_Brisa_Stories_1080x1920.svg")  $imgBrisa $brisa

# CASA MAR (4 suites, +adega)
$mar = @{ "__NAME__"="Mar"; "__AREA__"="402"; "__SUITES__"="4"; "__PRICE__"="11.650.000,00"; $amenPriv=$amenMar }
Build $tplF (Join-Path $base "PatioEstaleiro_Mar_Feed_1080x1350.svg")     $imgMar $mar
Build $tplS (Join-Path $base "PatioEstaleiro_Mar_Stories_1080x1920.svg")  $imgMar $mar

# previews
Preview (Join-Path $base "PatioEstaleiro_Brisa_Feed_1080x1350.svg")    1080 1350
Preview (Join-Path $base "PatioEstaleiro_Brisa_Stories_1080x1920.svg") 1080 1920
Preview (Join-Path $base "PatioEstaleiro_Mar_Feed_1080x1350.svg")      1080 1350
Preview (Join-Path $base "PatioEstaleiro_Mar_Stories_1080x1920.svg")   1080 1920
Write-Output "DONE"
