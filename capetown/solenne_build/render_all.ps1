$base = 'C:\Users\joaog\ippo-universo\capetown\solenne_build'
$out  = 'C:\Users\joaog\ippo-universo\capetown'
$chrome = 'C:\Program Files\Google\Chrome\Application\chrome.exe'
$jobs = @(
  @{ svg="$out\BalnearioCamboriu_Mercado_Feed_1080x1350.svg";      png="$base\pv_Mercado_Feed.png";      w=1080; h=1350 }
  @{ svg="$out\BalnearioCamboriu_Mercado_Stories_1080x1920.svg";   png="$base\pv_Mercado_Stories.png";   w=1080; h=1920 }
  @{ svg="$out\BalnearioCamboriu_Escassez_Feed_1080x1350.svg";     png="$base\pv_Escassez_Feed.png";     w=1080; h=1350 }
  @{ svg="$out\BalnearioCamboriu_Escassez_Stories_1080x1920.svg";  png="$base\pv_Escassez_Stories.png";  w=1080; h=1920 }
  @{ svg="$out\BalnearioCamboriu_Patrimonio_Feed_1080x1350.svg";   png="$base\pv_Patrimonio_Feed.png";   w=1080; h=1350 }
  @{ svg="$out\BalnearioCamboriu_Patrimonio_Stories_1080x1920.svg";png="$base\pv_Patrimonio_Stories.png";w=1080; h=1920 }
)
foreach($j in $jobs){
  $svgUri = ($j.svg -replace '\\','/')
  $wrap = "$base\_w.html"
  "<!doctype html><html><head><meta charset='utf-8'><style>html,body{margin:0;padding:0}img{display:block;width:$($j.w)px;height:$($j.h)px}</style></head><body><img src='file:///$svgUri'></body></html>" | Set-Content -Encoding UTF8 $wrap
  if(Test-Path $j.png){ Remove-Item $j.png -Force }
  $udd = "$base\udd_" + (Get-Random)
  & $chrome --headless --disable-gpu --hide-scrollbars --force-device-scale-factor=1 --default-background-color=00000000 --screenshot="$($j.png)" --window-size="$($j.w),$($j.h)" --user-data-dir="$udd" $wrap 2>$null | Out-Null
  Start-Sleep -Milliseconds 600
  if(Test-Path $j.png){ "OK  $($j.png | Split-Path -Leaf)  $((Get-Item $j.png).Length) bytes" } else { "FAIL $($j.png)" }
}
