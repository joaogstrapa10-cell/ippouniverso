# -*- coding: utf-8 -*-
"""
Generate three fully-vector, Figma-editable SVGs recreating the three
luxury real-estate portfolio mockups (variants 1a / 1b / 1c).

Design tokens follow the existing repo house style:
  navy   #0B1A2D  (base)  / #08131F (darker panel)
  gold   #C9A86A  (+ lighter #E3C77E)
  cream  #F3ECDB  (headlines)
  serif  'Bodoni Moda'  (Didone display, Google/Figma-native)
  sans   'Poppins'      (labels/body, Google/Figma-native)

Every text is a real <text> element (editable text layer in Figma) and
every graphic is a native vector primitive. Diagonal "pinstripe" texture
is drawn as real <line> elements inside a clipped <g> so it stays visible
and removable in Figma (no rasterization anywhere).
"""
import os, html

W = 1080
H = 2400

NAVY      = "#0B1A2D"
NAVY_DARK = "#08131F"
NAVY_PANEL= "#0C1C31"
GOLD      = "#C9A86A"
GOLD_LT   = "#E3C77E"
CREAM     = "#F3ECDB"
CREAM_DIM = "#E7E0D0"
GRAY      = "#AEB8C2"
STRIPE    = "#2C4763"

SERIF = "Bodoni Moda"
SANS  = "Poppins"

def esc(s):
    return html.escape(s, quote=True)

# ---------------------------------------------------------------- primitives
def txt(x, y, s, *, font=SANS, size=20, weight=400, italic=False, fill=CREAM,
        anchor="start", ls=None, opacity=None):
    a = [f'x="{x}"', f'y="{y}"',
         f'font-family="{font}"', f'font-size="{size}"',
         f'font-weight="{weight}"', f'fill="{fill}"']
    if italic:            a.append('font-style="italic"')
    if anchor != "start": a.append(f'text-anchor="{anchor}"')
    if ls is not None:    a.append(f'letter-spacing="{ls}"')
    if opacity is not None: a.append(f'opacity="{opacity}"')
    return f'  <text {" ".join(a)}>{esc(s)}</text>\n'

def rect(x, y, w, h, *, fill="none", stroke=None, sw=1, opacity=None,
         rx=None, stroke_op=None, dash=None):
    a = [f'x="{x}"', f'y="{y}"', f'width="{w}"', f'height="{h}"', f'fill="{fill}"']
    if rx is not None:     a.append(f'rx="{rx}"')
    if stroke:             a.append(f'stroke="{stroke}"'); a.append(f'stroke-width="{sw}"')
    if stroke_op is not None: a.append(f'stroke-opacity="{stroke_op}"')
    if dash:               a.append(f'stroke-dasharray="{dash}"')
    if opacity is not None: a.append(f'opacity="{opacity}"')
    return f'  <rect {" ".join(a)}/>\n'

def line(x1, y1, x2, y2, *, stroke=GOLD, sw=1, opacity=None):
    a = [f'x1="{x1}"', f'y1="{y1}"', f'x2="{x2}"', f'y2="{y2}"',
         f'stroke="{stroke}"', f'stroke-width="{sw}"']
    if opacity is not None: a.append(f'stroke-opacity="{opacity}"')
    return f'  <line {" ".join(a)}/>\n'

def diamond(cx, cy, r=7, *, fill=GOLD, stroke=None, sw=1):
    a = [f'x="{-r}"', f'y="{-r}"', f'width="{2*r}"', f'height="{2*r}"',
         f'transform="translate({cx},{cy}) rotate(45)"', f'fill="{fill}"']
    if stroke: a.append(f'stroke="{stroke}"'); a.append(f'stroke-width="{sw}"')
    return f'  <rect {" ".join(a)}/>\n'

