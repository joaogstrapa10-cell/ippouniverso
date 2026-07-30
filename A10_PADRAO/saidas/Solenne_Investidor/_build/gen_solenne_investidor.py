#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Gera os 12 criativos SOLENNE - angulo INVESTIDOR / esteira de incorporacoes A10.
6 copies aprovadas (E1,E2,E3,I1,I3,I4) x 2 formatos (Feed 1080x1350, Stories 1080x1920).

Template: painel creme arredondado sobre foto do empreendimento + lockup SOLENNE
          (vetores oficiais do logo) - mesmo modelo validado no AURORA.
Fonte:    Helvetica Neue (texto vivo, editavel no Figma).
Logo:     paths oficiais (Solenne - Logo__09.svg = monograma, __13.svg = wordmark).
"""
import base64, json, os, re, sys

HERE = os.path.dirname(os.path.abspath(__file__))
OUT  = os.path.abspath(os.path.join(HERE, '..'))
REPO = os.path.abspath(os.path.join(HERE, '..', '..', '..', '..'))

# ---------------------------------------------------------------- identidade
CREAM      = '#EDEAD9'   # painel
CREAM_SOFT = '#F4F1E5'   # chip interno
NAVY       = '#1F2C50'   # texto / pills / CTA
NAVY_SOFT  = '#4A5878'   # texto de apoio
GOLD       = '#B08D4F'   # labels, filete
GOLD_LT    = '#C9AC72'
GRAY       = '#6E7178'   # legenda de dado
ON_NAVY    = '#F4F1E5'   # texto sobre navy
RED        = '#D6453C'   # bolinha do badge

FS = "Helvetica Neue, HelveticaNeue, Helvetica, Arial, sans-serif"

# ---------------------------------------------------------------- medicao de texto
from PIL import ImageFont
LIB = '/usr/share/fonts/truetype/liberation/'
_cache = {}
def _font(px, weight):
    # Liberation Sans = metrica Arial ~ Helvetica. Proxy para Helvetica Neue.
    f = 'LiberationSans-Bold.ttf' if weight >= 600 else 'LiberationSans-Regular.ttf'
    key = (f, px)
    if key not in _cache:
        _cache[key] = ImageFont.truetype(LIB + f, int(round(px)))
    return _cache[key]

def tw(text, px, weight=400, tracking=0.0):
    """largura aproximada em px (com folga de seguranca)."""
    w = _font(px, weight).getlength(text)
    if 450 <= weight < 600:
        w *= 1.025           # Medium e ~2.5% mais largo que Regular
    return w + tracking * max(len(text) - 1, 0)

# ---------------------------------------------------------------- quebra de linha
def wrap_balanced(text, max_w, px, weight, tracking, max_lines, last_free=True):
    """quebra minimizando raggedness (DP). devolve None se nao couber.
    last_free=False penaliza tambem a ultima linha — evita linha orfa curta
    (usado nas frases da headline, onde cada frase e um bloco visual)."""
    words = text.split()
    n = len(words)
    if n == 0:
        return []
    W = [[None] * (n + 1) for _ in range(n + 1)]
    for i in range(n):
        for j in range(i + 1, n + 1):
            w = tw(' '.join(words[i:j]), px, weight, tracking)
            if w > max_w:
                break
            W[i][j] = w
    INF = float('inf')
    best = {}
    def solve(i, lines_left):
        if i == n:
            return (0.0, [])
        if lines_left == 0:
            return (INF, [])
        if (i, lines_left) in best:
            return best[(i, lines_left)]
        res = (INF, [])
        for j in range(i + 1, n + 1):
            if W[i][j] is None:
                break
            slack = (max_w - W[i][j])
            cost = 0.0 if (j == n and last_free) else slack * slack
            sub, rest = solve(j, lines_left - 1)
            if sub < INF and cost + sub < res[0]:
                res = (cost + sub, [' '.join(words[i:j])] + rest)
        best[(i, lines_left)] = res
        return res
    cost, lines = solve(0, max_lines)
    return lines if cost < INF else None

SENT = re.compile(r'(?<=[.!?])\s+')
def wrap_headline(text, max_w, px, weight, tracking, max_lines):
    """quebra por frase (como um designer faria) e depois balanceada."""
    parts = [p for p in SENT.split(text.strip()) if p]
    out = []
    left = max_lines
    for p in parts:
        got = None
        for k in range(1, left + 1):
            got = wrap_balanced(p, max_w, px, weight, tracking, k, last_free=False)
            if got:
                break
        if not got:
            return None
        out += got
        left -= len(got)
        if left < 0:
            return None
    return out

# ---------------------------------------------------------------- svg helpers
def esc(t):
    return (t.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;'))

def text_el(x, y, t, px, weight, fill, anchor='middle', tracking=0.0, eid=None, italic=False):
    a = f' id="{eid}"' if eid else ''
    ls = f' letter-spacing="{tracking:g}"' if tracking else ''
    it = ' font-style="italic"' if italic else ''
    return (f'<text{a} x="{x:g}" y="{y:g}" text-anchor="{anchor}" font-family="{FS}" '
            f'font-size="{px:g}" font-weight="{weight}" fill="{fill}"{ls}{it}'
            f' xml:space="preserve">{esc(t)}</text>')

def panel_path(x0, y0, x1, y1, r, corners):
    """retangulo com raio r apenas nos cantos listados (tl,tr,br,bl)."""
    def c(name):
        return r if name in corners else 0
    tl, tr, br, bl = c('tl'), c('tr'), c('br'), c('bl')
    d = [f'M{x0 + tl:g},{y0:g}', f'H{x1 - tr:g}']
    if tr: d.append(f'A{tr:g},{tr:g} 0 0 1 {x1:g},{y0 + tr:g}')
    d.append(f'V{y1 - br:g}')
    if br: d.append(f'A{br:g},{br:g} 0 0 1 {x1 - br:g},{y1:g}')
    d.append(f'H{x0 + bl:g}')
    if bl: d.append(f'A{bl:g},{bl:g} 0 0 1 {x0:g},{y1 - bl:g}')
    d.append(f'V{y0 + tl:g}')
    if tl: d.append(f'A{tl:g},{tl:g} 0 0 1 {x0 + tl:g},{y0:g}')
    d.append('Z')
    return ' '.join(d)

# ---------------------------------------------------------------- logo oficial
LOGO = json.load(open(os.path.join(HERE, 'logo_paths.json')))
MONO_D, MONO_BB = LOGO['mono'], LOGO['mono_bbox']   # [x0,y0,x1,y1]
WORD_D, WORD_BB = LOGO['word'], LOGO['word_bbox']

def logo_group(cx, top, mono_h, gap, word_w, color):
    """lockup vertical: monograma centralizado + wordmark abaixo. devolve (svg, altura)."""
    mw = (MONO_BB[2] - MONO_BB[0]) / (MONO_BB[3] - MONO_BB[1]) * mono_h
    s1 = mono_h / (MONO_BB[3] - MONO_BB[1])
    g1 = (f'<g id="LOGO_SOLENNE_MONOGRAMA" fill="{color}" transform="translate('
          f'{cx - mw / 2:.2f},{top:.2f}) scale({s1:.5f}) translate({-MONO_BB[0]:.2f},{-MONO_BB[1]:.2f})">'
          f'<path d="{MONO_D}"/></g>')
    wh = (WORD_BB[3] - WORD_BB[1]) / (WORD_BB[2] - WORD_BB[0]) * word_w
    s2 = word_w / (WORD_BB[2] - WORD_BB[0])
    wtop = top + mono_h + gap
    g2 = (f'<g id="LOGO_SOLENNE_WORDMARK" fill="{color}" transform="translate('
          f'{cx - word_w / 2:.2f},{wtop:.2f}) scale({s2:.5f}) translate({-WORD_BB[0]:.2f},{-WORD_BB[1]:.2f})">'
          + ''.join(f'<path d="{d}"/>' for d in WORD_D) + '</g>')
    return f'<g id="LOGO_SOLENNE">{g1}{g2}</g>', mono_h + gap + wh

# ---------------------------------------------------------------- foto
# Render oficial da torre (Solenne, entardecer). Pre-composta no tamanho exato de
# cada formato: nada de emenda entre ceu sintetico e foto, e uma unica <image> no SVG.
PHOTO = os.path.join(REPO, 'capetown', 'solenne_build', 'solenne.jpg')

def photo_for(F):
    from PIL import Image
    p = os.path.join(HERE, f'foto_{F["name"].lower()}_{F["W"]}x{F["H"]}.jpg')
    if not os.path.exists(p):
        im = Image.open(PHOTO).convert('RGB')
        pl = F['img']
        sc = im.resize((int(pl['w']), int(pl['h'])), Image.LANCZOS)
        cv = Image.new('RGB', (F['W'], F['H']))
        cv.paste(sc, (int(pl['x']), int(pl['y'])))
        # estende as bordas da render para preencher o que sobra da moldura
        gx = int(pl['x'] + pl['w'])
        if gx < F['W']:
            cv.paste(cv.crop((gx - 1, 0, gx, F['H'])).resize((F['W'] - gx, F['H'])), (gx, 0))
        gy = int(pl['y'] + pl['h'])
        if gy < F['H']:
            cv.paste(cv.crop((0, gy - 1, F['W'], gy)).resize((F['W'], F['H'] - gy)), (0, gy))
        ty = int(pl['y'])
        if ty > 0:
            cv.paste(cv.crop((0, ty, F['W'], ty + 1)).resize((F['W'], ty)), (0, 0))
        txx = int(pl['x'])
        if txx > 0:
            cv.paste(cv.crop((txx, 0, txx + 1, F['H'])).resize((txx, F['H'])), (0, 0))
        cv.save(p, 'JPEG', quality=84, optimize=True, progressive=True)
    return base64.b64encode(open(p, 'rb').read()).decode()

# ---------------------------------------------------------------- copies aprovadas
CREATIVES = [
    dict(key='E1', bloco='esteira',
         headline='A A10 não tem um empreendimento. Tem uma esteira de oportunidades.',
         sub='Um fluxo contínuo de incorporações em Balneário Camboriú. Quem acompanha de dentro vê a oportunidade antes de ela chegar ao mercado.',
         cta='QUERO ACOMPANHAR AS OPORTUNIDADES',
         badge='GRUPO SELETO DE INVESTIDORES', badge_dot=True,
         dados=[('PRAÇA', 'Balneário Camboriú'), ('MODELO', 'Incorporação')]),
    dict(key='E2', bloco='esteira',
         headline='Oportunidade boa não é anunciada. É indicada.',
         sub='A esteira de incorporações da A10 em Balneário circula primeiro entre um grupo seleto de investidores.',
         cta='QUERO FAZER PARTE',
         badge=None, badge_dot=False,
         dados=[('ACESSO', 'Reduzido'), ('ATUAÇÃO', 'Balneário Camboriú')]),
    dict(key='E3', bloco='esteira',
         headline='Enquanto o mercado espera o próximo lançamento, um grupo seleto de investidores já está previamente posicionado.',
         sub='Incorporações em desenvolvimento em Balneário Camboriú. A A10 abre oportunidades inovadoras.',
         cta='QUERO ESTAR POSICIONADO',
         badge=None, badge_dot=False, dados=[]),
    dict(key='I1', bloco='incorporador',
         headline='Existe o lado de quem compra o imóvel. E o lado de quem desenvolve o empreendimento.',
         sub='A A10 realiza incorporações em Balneário Camboriú e atua com investidores que querem capturar o retorno desde a concepção.',
         cta='QUERO SABER MAIS',
         badge=None, badge_dot=False,
         dados=[('POSIÇÃO', 'Lado do incorporador'), ('PRAÇA', 'Balneário Camboriú')]),
    dict(key='I3', bloco='incorporador',
         headline='Investir em imóvel é uma coisa. Investir em incorporação é outra.',
         sub='A A10 desenvolve empreendimentos em Balneário Camboriú com um grupo seleto de investidores.',
         cta='QUERO ENTENDER',
         badge=None, badge_dot=False,
         dados=[('FORMATO', 'Agenda individual'), ('PERFIL', 'Investidor')]),
    dict(key='I4', bloco='incorporador',
         headline='Olhe Balneário Camboriú como incorporador. Não como comprador.',
         sub='Muda tudo: o que você analisa, quando você entra, e qual o potencial de ganho. A A10 dá acesso a oportunidades exclusivas.',
         cta='QUERO SABER MAIS',
         badge=None, badge_dot=False, dados=[]),
]

# ---------------------------------------------------------------- especificacao de formato
FEED = dict(
    name='Feed', W=1080, H=1350,
    # foto (placement da render 1440x1600 -> torre a esquerda, base perto do rodape)
    img=dict(x=-383, y=-132, w=1339, h=1488),
    panel=dict(x0=600, y0=22, x1=1080, y1=1350, r=44, corners=('tl', 'bl')),
    pad=46,
    logo=dict(top=64, mono_h=150, gap=46, word_w=266),
    cta=dict(h=84, bottom_margin=92, size=[20, 19, 18, 17, 16], tracking=1.6, pad=34),
    hl=dict(sizes=[50, 48, 46, 44, 42, 40, 38, 36, 34], max_lines=8, lh=1.16, tracking=-0.3),
    sb=dict(sizes=[24, 23, 22, 21, 20, 19, 18], max_lines=8, lh=1.44),
    badge=dict(h=44, size=13.5, tracking=1.5, pad=26),
    dados=dict(stack=True, label=13, value=22, lt=2.6),
    rule=dict(w=64, gap_top=30, gap_bottom=30),
    gaps=dict(after_badge=(26, 40), after_hl=(0, 0), after_sub=(28, 46)),
)

STORIES = dict(
    name='Stories', W=1080, H=1920,
    img=dict(x=-170, y=56, w=1440, h=1600),
    panel=dict(x0=0, y0=812, x1=1080, y1=1920, r=52, corners=('tl', 'tr')),
    pad=96,
    logo=dict(top=856, mono_h=152, gap=44, word_w=310),
    cta=dict(h=94, bottom_margin=118, size=[24, 23, 22, 21, 20], tracking=1.8, pad=44),
    hl=dict(sizes=[62, 59, 56, 53, 50, 47, 44, 41], max_lines=6, lh=1.15, tracking=-0.4),
    sb=dict(sizes=[28, 27, 26, 25, 24, 23, 22], max_lines=5, lh=1.42),
    badge=dict(h=52, size=17, tracking=1.8, pad=32),
    dados=dict(stack=False, label=14, value=25, lt=2.8),
    rule=dict(w=72, gap_top=34, gap_bottom=34),
    gaps=dict(after_badge=(30, 46), after_hl=(0, 0), after_sub=(32, 54)),
)

# ---------------------------------------------------------------- montagem
def build(cr, F):
    W, H = F['W'], F['H']
    cx = (F['panel']['x0'] + F['panel']['x1']) / 2
    inner = (F['panel']['x1'] - F['panel']['x0']) - 2 * F['pad']

    # --- logo
    logo_svg, logo_h = logo_group(cx, F['logo']['top'], F['logo']['mono_h'],
                                  F['logo']['gap'], F['logo']['word_w'], GOLD)
    # --- CTA primeiro (define o piso da area de texto): 1 linha, ou 2 se for longo
    tk, cpad = F['cta']['tracking'], F['cta']['pad']
    cs, clines = None, [cr['cta']]
    for c in F['cta']['size']:
        if tw(cr['cta'], c, 700, tk) + 2 * cpad <= inner:
            cs = c
            break
    if cs is None:
        cs = F['cta']['size'][0]
        clines = wrap_balanced(cr['cta'], inner - 2 * cpad, cs, 700, tk, 2) or [cr['cta']]
    ch = F['cta']['h'] + (cs * 1.22 if len(clines) > 1 else 0)
    cta_top = H - F['cta']['bottom_margin'] - ch

    top_content = F['logo']['top'] + logo_h
    region_top = top_content + (54 if F['name'] == 'Feed' else 58)
    region_bot = cta_top - (40 if F['name'] == 'Feed' else 46)
    avail = region_bot - region_top

    # --- badge
    b_h = 0
    if cr['badge']:
        b_h = F['badge']['h']

    # --- dados
    d_h = 0
    if cr['dados']:
        if F['dados']['stack']:
            d_h = len(cr['dados']) * 62 + (len(cr['dados']) - 1) * 18
        else:
            d_h = 74

    # --- autofit headline + sub
    # regra tipografica: menos linhas ganha de corpo maior. Descobre o minimo de
    # linhas possivel e so aceita corpos que fiquem nesse minimo (+1 de tolerancia);
    # entre esses, usa o maior corpo.
    opts = []
    for hs in F['hl']['sizes']:
        hl = wrap_headline(cr['headline'], inner, hs, 500, F['hl']['tracking'], F['hl']['max_lines'])
        if hl:
            opts.append((hs, hl))
    if not opts:
        raise SystemExit(f'[{cr["key"]}/{F["name"]}] headline nao quebra na largura do painel')
    min_lines = min(len(h) for _, h in opts)
    chosen = None
    for hs, hl in opts:
        if len(hl) > min_lines + 1:
            continue
        for ss in F['sb']['sizes']:
            sb = wrap_balanced(cr['sub'], inner, ss, 400, 0, F['sb']['max_lines'])
            if not sb:
                continue
            hl_h = len(hl) * hs * F['hl']['lh']
            sb_h = len(sb) * ss * F['sb']['lh']
            rule_h = 1 + F['rule']['gap_top'] + F['rule']['gap_bottom']
            gmin = 0
            if b_h: gmin += F['gaps']['after_badge'][0]
            if d_h: gmin += F['gaps']['after_sub'][0]
            total = b_h + hl_h + rule_h + sb_h + d_h + gmin
            if total <= avail:
                chosen = (hs, hl, hl_h, ss, sb, sb_h, rule_h, total, gmin)
                break
        if chosen:
            break
    if not chosen:
        raise SystemExit(f'[{cr["key"]}/{F["name"]}] nao coube — revisar ladder')
    hs, hl, hl_h, ss, sb, sb_h, rule_h, total, gmin = chosen

    # distribui a folga nos gaps (ate o ideal) e centraliza o bloco
    slack = avail - total
    g_badge = F['gaps']['after_badge'][0] if b_h else 0
    g_dados = F['gaps']['after_sub'][0] if d_h else 0
    for _ in range(2):
        if b_h and slack > 0:
            add = min(slack, F['gaps']['after_badge'][1] - g_badge)
            g_badge += add; slack -= add
        if d_h and slack > 0:
            add = min(slack, F['gaps']['after_sub'][1] - g_dados)
            g_dados += add; slack -= add
    used = b_h + g_badge + hl_h + rule_h + sb_h + g_dados + d_h
    y = region_top + max(0, (avail - used) * 0.42)

    P = []
    # ---------- fundo: foto + painel creme
    P.append(f'<image id="FOTO" x="0" y="0" width="{W}" height="{H}" '
             f'preserveAspectRatio="xMidYMid slice" '
             f'xlink:href="data:image/jpeg;base64,{photo_for(F)}"/>')
    pn = F['panel']
    P.append(f'<path id="PAINEL_CREME" d="{panel_path(pn["x0"], pn["y0"], pn["x1"], pn["y1"], pn["r"], pn["corners"])}" fill="{CREAM}"/>')
    P.append(logo_svg)

    # ---------- badge
    if cr['badge']:
        bt = cr['badge']
        bw = tw(bt, F['badge']['size'], 700, F['badge']['tracking']) + 2 * F['badge']['pad']
        dot_r = F['badge']['h'] * 0.145
        if cr['badge_dot']:
            bw += dot_r * 2 + 16
        bw = min(bw, inner)
        bx, bh = cx - bw / 2, F['badge']['h']
        P.append(f'<g id="BADGE"><rect x="{bx:.1f}" y="{y:.1f}" width="{bw:.1f}" height="{bh}" '
                 f'rx="{bh / 2:g}" fill="{NAVY}"/>')
        if cr['badge_dot']:
            P.append(f'<circle cx="{bx + F["badge"]["pad"] + dot_r:.1f}" cy="{y + bh / 2:.1f}" r="{dot_r:.1f}" fill="{RED}"/>')
            tx = cx + dot_r + 8
        else:
            tx = cx
        P.append(text_el(tx, y + bh / 2 + F['badge']['size'] * 0.36, bt, F['badge']['size'], 700,
                         ON_NAVY, 'middle', F['badge']['tracking'], 'BADGE_TEXTO'))
        P.append('</g>')
        y += bh + g_badge

    # ---------- headline
    P.append('<g id="HEADLINE">')
    lh = hs * F['hl']['lh']
    for i, ln in enumerate(hl):
        P.append(text_el(cx, y + lh * (i + 1) - lh * 0.28, ln, hs, 500, NAVY, 'middle',
                         F['hl']['tracking'], f'HEADLINE_L{i + 1}'))
    P.append('</g>')
    y += hl_h

    # ---------- filete dourado
    y += F['rule']['gap_top']
    P.append(f'<rect id="FILETE" x="{cx - F["rule"]["w"] / 2:g}" y="{y:.1f}" width="{F["rule"]["w"]}" height="1.6" fill="{GOLD}" opacity="0.85"/>')
    y += 1.6 + F['rule']['gap_bottom']

    # ---------- sub
    P.append('<g id="SUB">')
    slh = ss * F['sb']['lh']
    for i, ln in enumerate(sb):
        P.append(text_el(cx, y + slh * (i + 1) - slh * 0.3, ln, ss, 400, NAVY_SOFT, 'middle',
                         0, f'SUB_L{i + 1}'))
    P.append('</g>')
    y += sb_h

    # ---------- dados
    if cr['dados']:
        y += g_dados
        D = F['dados']
        P.append('<g id="DADOS">')
        if D['stack']:
            for i, (lab, val) in enumerate(cr['dados']):
                yy = y + i * 80
                if i:
                    P.append(f'<rect x="{cx - 60:g}" y="{yy - 18:.1f}" width="120" height="1" fill="{GOLD}" opacity="0.3"/>')
                P.append(text_el(cx, yy + D['label'], lab, D['label'], 500, GOLD, 'middle', D['lt'], f'DADO{i + 1}_LABEL'))
                P.append(text_el(cx, yy + D['label'] + 12 + D['value'], val, D['value'], 500, NAVY, 'middle', 0, f'DADO{i + 1}_VALOR'))
        else:
            n = len(cr['dados'])
            colw = inner / n
            x0 = cx - inner / 2
            for i, (lab, val) in enumerate(cr['dados']):
                ccx = x0 + colw * (i + 0.5)
                if i:
                    P.append(f'<rect x="{x0 + colw * i:.1f}" y="{y:.1f}" width="1" height="70" fill="{GOLD}" opacity="0.32"/>')
                P.append(text_el(ccx, y + D['label'] + 6, lab, D['label'], 500, GOLD, 'middle', D['lt'], f'DADO{i + 1}_LABEL'))
                P.append(text_el(ccx, y + D['label'] + 20 + D['value'], val, D['value'], 500, NAVY, 'middle', 0, f'DADO{i + 1}_VALOR'))
        P.append('</g>')

    # ---------- CTA
    cw = min(inner, max(tw(l, cs, 700, tk) for l in clines) + 2 * cpad)
    P.append(f'<g id="CTA"><rect x="{cx - cw / 2:.1f}" y="{cta_top:.1f}" '
             f'width="{cw:.1f}" height="{ch:.1f}" rx="{ch / 2:.1f}" fill="{NAVY}"/>')
    cy = cta_top + ch / 2
    off = -(len(clines) - 1) * cs * 0.61
    for i, l in enumerate(clines):
        P.append(text_el(cx, cy + off + i * cs * 1.22 + cs * 0.35, l, cs, 700, ON_NAVY, 'middle',
                         tk, 'CTA_TEXTO' + (f'_L{i + 1}' if len(clines) > 1 else '')))
    P.append('</g>')

    head = (f'<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" '
            f'width="{W}" height="{H}" viewBox="0 0 {W} {H}">\n'
            f'<!-- SOLENNE · A10 Empreendimentos — {cr["key"]} {F["name"]} — angulo investidor/incorporacao.\n'
            f'     Texto vivo em Helvetica Neue (editavel no Figma). Logo em curvas (vetor oficial). -->\n')
    return head + '\n'.join(P) + '\n</svg>\n'

# ---------------------------------------------------------------- main
if __name__ == '__main__':
    os.makedirs(OUT, exist_ok=True)

    files = []
    for cr in CREATIVES:
        for F in (FEED, STORIES):
            svg = build(cr, F)
            fn = f'Solenne_{cr["key"]}_{F["name"]}_{F["W"]}x{F["H"]}.svg'
            open(os.path.join(OUT, fn), 'w', encoding='utf-8').write(svg)
            files.append((fn, len(svg)))
            print(f'{fn:52s} {len(svg) / 1024:8.0f} KB')
    print(f'\n{len(files)} arquivos em {OUT}')
