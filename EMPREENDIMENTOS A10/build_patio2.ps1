$base = "C:\Users\joaog\ippo-universo\EMPREENDIMENTOS A10"
$chrome = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$enc = New-Object System.Text.UTF8Encoding($false)
$b64Mar   = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\_mar_hero.jpg"))
$b64Brisa = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\_brisa_hero.jpg"))

function BuildSolo($tpl,$out,$b64,$repl){
  $t=[IO.File]::ReadAllText($tpl)
  foreach($k in $repl.Keys){ $t=$t.Replace($k,$repl[$k]) }
  $t=[Text.RegularExpressions.Regex]::Replace($t,'(?<=base64,)__IMG__',{ param($mm) $b64 })
  [IO.File]::WriteAllText($out,$t,$enc); "OK "+(Split-Path $out -Leaf)
}
function BuildCombo($tpl,$out){
  $t=[IO.File]::ReadAllText($tpl)
  $t=[Text.RegularExpressions.Regex]::Replace($t,'(?<=base64,)__IMG1__',{ param($mm) $b64Mar })
  $t=[Text.RegularExpressions.Regex]::Replace($t,'(?<=base64,)__IMG2__',{ param($mm) $b64Brisa })
  [IO.File]::WriteAllText($out,$t,$enc); "OK "+(Split-Path $out -Leaf)
}
function Preview($svg,$w,$h){
  $png=$svg -replace '\.svg$','_preview.png'
  $html=Join-Path $env:TEMP ("pv_"+[IO.Path]::GetFileNameWithoutExtension($svg)+".html")
  "<html><body style='margin:0'><img src='$(([Uri]$svg).AbsoluteUri)' style='width:${w}px;height:${h}px;display:block'></body></html>" | Out-File $html -Encoding utf8
  $udd=Join-Path $env:TEMP ("cr_"+[Guid]::NewGuid().ToString("N"))
  & $chrome --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 --user-data-dir="$udd" --window-size="$w,$h" --screenshot="$png" ([Uri]$html).AbsoluteUri
}

$tplF=Join-Path $base "_tpl_patio_feed.svg"
$tplS=Join-Path $base "_tpl_patio_stories.svg"
$amenDef="Living &#183; Cozinha &#183; Deck &#183; Piscina privativa &#8212; integrados"
$amenMar="Living &#183; Cozinha &#183; Adega &#183; Deck &#183; Piscina privativa"

$mar=@{ "__NAME__"="Mar"; "__AREA__"="402"; "__SUITES__"="4"; "__PRICE__"="11.650.000,00"; $amenDef=$amenMar }
BuildSolo $tplF (Join-Path $base "PatioEstaleiro_Mar_Feed_1080x1350.svg")    $b64Mar $mar
BuildSolo $tplS (Join-Path $base "PatioEstaleiro_Mar_Stories_1080x1920.svg") $b64Mar $mar

$brisa=@{ "__NAME__"="Brisa"; "__AREA__"="350"; "__SUITES__"="5"; "__PRICE__"="6.890.000,00" }
BuildSolo $tplF (Join-Path $base "PatioEstaleiro_Brisa_Feed_1080x1350.svg")    $b64Brisa $brisa
BuildSolo $tplS (Join-Path $base "PatioEstaleiro_Brisa_Stories_1080x1920.svg") $b64Brisa $brisa

BuildCombo (Join-Path $base "_tpl_patio_combo_feed.svg")    (Join-Path $base "PatioEstaleiro_Combo_Feed_1080x1350.svg")
BuildCombo (Join-Path $base "_tpl_patio_combo_stories.svg") (Join-Path $base "PatioEstaleiro_Combo_Stories_1080x1920.svg")

Preview (Join-Path $base "PatioEstaleiro_Mar_Feed_1080x1350.svg")      1080 1350
Preview (Join-Path $base "PatioEstaleiro_Mar_Stories_1080x1920.svg")   1080 1920
Preview (Join-Path $base "PatioEstaleiro_Brisa_Feed_1080x1350.svg")    1080 1350
Preview (Join-Path $base "PatioEstaleiro_Brisa_Stories_1080x1920.svg") 1080 1920
Preview (Join-Path $base "PatioEstaleiro_Combo_Feed_1080x1350.svg")    1080 1350
Preview (Join-Path $base "PatioEstaleiro_Combo_Stories_1080x1920.svg") 1080 1920
"DONE"