_clip_id = 0
def stripes(x, y, w, h, *, spacing=26, color=STRIPE, opacity=0.5, sw=1, label="stripes"):
    """Diagonal (/) pinstripes clipped to a rect, as real <line>s in a <g>."""
    global _clip_id
    _clip_id += 1
    cid = f"clip{_clip_id}"
    out = [f'  <clipPath id="{cid}"><rect x="{x}" y="{y}" width="{w}" height="{h}"/></clipPath>\n']
    out.append(f'  <g clip-path="url(#{cid})" opacity="{opacity}">\n')
    c = x + y
    cmax = (x + w) + (y + h)
    while c <= cmax:
        xa = x - h;         ya = c - xa
        xb = x + w + h;     yb = c - xb
        out.append(f'    <line x1="{xa}" y1="{ya}" x2="{xb}" y2="{yb}" '
                   f'stroke="{color}" stroke-width="{sw}"/>\n')
        c += spacing
    out.append('  </g>\n')
    return "".join(out)

def stat_group(cx_list, values, labels, *, vy, ly, vsize=52, lsize=13,
               vfill=CREAM, lfill=GOLD, div_y0=None, div_h=None):
    """Row of stats with thin gold vertical dividers between cells."""
    out = []
    for i, cx in enumerate(cx_list):
        out.append(txt(cx, vy, values[i], font=SERIF, size=vsize, weight=500,
                       fill=vfill, anchor="middle"))
        out.append(txt(cx, ly, labels[i], font=SANS, size=lsize, weight=500,
                       fill=lfill, anchor="middle", ls=1.6, opacity=0.85))
    if div_y0 is not None:
        for i in range(len(cx_list) - 1):
            dx = (cx_list[i] + cx_list[i+1]) / 2
            out.append(line(dx, div_y0, dx, div_y0 + div_h, stroke=GOLD, sw=1, opacity=0.32))
    return "".join(out)

# ---------------------------------------------------------------- shared defs
def header(title):
    return (f'<svg xmlns="http://www.w3.org/2000/svg" '
            f'xmlns:xlink="http://www.w3.org/1999/xlink" '
            f'width="{W}" height="{H}" viewBox="0 0 {W} {H}">\n'
            f'  <title>{esc(title)}</title>\n'
            f'  <defs>\n'
            f"    <style>@import url('https://fonts.googleapis.com/css2?"
            f"family=Bodoni+Moda:ital,opsz,wght@0,6..96,400;0,6..96,500;0,6..96,600;"
            f"1,6..96,400;1,6..96,500&amp;family=Poppins:wght@300;400;500;600&amp;display=swap');</style>\n"
            f'    <linearGradient id="bg" x1="0" y1="0" x2="0.35" y2="1">\n'
            f'      <stop offset="0" stop-color="#0C1C31"/>\n'
            f'      <stop offset="0.55" stop-color="{NAVY}"/>\n'
            f'      <stop offset="1" stop-color="#081320"/>\n'
            f'    </linearGradient>\n'
            f'    <linearGradient id="goldGrad" x1="0" y1="0" x2="0" y2="1">\n'
            f'      <stop offset="0" stop-color="{GOLD_LT}"/>\n'
            f'      <stop offset="1" stop-color="#B5904E"/>\n'
            f'    </linearGradient>\n'
            f'    <radialGradient id="glow" cx="0.82" cy="0.10" r="0.55">\n'
            f'      <stop offset="0" stop-color="#E3C77E" stop-opacity="0.10"/>\n'
            f'      <stop offset="1" stop-color="#E3C77E" stop-opacity="0"/>\n'
            f'    </radialGradient>\n'
            f'  </defs>\n')

