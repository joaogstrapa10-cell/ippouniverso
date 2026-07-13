param(
  [string]$Family = 'Poppins',
  [string]$FontSemiFile = 'Poppins-SemiBold.ttf',
  [string]$FontRegFile  = 'Poppins-Regular.ttf',
  [double]$TitleSize = 139,
  [double]$TitleLS = -1,
  [double]$Y1 = 284, [double]$Y2 = 430, [double]$Y3 = 576,
  [double]$SubSize = 64,
  [double]$SY1 = 1199, [double]$SY2 = 1280,
  [string]$SubColor = '#E0C8A6',
  [string]$OutName = 'Capetown_Historia_Feed'
)
$dir = 'C:\Users\joaog\ippo-universo\capetown'
$fd  = "$dir\fonts"
function b64($p){ [Convert]::ToBase64String([IO.File]::ReadAllBytes($p)) }
$Hist = [char]72+[char]105+[char]115+[char]116+[char]243+[char]114+[char]105+[char]97   # História
$Constroi = 'que constr'+[char]243+'i'                                                  # que constrói
$Bullet = [char]8226                                                                    # •
$Res = 'Colline R'+[char]233+'sidences'                                                 # Colline Résidences
$svg = @"
<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="2544" height="1456" viewBox="0 0 2544 1456">
  <defs>
    <style type="text/css">
      @font-face{font-family:'$Family';font-style:normal;font-weight:400;src:url(data:font/ttf;base64,$(b64 "$fd\$FontRegFile")) format('truetype');}
      @font-face{font-family:'$Family';font-style:normal;font-weight:600;src:url(data:font/ttf;base64,$(b64 "$fd\$FontSemiFile")) format('truetype');}
      .ttl{font-family:'$Family',sans-serif;font-weight:600;fill:#FFFFFF;}
      .sub{font-family:'$Family',sans-serif;font-weight:400;fill:$SubColor;}
    </style>
    <clipPath id="p1"><rect x="1018" y="143" width="360" height="1170" rx="180" ry="132"/></clipPath>
    <clipPath id="p2"><rect x="1410" y="300" width="360" height="1156" rx="180" ry="132"/></clipPath>
    <clipPath id="p3"><rect x="1801" y="143" width="360" height="1169" rx="180" ry="132"/></clipPath>
    <clipPath id="p4"><rect x="2195" y="301" width="360" height="1155" rx="180" ry="132"/></clipPath>
  </defs>
  <rect id="bg" width="2544" height="1456" fill="#0F162A"/>
  <g id="pilar-1" clip-path="url(#p1)"><image x="1014" y="139" width="368" height="1178" xlink:href="data:image/jpeg;base64,$(b64 "$dir\pillimg_1.jpg")"/></g>
  <g id="pilar-2" clip-path="url(#p2)"><image x="1406" y="296" width="368" height="1160" xlink:href="data:image/jpeg;base64,$(b64 "$dir\pillimg_2.jpg")"/></g>
  <g id="pilar-3" clip-path="url(#p3)"><image x="1797" y="139" width="368" height="1177" xlink:href="data:image/jpeg;base64,$(b64 "$dir\pillimg_3.jpg")"/></g>
  <g id="pilar-4" clip-path="url(#p4)"><image x="2191" y="297" width="353" height="1159" xlink:href="data:image/jpeg;base64,$(b64 "$dir\pillimg_4.jpg")"/></g>
  <text class="ttl" font-size="$TitleSize" letter-spacing="$TitleLS">
    <tspan x="118" y="$Y1">$Hist</tspan>
    <tspan x="118" y="$Y2">$Constroi</tspan>
    <tspan x="118" y="$Y3">significado</tspan>
  </text>
  <text class="sub" font-size="$SubSize">
    <tspan x="118" y="$SY1">Solenne $Bullet Quinta da Neve</tspan>
    <tspan x="118" y="$SY2">$Bullet $Res</tspan>
  </text>
</svg>
"@
$out="$dir\$OutName.svg"
[IO.File]::WriteAllText($out,$svg,(New-Object System.Text.UTF8Encoding($false)))
"wrote $out ({0:N0} bytes)" -f (Get-Item $out).Length
# render
$svgInline = $svg -replace '<\?xml[^>]*\?>',''
$html = "<!DOCTYPE html><html><head><meta charset='utf-8'><style>*{margin:0;padding:0}html,body{width:2544px;height:1456px;overflow:hidden}svg{display:block}</style></head><body>$svgInline</body></html>"
[IO.File]::WriteAllText("$dir\render.html",$html,(New-Object System.Text.UTF8Encoding($false)))
$udd="$env:TEMP\chrome_ct_$(Get-Random)"
$fileUrl="file:///"+($dir -replace '\\','/')+"/render.html"
$p=Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList @("--headless=new","--disable-gpu","--no-sandbox","--hide-scrollbars","--force-device-scale-factor=1","--window-size=2544,1456","--screenshot=$dir\$OutName`_preview.png","--user-data-dir=$udd",$fileUrl) -PassThru -Wait -RedirectStandardError "$dir\chromeerr.txt" -WindowStyle Hidden
"render exit $($p.ExitCode); preview $((Get-Item "$dir\$OutName`_preview.png" -ErrorAction SilentlyContinue).Length) bytes"
