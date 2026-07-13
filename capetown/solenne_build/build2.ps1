param([string]$Src,[string]$Out,[string]$Preview)
$base = 'C:\Users\joaog\ippo-universo\capetown\solenne_build'
$chrome = 'C:\Program Files\Google\Chrome\Application\chrome.exe'
$img = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\bc_skyline.jpg"))
$logo = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\A10_Logo_carvao.png"))
$t = [IO.File]::ReadAllText($Src)
$t = $t.Replace('__A10__',$logo).Replace('__IMG__',$img)
$enc = New-Object System.Text.UTF8Encoding($false)
[IO.File]::WriteAllText($Out,$t,$enc)
$svgUri = ($Out -replace '\\','/')
$wrap = "$base\_w2.html"
"<!doctype html><html><head><meta charset='utf-8'><style>html,body{margin:0;padding:0}img{display:block;width:1080px;height:1350px}</style></head><body><img src='file:///$svgUri'></body></html>" | Set-Content -Encoding UTF8 $wrap
if(Test-Path $Preview){ Remove-Item $Preview -Force }
$udd = "$base\udd_" + (Get-Random)
& $chrome --headless --disable-gpu --hide-scrollbars --force-device-scale-factor=1 --default-background-color=00000000 --screenshot="$Preview" --window-size="1080,1350" --user-data-dir="$udd" $wrap 2>$null | Out-Null
Start-Sleep -Milliseconds 700
if(Test-Path $Preview){ "OK $Preview $((Get-Item $Preview).Length) bytes" } else { "FAIL" }