def footer_block(top_y):
    """Shared bottom CTA band. Returns svg string."""
    o = []
    o.append(line(72, top_y, 1008, top_y, stroke=GOLD, sw=1, opacity=0.28))
    qy = top_y + 40
    # QR placeholder
    o.append(rect(72, qy, 150, 150, fill=NAVY_DARK, stroke=GOLD, sw=1, stroke_op=0.55))
    o.append(stripes(72, qy, 150, 150, spacing=16, color=STRIPE, opacity=0.6, sw=1))
    o.append(rect(72, qy, 150, 150, fill="none", stroke=GOLD, sw=1, opacity=0.55))
    o.append(txt(147, qy + 82, "QR CODE", font=SANS, size=13, weight=500,
                 fill=GOLD, anchor="middle", ls=2, opacity=0.65))
    tx = 258
    o.append(txt(tx, qy + 22, "RECEBA O BOOK COMPLETO", font=SANS, size=17,
                 weight=500, fill=GOLD, ls=4, opacity=0.9))
    o.append(txt(tx, qy + 74, "Agende uma apresentação privativa",
                 font=SERIF, size=42, weight=500, fill=CREAM))
    o.append(txt(tx, qy + 118, "WhatsApp (47) 99170-2508 · Corretor credenciado",
                 font=SANS, size=18, weight=300, fill=GRAY))
    return "".join(o)

def logo_box(cx, y, w=320, h=84, label="LOGO · IMOBILIÁRIA"):
    x = cx - w/2
    o = []
    o.append(rect(x, y, w, h, fill=NAVY_DARK, opacity=0.5))
    o.append(stripes(x, y, w, h, spacing=15, color=STRIPE, opacity=0.5, sw=1))
    o.append(rect(x, y, w, h, fill="none", stroke=GOLD, sw=1, stroke_op=0.5))
    o.append(txt(cx, y + h/2 + 6, label, font=SANS, size=19, weight=500,
                 fill=CREAM, anchor="middle", ls=5, opacity=0.55))
    return "".join(o)

def tag_box(x, y, label, *, w=None, h=52, size=17):
    if w is None:
        w = 40 + len(label) * (size*0.62)
    o = []
    o.append(rect(x, y, w, h, fill="none", stroke=GOLD, sw=1, stroke_op=0.65))
    o.append(txt(x + 24, y + h/2 + 6, label, font=SANS, size=size, weight=500,
                 fill=GOLD, ls=3))
    return "".join(o), w

def base_background(glow=True):
    o = [rect(0, 0, W, H, fill="url(#bg)")]
    o.append(stripes(0, 0, W, H, spacing=28, color=STRIPE, opacity=0.22, sw=1, label="bg-texture"))
    if glow:
        o.append(rect(0, 0, W, H, fill="url(#glow)"))
    return "".join(o)

