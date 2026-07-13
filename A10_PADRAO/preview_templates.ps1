$base = "C:\Users\joaog\ippo-universo\A10_PADRAO"
$tpl  = "$base\templates"
$assets = "$base\assets"
$chrome = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$enc = New-Object System.Text.UTF8Encoding($false)

$a10gold  = [IO.File]::ReadAllText("$assets\a10.b64")
$a10dark  = [IO.File]::ReadAllText("$assets\a10_dark.b64")
$r21gold  = [IO.File]::ReadAllText("$assets\r21.b64")

function Preview($name,$w,$h){
  $svgPath = "$tpl\$name.svg"
  $t = [IO.File]::ReadAllText($svgPath)
  $t = $t.Replace('@@A10_GOLD@@',$a10gold).Replace('@@A10_DARK@@',$a10dark).Replace('@@PARCEIRO_GOLD@@',$r21gold).Replace('@@LOGO_EMPREENDIMENTO@@',$a10gold)
  $tmp = "$env:TEMP\_pv_$name.svg"
  [IO.File]::WriteAllText($tmp,$t,$enc)
  $png = "$base\exemplos\$name`_preview.png"
  $udd = Join-Path $env:TEMP ("cr_" + [Guid]::NewGuid().ToString("N"))
  & $chrome --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 --user-data-dir="$udd" --window-size="$w,$h" --virtual-time-budget=15000 --screenshot="$png" ([Uri]$tmp).AbsoluteUri
  "PV $name"
}

Preview "L1_Hero_Cream_Feed_1080x1350"          1080 1350
Preview "L1_Hero_Cream_Stories_1080x1920"       1080 1920
Preview "L2_Portfolio_Navy_Feed_1080x1350"      1080 1350
Preview "L3_Hero_FullBleed_Feed_1080x1350"      1080 1350
Preview "L3_Hero_FullBleed_Stories_1080x1920"   1080 1920
Preview "L4_PaymentConditions_Feed_1080x1350"   1080 1350
Preview "L4_PaymentConditions_Stories_1080x1920" 1080 1920
Preview "L5_PaymentCombo_Feed_1080x1350"        1080 1350
Preview "L5_PaymentCombo_Stories_1080x1920"     1080 1920
"DONE"
