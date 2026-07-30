#!/usr/bin/env python3
"""Renderiza os SVGs em PNG (chromium headless) para conferencia visual."""
import glob, os, subprocess, sys, re

HERE = os.path.dirname(os.path.abspath(__file__))
OUT  = os.path.abspath(os.path.join(HERE, '..'))
PV   = os.path.join(HERE, 'preview')
CHROME = '/opt/pw-browsers/chromium-1194/chrome-linux/chrome'

os.makedirs(PV, exist_ok=True)
targets = sys.argv[1:] or sorted(glob.glob(os.path.join(OUT, '*.svg')))
for svg in targets:
    s = open(svg, encoding='utf-8').read()
    w = int(re.search(r'width="(\d+)"', s).group(1))
    h = int(re.search(r'height="(\d+)"', s).group(1))
    html = os.path.join(HERE, '_wrap.html')
    open(html, 'w', encoding='utf-8').write(
        "<!DOCTYPE html><html><head><meta charset='utf-8'><style>"
        "*{margin:0;padding:0}html,body{width:%dpx;height:%dpx;overflow:hidden}"
        "svg{display:block}</style></head><body>%s</body></html>" % (w, h, s))
    png = os.path.join(PV, os.path.basename(svg).replace('.svg', '.png'))
    # o headless corta ~85px no rodape: renderiza com folga e recorta.
    subprocess.run([CHROME, '--headless', '--disable-gpu', '--no-sandbox', '--hide-scrollbars',
                    f'--screenshot={png}', f'--window-size={w},{h + 140}', html],
                   capture_output=True)
    from PIL import Image
    im = Image.open(png)
    if im.size != (w, h):
        im.crop((0, 0, w, h)).save(png)
    print(os.path.basename(png), os.path.getsize(png) // 1024, 'KB')
os.path.exists(os.path.join(HERE, '_wrap.html')) and os.remove(os.path.join(HERE, '_wrap.html'))