# =====================================================================  1a
def build_1a():
    o = [header("Portfólio A10 · Editorial · Meio a Meio")]
    o.append(base_background())

    # logo + intro frame
    o.append(logo_box(540, 96))
    o.append(rect(72, 236, 936, 214, fill="none", stroke=GOLD, sw=1, stroke_op=0.55))
    o.append(txt(540, 312, "PORTFÓLIO ALTO PADRÃO · BALNEÁRIO CAMBORIÚ",
                 font=SANS, size=20, weight=500, fill=GOLD, anchor="middle", ls=5))
    o.append(txt(540, 382, "Dois endereços à altura do mais alto padrão",
                 font=SERIF, size=44, weight=500, italic=True, fill=CREAM, anchor="middle"))
    o.append(diamond(540, 450, 9, fill=NAVY, stroke=GOLD, sw=1))
    o.append(diamond(540, 450, 4, fill=GOLD))

    # ---- Solenne panel (darker flat) ----
    o.append(rect(0, 496, W, 726, fill=NAVY_DARK, opacity=0.55))
    o.append(txt(540, 812, "FOTO · SOLENNE (FACHADA)", font=SANS, size=22, weight=400,
                 fill=GOLD, anchor="middle", ls=4, opacity=0.12))
    tb, _ = tag_box(72, 560, "PRÉ-LANÇAMENTO · 2030", w=330)
    o.append(tb)
    o.append(txt(70, 776, "Solenne", font=SERIF, size=104, weight=500, fill=CREAM))
    o.append(txt(74, 828, "CENTRO · BARRA SUL — BALNEÁRIO CAMBORIÚ",
                 font=SANS, size=18, weight=500, fill=GOLD, ls=3))
    o.append(txt(74, 882, "Arquitetura neoclássica de herança francesa · Zermiani Schäfer",
                 font=SERIF, size=30, weight=400, italic=True, fill=CREAM_DIM))
    o.append(txt(74, 924, "3 suítes · 2+1 vagas · 138,59 m² privativos",
                 font=SANS, size=20, weight=300, fill=GRAY))
    cxs = [150, 330, 512, 690]
    o.append(stat_group(cxs, ["35", "+110m", "700m", "17"],
                        ["PAVIMENTOS", "ALTURA", "DA PRAIA", "LAZER"],
                        vy=1004, ly=1044, div_y0=968, div_h=90))
    o.append(line(72, 1094, 1008, 1094, stroke=GOLD, sw=1, opacity=0.35))
    o.append(txt(72, 1152, "A partir de R$ 2,2 mi", font=SERIF, size=40, weight=500,
                 italic=True, fill=GOLD_LT))
    o.append(txt(1008, 1150, "R21 & A10", font=SANS, size=17, weight=400,
                 fill=GOLD, anchor="end", ls=2, opacity=0.8))

    # ---- divider ----
    o.append(line(72, 1224, 500, 1224, stroke=GOLD, sw=1, opacity=0.3))
    o.append(line(580, 1224, 1008, 1224, stroke=GOLD, sw=1, opacity=0.3))
    o.append(diamond(540, 1224, 9, fill=NAVY, stroke=GOLD, sw=1))
    o.append(diamond(540, 1224, 4, fill=GOLD))

    # ---- Pátio panel ----
    o.append(txt(540, 1548, "FOTO · PÁTIO ESTALEIRO", font=SANS, size=22, weight=400,
                 fill=GOLD, anchor="middle", ls=4, opacity=0.12))
    tb, _ = tag_box(72, 1296, "PRONTO PARA MORAR", w=290)
    o.append(tb)
    o.append(txt(70, 1512, "Pátio Estaleiro", font=SERIF, size=104, weight=500, fill=CREAM))
    o.append(txt(74, 1564, "PRAIA DO ESTALEIRO · BALNEÁRIO CAMBORIÚ",
                 font=SANS, size=18, weight=500, fill=GOLD, ls=3))
    o.append(txt(74, 1618, "Casas exclusivas à beira-mar, imersas na Mata Atlântica",
                 font=SERIF, size=30, weight=400, italic=True, fill=CREAM_DIM))
    o.append(txt(74, 1660, "4 suítes · 3 vagas · piscina privativa",
                 font=SANS, size=20, weight=300, fill=GRAY))
    o.append(stat_group(cxs, ["298—344", "90m", "08", "Azul"],
                        ["M² PRIVATIVOS", "DO MAR", "CASAS", "BANDEIRA"],
                        vy=1740, ly=1780, vsize=46, div_y0=1704, div_h=90))
    o.append(line(72, 1830, 1008, 1830, stroke=GOLD, sw=1, opacity=0.35))
    o.append(txt(72, 1888, "Entrada + saldo em 180 meses", font=SERIF, size=40,
                 weight=500, italic=True, fill=GOLD_LT))
    o.append(txt(1008, 1886, "A10", font=SANS, size=17, weight=400, fill=GOLD,
                 anchor="end", ls=2, opacity=0.8))

    # ---- footer ----
    o.append(footer_block(2110))
    o.append('</svg>\n')
    return "".join(o)

