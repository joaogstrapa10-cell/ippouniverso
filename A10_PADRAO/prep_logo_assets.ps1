$src = "C:\Users\joaog\ippo-universo\capetown\solenne_build"
$dst = "C:\Users\joaog\ippo-universo\A10_PADRAO"
[IO.File]::WriteAllText("$dst\a10_dark.b64",  [Convert]::ToBase64String([IO.File]::ReadAllBytes("$src\A10_Logo_carvao.png")))
[IO.File]::WriteAllText("$dst\a10_cream.b64", [Convert]::ToBase64String([IO.File]::ReadAllBytes("$src\A10_Logo_cream.png")))
"OK"
