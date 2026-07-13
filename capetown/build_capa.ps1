param(
  [int]$PW = 1540,   # largura da foto em px (zoom)
  [int]$PT = 70,     # deslocamento vertical da foto (top)
  [string]$Photo = "C:\Users\joaog\ippo-universo\capetown\_paste\paste_8.jpeg"
)
$ErrorActionPreference = "Stop"
$base = "C:\Users\joaog\ippo-universo\capetown"

# --- base64 fonte + foto ---
$fontB64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$base\fonts\PlusJakartaSans.ttf"))
$imgB64  = [Convert]::ToBase64String([IO.File]::ReadAllBytes($Photo))

$html = @"
<!DOCTYPE html><html lang="pt-BR"><head><meta charset="UTF-8"><style>
@font-face{font-family:'Plus Jakarta Sans';src:url(data:font/ttf;base64,$fontB64) format('truetype');font-weight:200 800;font-style:normal;}
:root{--P:#8B6355;--PL:#A8806F;--PD:#5C3D30;--LB:#FDF6ED;--DB:#1A1210;
--G:linear-gradient(165deg,#5C3D30 0%,#8B6355 50%,#A8806F 100%);
--F-BODY:'Plus Jakarta Sans',sans-serif;}
*{box-sizing:border-box;margin:0;padding:0;}
html,body{margin:0;padding:0;background:#1A1210;}
.slide{width:1080px;height:1350px;position:relative;overflow:hidden;background:var(--DB);font-family:var(--F-BODY);}
/* FOTO */
.capa-photo{position:absolute;inset:0;z-index:0;overflow:hidden;background:var(--DB);}
.capa-photo img{position:absolute;left:50%;transform:translateX(-50%);width:${PW}px;top:${PT}px;display:block;}
/* DEGRADE: escurece topo (header) + base (headline), deixa rosto limpo */
.capa-grad{position:absolute;inset:0;z-index:2;background:
  radial-gradient(115% 80% at 50% 30%, rgba(26,18,16,0) 40%, rgba(26,18,16,0.28) 68%, rgba(26,18,16,0.60) 100%),
  linear-gradient(to bottom,
  rgba(26,18,16,0.66) 0%,
  rgba(26,18,16,0.42) 7%,
  rgba(26,18,16,0.12) 14%,
  rgba(26,18,16,0.00) 23%,
  rgba(26,18,16,0.00) 47%,
  rgba(26,18,16,0.32) 55%,
  rgba(26,18,16,0.74) 63%,
  rgba(26,18,16,0.93) 71%,
  rgba(26,18,16,1.00) 81%,
  rgba(26,18,16,1.00) 100%);}
.brand-bar{position:absolute;top:0;left:0;right:0;padding:46px 52px 0;display:flex;justify-content:space-between;align-items:center;z-index:20;font-family:var(--F-BODY);font-weight:700;text-transform:uppercase;font-size:15px;}
.brand-bar .bb-l{color:rgba(248,241,233,0.88);letter-spacing:2.5px;}
.brand-bar .bb-r{color:rgba(248,241,233,0.40);letter-spacing:2px;}
.capa-headline-area{position:absolute;bottom:120px;left:0;right:0;padding:0 52px;z-index:10;}
.capa-badge{display:flex;align-items:center;gap:14px;background:rgba(0,0,0,0.38);border:1.5px solid rgba(255,255,255,0.12);border-radius:60px;padding:12px 26px 12px 14px;width:fit-content;margin-bottom:32px;}
.badge-dot{width:36px;height:36px;border-radius:50%;background:var(--G);display:flex;align-items:center;justify-content:center;font-family:var(--F-BODY);font-size:16px;font-weight:800;color:#fff;}
.badge-handle{font-family:var(--F-BODY);font-size:22px;font-weight:700;color:#fff;}
.badge-check{width:22px;height:22px;background:var(--P);border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:12px;color:#fff;}
.capa-headline{font-family:var(--F-BODY);font-size:92px;font-weight:400;line-height:1.06;letter-spacing:-2px;color:#fff;}
.capa-headline em{color:var(--PL);font-style:normal;font-weight:800;}
.prog{position:absolute;bottom:0;left:0;right:0;padding:0 56px 30px;z-index:20;display:flex;align-items:center;gap:16px;font-family:var(--F-BODY);}
.prog-track{flex:1;height:3px;border-radius:2px;overflow:hidden;background:rgba(255,255,255,0.18);}
.prog-fill{height:100%;border-radius:2px;background:#fff;width:14.3%;}
.prog-num{font-size:15px;font-weight:600;color:rgba(255,255,255,0.7);}
</style></head><body>
<div class="slide">
  <div class="capa-photo"><img src="data:image/jpeg;base64,$imgB64"></div>
  <div class="capa-grad"></div>
  <div class="brand-bar"><span class="bb-l">HARMONIZA&#199;&#195;O OROFACIAL</span><span class="bb-r">2026 &#174;</span></div>
  <div class="capa-headline-area">
    <div class="capa-badge"><div class="badge-dot">F</div><span class="badge-handle">@drafrancinealmeida</span><div class="badge-check">&#10003;</div></div>
    <div class="capa-headline">O rosto que <em>derrete</em> enquanto o corpo muda</div>
  </div>
  <div class="prog"><div class="prog-track"><div class="prog-fill"></div></div><span class="prog-num">1/7</span></div>
</div></body></html>
"@

$htmlPath = "$base\CAPA1_slide.html"
[IO.File]::WriteAllText($htmlPath, $html, (New-Object System.Text.UTF8Encoding($false)))

# --- render Chrome headless ---
$chrome = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$out = "$base\CAPA1.png"
if(Test-Path $out){ Remove-Item $out -Force }
$udd = "$env:TEMP\chrome_capa_$(Get-Random)"
& $chrome --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 --window-size=1080,1350 --virtual-time-budget=2500 --default-background-color=00000000 --user-data-dir="$udd" --screenshot="$out" ("file:///" + ($htmlPath -replace '\\','/')) 2>$null | Out-Null
Start-Sleep -Milliseconds 300
if(Test-Path $out){ Write-Output "OK -> $out  ($([math]::Round((Get-Item $out).Length/1KB)) KB)  [PW=$PW PT=$PT]" } else { Write-Output "FALHOU render" }
try{ Remove-Item $udd -Recurse -Force -ErrorAction Stop }catch{}