# =====================================================================  1b
def build_1b():
    o = [header("Portfólio A10 · Grade Clássica · Duas Colunas")]
    o.append(base_background())

    o.append(logo_box(540, 96))
    # intro frame (taller, two-line italic)
    o.append(rect(72, 236, 936, 250, fill="none", stroke=GOLD, sw=1, stroke_op=0.55))
    o.append(txt(540, 306, "ALTO PADRÃO · BALNEÁRIO CAMBORIÚ/SC",
                 font=SANS, size=20, weight=500, fill=GOLD, anchor="middle", ls=5))
    o.append(txt(540, 372, "Dois empreendimentos, um só padrão",
                 font=SERIF, size=46, weight=500, italic=True, fill=CREAM, anchor="middle"))
    o.append(txt(540, 424, "de excelência",
                 font=SERIF, size=46, weight=500, italic=True, fill=CREAM, anchor="middle"))
    o.append(diamond(540, 486, 9, fill=NAVY, stroke=GOLD, sw=1))
    o.append(diamond(540, 486, 4, fill=GOLD))

    # center divider
    o.append(line(540, 560, 540, 2040, stroke=GOLD, sw=1, opacity=0.32))

    # ---------- LEFT column : Solenne ----------
    lx = 72
    o.append(txt(lx, 590, "PRÉ-LANÇAMENTO · 2030", font=SANS, size=16, weight=500,
                 fill=GOLD, ls=3))
    o.append(txt(lx-2, 656, "Solenne", font=SERIF, size=66, weight=500, fill=CREAM))
    o.append(txt(lx, 694, "CENTRO · BARRA SUL", font=SANS, size=16, weight=400,
                 fill=GRAY, ls=3))
    # photo box
    o.append(rect(lx, 726, 372, 372, fill=NAVY_DARK, opacity=0.6))
    o.append(stripes(lx, 726, 372, 372, spacing=16, color=STRIPE, opacity=0.55, sw=1))
    o.append(rect(lx, 726, 372, 372, fill="none", stroke=GOLD, sw=1, stroke_op=0.4))
    o.append(txt(lx+186, 918, "FOTO · SOLENNE", font=SANS, size=17, weight=500,
                 fill=GOLD, anchor="middle", ls=3, opacity=0.35))
    o.append(txt(lx, 1160, "Arquitetura neoclássica de", font=SERIF, size=30,
                 weight=400, italic=True, fill=CREAM_DIM))
    o.append(txt(lx, 1198, "herança francesa", font=SERIF, size=30,
                 weight=400, italic=True, fill=CREAM_DIM))
    # spec list left
    specs_l = [("PAVIMENTOS", "35"), ("ALTURA", "+110m"),
               ("DA PRAIA", "700m"), ("LAZER", "17 amb.")]
    sy = 1280
    rx = 468  # right edge of left column content
    for lab, val in specs_l:
        o.append(txt(lx, sy, lab, font=SANS, size=17, weight=500, fill=GOLD, ls=1.5, opacity=0.85))
        o.append(txt(rx, sy, val, font=SERIF, size=34, weight=500, fill=CREAM, anchor="end"))
        o.append(line(lx, sy+22, rx, sy+22, stroke=GOLD, sw=1, opacity=0.2))
        sy += 78
    o.append(txt(lx, sy+8, "3 suítes · 2+1 vagas · 138,59 m²", font=SANS, size=18,
                 weight=300, fill=GRAY))
    # left bottom price
    o.append(txt(lx, 1988, "A partir de R$ 2,2 mi", font=SERIF, size=34, weight=500,
                 italic=True, fill=GOLD_LT))
    o.append(txt(lx, 2024, "R21 & A10 · ZERMIANI SCHÄFER", font=SANS, size=15,
                 weight=400, fill=GOLD, ls=2, opacity=0.7))

    # ---------- RIGHT column : Pátio Estaleiro ----------
    rxc = 612
    redge = 1008
    o.append(txt(rxc, 590, "PRONTO PARA MORAR", font=SANS, size=16, weight=500,
                 fill=GOLD, ls=3))
    o.append(txt(rxc-2, 656, "Pátio Estaleiro", font=SERIF, size=66, weight=500, fill=CREAM))
    o.append(txt(rxc, 694, "PRAIA DO ESTALEIRO", font=SANS, size=16, weight=400,
                 fill=GRAY, ls=3))
    o.append(rect(rxc, 726, 396, 372, fill=NAVY_DARK, opacity=0.6))
    o.append(stripes(rxc, 726, 396, 372, spacing=16, color=STRIPE, opacity=0.55, sw=1))
    o.append(rect(rxc, 726, 396, 372, fill="none", stroke=GOLD, sw=1, stroke_op=0.4))
    o.append(txt(rxc+198, 918, "FOTO · PÁTIO ESTALEIRO", font=SANS, size=17, weight=500,
                 fill=GOLD, anchor="middle", ls=3, opacity=0.35))
    o.append(txt(rxc, 1160, "Casas à beira-mar na Mata Atlântica", font=SERIF, size=30,
                 weight=400, italic=True, fill=CREAM_DIM))
    specs_r = [("PRIVATIVOS", "298—344m²"), ("DO MAR", "90m"),
               ("CASAS", "08"), ("CERTIFICAÇÃO", "Band. Azul")]
    sy = 1280
    for lab, val in specs_r:
        o.append(txt(rxc, sy, lab, font=SANS, size=17, weight=500, fill=GOLD, ls=1.5, opacity=0.85))
        o.append(txt(redge, sy, val, font=SERIF, size=34, weight=500, fill=CREAM, anchor="end"))
        o.append(line(rxc, sy+22, redge, sy+22, stroke=GOLD, sw=1, opacity=0.2))
        sy += 78
    o.append(txt(rxc, sy+8, "4 suítes · 3 vagas · piscina privativa", font=SANS, size=18,
                 weight=300, fill=GRAY))
    o.append(txt(rxc, 1988, "Entrada + saldo em 180 meses", font=SERIF, size=30,
                 weight=500, italic=True, fill=GOLD_LT))
    o.append(txt(rxc, 2024, "A10 EMPREENDIMENTOS", font=SANS, size=15, weight=400,
                 fill=GOLD, ls=2, opacity=0.7))

    o.append(footer_block(2110))
    o.append('</svg>\n')
    return "".join(o)

