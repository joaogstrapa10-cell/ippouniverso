# -*- coding: utf-8 -*-
import base64, io, os
from PIL import Image, ImageOps

SP  = r"c:\Users\joaog\ippo-universo\A10_PADRAO\saidas\Apresentacao_Portfolio_3D\_build"
EMP = r"c:\Users\joaog\ippo-universo\EMPREENDIMENTOS A10"
AST = r"c:\Users\joaog\ippo-universo\A10_PADRAO\assets"
OUTDIR = r"c:\Users\joaog\ippo-universo\A10_PADRAO\saidas\Apresentacao_Portfolio_3D"
os.makedirs(OUTDIR, exist_ok=True)

def jpg_uri(fname, longest=2560, q=90):
    im = Image.open(os.path.join(EMP, fname))
    im = ImageOps.exif_transpose(im).convert("RGB")
    w,h = im.size
    s = longest/max(w,h)
    if s < 1: im = im.resize((round(w*s), round(h*s)), Image.LANCZOS)  # nunca amplia
    buf = io.BytesIO()
    im.save(buf, "JPEG", quality=q, optimize=True, progressive=True, subsampling=0)  # 4:4:4, sem borrar bordas
    return "data:image/jpeg;base64," + base64.b64encode(buf.getvalue()).decode(), len(buf.getvalue())

def png_uri_from_file(path):
    data = open(path,"rb").read()
    return "data:image/png;base64," + base64.b64encode(data).decode(), len(data)

def png_uri_from_b64(path):
    txt = open(path).read().strip()
    return "data:image/png;base64," + txt, len(txt)*3//4

# imagens dos empreendimentos (hero 1600 / inset 900)
IMGS = {
 "__IMG_PATIO__":        ("PatioEstaleiro_CasaMar_real.jpg", 2560, 90),
 "__IMG_PATIO2__":       ("PatioEstaleiro_CasaBrisa_real.jpg", 1100, 88),
 "__IMG_AURORA__":       ("aurora_piscina.jpg", 2560, 90),           # hero grande e nitido (1920x1920)
 "__IMG_AURORA2__":      ("Aurora_torre_sem_vizinho.jpg", 700, 88),  # torre so como inset pequeno
 "__IMG_HUB__":          ("hub.jpg", 1280, 92),                      # nativo
 "__IMG_SUNSTAR__":      ("vista_mar.jpg", 1280, 92),
 "__IMG_SANANDREAS__":   ("sanandreas.jpg", 1280, 92),
 "__IMG_SANVALENTIN__":  ("sanvalentin.jpg", 1024, 92),
 "__IMG_VILLADOMAR__":   ("villadomar.jpg", 1280, 92),
 "__IMG_CASACOLOMBO__":  ("casacolombo.jpg", 1280, 92),
}

html = open(os.path.join(SP,"template.html"), encoding="utf-8").read()
fonts = open(os.path.join(SP,"fonts_embedded.css"), encoding="utf-8").read()
html = html.replace("__FONTS__", fonts)

total = 0
for tok,(fn,lg,q) in IMGS.items():
    uri,sz = jpg_uri(fn,lg,q); total += sz
    html = html.replace(tok, uri)
    print(f"{tok:22} {fn:34} {sz//1024:5} KB")

# logos
a10gold,_ = png_uri_from_file(os.path.join(EMP,"A10_Logo_gold.png"))
r21gold,_ = png_uri_from_file(os.path.join(EMP,"R21_Logo_gold.png"))
a10dark,_ = png_uri_from_b64(os.path.join(AST,"a10_dark.b64"))
html = html.replace("__LOGO_A10__", a10gold)
html = html.replace("__LOGO_A10D__", a10dark)
html = html.replace("__LOGO_R21__", r21gold)

# checagem de tokens não resolvidos
import re
left = re.findall(r"__[A-Z0-9_]+__", html)
print("tokens restantes:", set(left) or "nenhum")

outpath = os.path.join(OUTDIR, "A10_Portfolio_3D.html")
open(outpath,"w",encoding="utf-8").write(html)
print("\nIMAGENS:", total//1024, "KB  | HTML STANDALONE:", len(html.encode('utf-8'))//1024, "KB")
print("SAIDA:", outpath)

# ---- variante para ARTIFACT (sem <!doctype>/<html>/<head>/<body>) ----
style = re.search(r"<style>.*?</style>", html, re.S).group(0)
title = re.search(r"<title>(.*?)</title>", html, re.S).group(1)
body_inner = re.search(r"<body>(.*?)</body>", html, re.S).group(1)
art = f"<title>{title}</title>\n{style}\n{body_inner}"
artpath = os.path.join(SP, "artifact_page.html")
open(artpath,"w",encoding="utf-8").write(art)
print("ARTIFACT:", len(art.encode('utf-8'))//1024, "KB ->", artpath)
