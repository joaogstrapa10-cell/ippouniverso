# Uso: .\render_preview.ps1 "caminho\da\peca.svg" 1080 1350
# Gera um PNG "<nome>_preview.png" na mesma pasta do SVG, com as fontes (Google Fonts) já carregadas.
param(
  [Parameter(Mandatory=$true)][string]$SvgPath,
  [Parameter(Mandatory=$true)][int]$Width,
  [Parameter(Mandatory=$true)][int]$Height
)
$chrome = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$full = (Resolve-Path $SvgPath).Path
$png = $full -replace '\.svg$','_preview.png'
$udd = Join-Path $env:TEMP ("cr_" + [Guid]::NewGuid().ToString("N"))
& $chrome --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 --user-data-dir="$udd" --window-size="$Width,$Height" --virtual-time-budget=15000 --screenshot="$png" ([Uri]$full).AbsoluteUri
Write-Output "Preview: $png"