# =====================================================================  1c
def build_1c():
    o = [header("Portfólio A10 · Torre Editorial · Assimétrico")]
    o.append(base_background())

    # header row: logo left, editorial right
    o.append(logo_box(230, 96, w=280, h=84, label="LOGO · IMOB."))
    o.append(txt(1008, 118, "ALTO PADRÃO · BC/SC", font=SANS, size=18, weight=500,
                 fill=GOLD, anchor="end", ls=4))
    o.append(txt(1008, 166, "Dois endereços de exceção", font=SERIF, size=40,
                 weight=500, italic=True, fill=CREAM, anchor="end"))

    # anchor tag
    tb, _ = tag_box(72, 236, "LANÇAMENTO-ÂNCORA · PRÉ 2030", w=430)
    o.append(tb)

    # ---- Solenne feature (big) ----
    o.append(txt(540, 900, "FOTO · SOLENNE (FACHADA)", font=SANS, size=24, weight=400,
                 fill=GOLD, anchor="middle", ls=5, opacity=0.11))
    o.append(txt(66, 972, "Solenne", font=SERIF, size=150, weight=500, fill=CREAM))
    o.append(txt(74, 1030, "CENTRO · BARRA SUL — 700M DA PRAIA",
                 font=SANS, size=19, weight=500, fill=GOLD, ls=3))
    o.append(txt(74, 1088, "Arquitetura neoclássica de herança francesa · Zermiani Schäfer",
                 font=SERIF, size=32, weight=400, italic=True, fill=CREAM_DIM))
    cxs = [150, 330, 512, 690]
    o.append(stat_group(cxs, ["35", "+110m", "17", "3"],
                        ["PAVIMENTOS", "ALTURA", "LAZER", "SUÍTES"],
                        vy=1180, ly=1220, div_y0=1144, div_h=92))
    o.append(line(72, 1272, 1008, 1272, stroke=GOLD, sw=1, opacity=0.35))
    o.append(txt(72, 1332, "A partir de R$ 2,2 mi", font=SERIF, size=42, weight=500,
                 italic=True, fill=GOLD_LT))
    o.append(txt(1008, 1330, "R21 & A10", font=SANS, size=18, weight=400,
                 fill=GOLD, anchor="end", ls=2, opacity=0.8))

    # ---- divider with diamond ----
    o.append(line(72, 1410, 500, 1410, stroke=GOLD, sw=1, opacity=0.3))
    o.append(line(580, 1410, 1008, 1410, stroke=GOLD, sw=1, opacity=0.3))
    o.append(diamond(540, 1410, 10, fill=NAVY, stroke=GOLD, sw=1))
    o.append(diamond(540, 1410, 5, fill=GOLD))

    # ---- Pátio band (asymmetric: narrow left photo strip + right content) ----
    o.append(rect(0, 1452, 360, 620, fill=NAVY_DARK, opacity=0.5))
    o.append(stripes(0, 1452, 360, 620, spacing=18, color=STRIPE, opacity=0.5, sw=1))
    tb, _ = tag_box(72, 1500, "PRONTO", w=170)
    o.append(tb)
    o.append(txt(180, 1900, "FOTO · PÁTIO ESTALEIRO", font=SANS, size=17, weight=500,
                 fill=GOLD, anchor="middle", ls=3, opacity=0.4))

    # right content column starts ~x=430
    cx = 430
    redge = 1008
    o.append(txt(cx-2, 1560, "Pátio Estaleiro", font=SERIF, size=64, weight=500, fill=CREAM))
    o.append(txt(cx, 1600, "PRAIA DO ESTALEIRO · 90M DO MAR",
                 font=SANS, size=17, weight=500, fill=GOLD, ls=3))
    o.append(txt(cx, 1660, "Casas exclusivas à beira-mar, na", font=SERIF, size=32,
                 weight=400, italic=True, fill=CREAM_DIM))
    o.append(txt(cx, 1702, "Mata Atlântica", font=SERIF, size=32,
                 weight=400, italic=True, fill=CREAM_DIM))
    o.append(txt(cx, 1760, "298—344 m² · 08 casas · 4 suítes", font=SANS, size=19,
                 weight=300, fill=GRAY))
    o.append(txt(cx, 1794, "3 vagas · piscina privativa · Bandeira Azul", font=SANS,
                 size=19, weight=300, fill=GRAY))
    o.append(line(cx, 1900, redge, 1900, stroke=GOLD, sw=1, opacity=0.3))
    o.append(txt(cx, 1958, "Entrada + saldo em 180 meses", font=SERIF, size=40,
                 weight=500, italic=True, fill=GOLD_LT))
    o.append(txt(cx, 1996, "A10 EMPREENDIMENTOS", font=SANS, size=15, weight=400,
                 fill=GOLD, ls=2, opacity=0.7))

    o.append(footer_block(2110))
    o.append('</svg>\n')
    return "".join(o)

# ---------------------------------------------------------------- main
if __name__ == "__main__":
    outdir = os.environ.get("OUTDIR", ".")
    os.makedirs(outdir, exist_ok=True)
    files = {
        "1a_Editorial_MeioAMeio_1080x2400.svg":       build_1a(),
        "1b_GradeClassica_DuasColunas_1080x2400.svg": build_1b(),
        "1c_TorreEditorial_Assimetrico_1080x2400.svg": build_1c(),
    }
    for name, data in files.items():
        with open(os.path.join(outdir, name), "w", encoding="utf-8") as f:
            f.write(data)
        print("wrote", name, len(data), "bytes")
