#!/usr/bin/env python3
"""
Prepara os retratos do convite a partir das fotos originais.

1. Remove o fundo (rembg / isnet-general-use).
2. Enquadra em 2:3 normalizando pela cabeca, para os dois retratos sairem com
   a mesma escala de rosto e a mesma linha de olhos.
3. Converte o sujeito para monocromatico quente (duotone navy -> creme), em vez
   de cinza puro, para casar com a paleta do convite.
4. Compoe sobre fundo navy #0B1624 com halo champagne atras da cabeca, mesmo
   fundo para os dois.

Saida em _fotos/ e os arquivos finais adilson.jpg / rafa.jpg ao lado do HTML.
"""
import pathlib

import numpy as np
from PIL import Image, ImageFilter

HERE = pathlib.Path(__file__).resolve().parent
OUT = HERE.parent
FOTOS = OUT / "_fotos"

W, H = 900, 1350            # 2:3
NAVY = (11, 22, 36)         # #0B1624
CHAMPAGNE = (193, 156, 81)  # #C19C51
CREAM = (240, 235, 221)     # #F0EBDD
CREAM_HI = (240, 238, 232)  # alta luz do duotone
GLOW = (50, 64, 80)         # navy levantado do halo (12% de champagne dentro)
SHADOW = (44, 45, 49)       # sombra do duotone: levantada, separa roupa escura do fundo

HEAD_TOP_FRAC = 0.065       # onde comeca o topo da cabeca
HEAD_W_FRAC = 0.325         # largura da cabeca / largura do quadro
FADE_INI, FADE_FIM = 0.68, 0.95   # dissolucao do sujeito no pe do quadro

FONTES = [("origem_1.webp", "adilson", "Adilson"),
          ("origem_2.webp", "rafa", "Rafael")]


def recorta(nome_src):
    from rembg import remove, new_session
    global _SESS
    try:
        _SESS
    except NameError:
        _SESS = new_session("isnet-general-use")
    im = Image.open(FOTOS / nome_src).convert("RGBA")
    return remove(im, session=_SESS, post_process_mask=True)


def metrica_cabeca(alpha):
    """Topo da cabeca, largura da cabeca e centro horizontal do rosto."""
    m = np.asarray(alpha, dtype=np.float32) / 255.0
    linhas = (m > 0.5).sum(axis=1)
    presentes = np.nonzero(linhas)[0]
    topo, base = int(presentes[0]), int(presentes[-1])
    altura = base - topo

    # largura tipica da cabeca: mediana das linhas na primeira faixa do sujeito
    faixa = linhas[topo:topo + max(8, int(altura * 0.14))]
    larg_cabeca = float(np.median(faixa[faixa > 0]))

    # centro horizontal medido na cabeca (nao no bbox: bracos cruzados deslocam)
    cab = m[topo:topo + max(8, int(altura * 0.20))] > 0.5
    cols = np.nonzero(cab.any(axis=0))[0]
    cx = float((cols[0] + cols[-1]) / 2) if len(cols) else m.shape[1] / 2
    return topo, larg_cabeca, cx


def enquadra(rgba):
    """Escala e posiciona o sujeito num quadro 2:3, normalizando pela cabeca."""
    topo, larg_cabeca, cx = metrica_cabeca(rgba.split()[3])
    escala = (HEAD_W_FRAC * W) / max(1.0, larg_cabeca)
    nw, nh = max(1, round(rgba.width * escala)), max(1, round(rgba.height * escala))
    esc = rgba.resize((nw, nh), Image.LANCZOS)

    dx = round(W / 2 - cx * escala)
    dy = round(HEAD_TOP_FRAC * H - topo * escala)
    quadro = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    quadro.alpha_composite(esc, (dx, dy))
    return dissolve_pe(quadro)


def dissolve_pe(rgba):
    """Dissolve o sujeito no pe do quadro: os dois originais sao recortes na
    altura do peito, e sem isso a foto termina num corte reto horizontal."""
    a = np.asarray(rgba.split()[3], dtype=np.float32) / 255.0
    y = np.linspace(0.0, 1.0, H, dtype=np.float32)
    t = np.clip((y - FADE_INI) / (FADE_FIM - FADE_INI), 0.0, 1.0)
    a *= (1.0 - t * t * (3 - 2 * t))[:, None]
    out = rgba.copy()
    out.putalpha(Image.fromarray((a * 255).astype(np.uint8), "L"))
    return out


def fundo():
    """Navy com halo champagne atras da cabeca + queda de luz no pe do quadro."""
    yy, xx = np.mgrid[0:H, 0:W].astype(np.float32)
    nx = (xx - W * 0.50) / (H * 0.62)
    ny = (yy - H * 0.30) / (H * 0.62)
    r = np.sqrt(nx * nx + ny * ny)

    t = np.clip(1.0 - r, 0.0, 1.0)
    halo = (t * t * (3 - 2 * t))[..., None]                 # smoothstep

    base = np.array(NAVY, dtype=np.float32)[None, None, :]
    img = base + (np.array(GLOW, dtype=np.float32)[None, None, :] - base) * halo

    queda = np.clip((yy / H - 0.52) / 0.48, 0.0, 1.0)[..., None] ** 1.6
    img *= 1.0 - 0.52 * queda

    rng = np.random.default_rng(7)
    img += rng.normal(0.0, 2.2, img.shape)                  # grao, evita banding
    return np.clip(img, 0, 255)


def duotone(rgba):
    """Sujeito em monocromatico quente: sombras navy, altas luzes creme."""
    arr = np.asarray(rgba, dtype=np.float32)
    rgb, a = arr[..., :3], arr[..., 3:4] / 255.0

    lum = (0.2126 * rgb[..., 0] + 0.7152 * rgb[..., 1] + 0.0722 * rgb[..., 2]) / 255.0
    lum = np.clip((lum - 0.5) * 1.18 + 0.5, 0.0, 1.0)       # contraste suave
    lum = lum * lum * (3 - 2 * lum) * 0.35 + lum * 0.65     # curva S leve
    lum = lum[..., None]

    s = np.array(SHADOW, dtype=np.float32)[None, None, :]
    h = np.array(CREAM_HI, dtype=np.float32)[None, None, :]
    return s + (h - s) * lum, a


def limpa_borda(alpha):
    """Encolhe 1px e suaviza: mata a franja da cor do fundo original."""
    a = alpha.filter(ImageFilter.MinFilter(3))
    return a.filter(ImageFilter.GaussianBlur(0.7))


def main():
    bg = fundo()
    for src, slug, nome in FONTES:
        rec = recorta(src)
        rec.putalpha(limpa_borda(rec.split()[3]))
        rec.save(FOTOS / f"recorte_{slug}.png")             # cutout reutilizavel

        quadro = enquadra(rec)
        rgb, a = duotone(quadro)
        comp = np.clip(bg * (1 - a) + rgb * a, 0, 255).astype(np.uint8)

        img = Image.fromarray(comp, "RGB")
        img.save(FOTOS / f"retrato_{slug}.png")
        img.save(OUT / f"{slug}.jpg", quality=94, subsampling=0, optimize=True)
        print(f"{nome:8s} -> {slug}.jpg  {img.size}  "
              f"({(OUT / f'{slug}.jpg').stat().st_size / 1024:.0f} KB)")


if __name__ == "__main__":
    main()
