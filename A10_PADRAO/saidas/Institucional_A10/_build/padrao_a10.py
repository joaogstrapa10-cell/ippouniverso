# -*- coding: utf-8 -*-
"""Peças A10 em SVG que o Figma abre editável.

Por que não usar CSS no SVG: o Figma ignora <style> e seletores de classe na
importação — o texto cai para a fonte padrão e some o Cormorant/Poppins. Então
aqui toda fonte vai como atributo de apresentação em cada <text>.

Mesma razão para não usar clipPath: o Figma transforma em máscara e a moldura
deixa de ser um retângulo simples. Cada moldura de foto é UM retângulo nomeado
— no Figma é só selecionar, Fill > Imagem, modo "Fill" (recorta sem esticar).

Nomes de camada saem do atributo id (sem espaço/acento, que é o que o XML
permite) com o rótulo bonito em data-name.
"""
import re
import unicodedata

# --- identidade (A10_PADRAO/INSTRUCOES.md) ----------------------------------
NAVY, CARD, GOLD, CREAM = "#0B1624", "#16233A", "#C9A86A", "#F5F0E6"
CARD_ESCURO = "#101B2C"
SERIF = "Cormorant Garamond"
SANS = "Poppins"


def ident(rotulo):
    """'Pátio Estaleiro' -> 'Patio_Estaleiro' (id válido em XML)."""
    sem_acento = unicodedata.normalize("NFKD", rotulo).encode("ascii", "ignore").decode()
    return re.sub(r"_+", "_", re.sub(r"[^A-Za-z0-9]+", "_", sem_acento)).strip("_")


def nome(rotulo):
    return f' id="{ident(rotulo)}" data-name="{rotulo}"'


def txt(x, y, conteudo, fonte=SANS, tam=30, cor=CREAM, peso="400", anc="middle",
        op=None, italico=False, espaco=None, rotulo=None):
    partes = [f'font-family="{fonte}"', f'font-size="{tam}"', f'font-weight="{peso}"']
    if italico:
        partes.append('font-style="italic"')
    if espaco is not None:
        partes.append(f'letter-spacing="{espaco}"')
    if op is not None:
        partes.append(f'fill-opacity="{op}"')
    return (f'  <text{nome(rotulo) if rotulo else ""} x="{x}" y="{y}" text-anchor="{anc}"'
            f' fill="{cor}" {" ".join(partes)}>{conteudo}</text>')


def paragrafo(linhas, y0, passo=44, x=960, **kw):
    return "\n".join(txt(x, y0 + passo * i, l, **kw) for i, l in enumerate(linhas))


def regua(y, x=960, largura=200, rotulo="Regua"):
    return (f'  <line{nome(rotulo)} x1="{x - largura // 2}" y1="{y}" x2="{x + largura // 2}"'
            f' y2="{y}" stroke="{GOLD}" stroke-opacity="0.5"/>')


def linha(x1, y1, x2, y2, op=0.5, rotulo="Linha"):
    return (f'  <line{nome(rotulo)} x1="{x1}" y1="{y1}" x2="{x2}" y2="{y2}"'
            f' stroke="{GOLD}" stroke-opacity="{op}"/>')


def marca_de_foto(cx, cy, medida, escala=1.8, rotulo="Marca", compacta=False):
    """Ícone + rótulo que sinalizam moldura vazia. No Figma: apague este grupo
    depois de colocar a foto."""
    if compacta:
        return f"""  <g{nome(rotulo)} opacity="0.5">
    <g transform="translate({cx},{cy - 12}) scale(1.15)">
      <rect x="-18" y="-14" width="36" height="28" rx="3" fill="none" stroke="{GOLD}" stroke-width="2"/>
      <circle cx="-8" cy="-6" r="3" fill="none" stroke="{GOLD}" stroke-width="2"/>
      <path d="M-18 10 L-4 -2 L4 6 L10 -1 L18 10" fill="none" stroke="{GOLD}" stroke-width="2" stroke-linejoin="round" stroke-linecap="round"/>
    </g>
{txt(cx, cy + 32, "FOTO", tam=11, cor=GOLD, peso="500", espaco=1.5)}
{txt(cx, cy + 50, medida, tam=9.5, cor=GOLD)}
  </g>"""
    return f"""  <g{nome(rotulo)} opacity="0.5">
    <g transform="translate({cx},{cy - 20}) scale({escala})">
      <rect x="-18" y="-14" width="36" height="28" rx="3" fill="none" stroke="{GOLD}" stroke-width="2"/>
      <circle cx="-8" cy="-6" r="3" fill="none" stroke="{GOLD}" stroke-width="2"/>
      <path d="M-18 10 L-4 -2 L4 6 L10 -1 L18 10" fill="none" stroke="{GOLD}" stroke-width="2" stroke-linejoin="round" stroke-linecap="round"/>
    </g>
{txt(cx, cy + 40, "FOTO", tam=15, cor=GOLD, peso="500", espaco=2)}
{txt(cx, cy + 64, medida, tam=12, cor=GOLD)}
  </g>"""


def moldura_foto(x, y, w, h, rotulo_emp, indice, rx=12, tam_nome=36, dy_nome=62,
                 compacta=False):
    """Um retângulo nomeado por empreendimento + a marca de vazio + o nome."""
    cx, cy = x + w / 2, y + h / 2
    tracejado = "6 6" if compacta else "8 8"
    return f"""
  <g{nome(f"Foto {indice} - {rotulo_emp}")}>
    <rect{nome(f"Moldura {rotulo_emp}")} x="{x}" y="{y}" width="{w}" height="{h}" rx="{rx}"
      fill="{CARD}" stroke="{GOLD}" stroke-width="1.5" stroke-dasharray="{tracejado}" stroke-opacity="0.7"/>
{marca_de_foto(cx, cy, f"{w}×{h}px", rotulo=f"Marca {rotulo_emp}", compacta=compacta)}
{txt(cx, y + h + dy_nome, rotulo_emp, fonte=SERIF, tam=tam_nome, peso="500", italico=True,
     rotulo=f"Nome {rotulo_emp}")}
  </g>"""


def campo(x, y, w, h, rotulo, valor, rotulo_camada, tam_valor=38):
    """Campo tracejado a preencher (faixa de investimento, contato…)."""
    cx = x + w / 2
    return f"""
  <g{nome(rotulo_camada)}>
    <rect x="{x}" y="{y}" width="{w}" height="{h}" fill="{CARD_ESCURO}" fill-opacity="0.55"
      stroke="{GOLD}" stroke-width="1" stroke-dasharray="5 5" stroke-opacity="0.45"/>
{txt(cx, y + 42, rotulo, tam=14, cor=GOLD, peso="500", op="0.85", espaco=3.5)}
{txt(cx, y + 88, valor, fonte=SERIF, tam=tam_valor, peso="500", op="0.6", italico=True)}
  </g>"""


def fundo(w, h, circulos):
    linhas = [f'  <g{nome("Fundo")}>',
              f'    <rect x="0" y="0" width="{w}" height="{h}" fill="{NAVY}"/>']
    for cx, cy, r, op in circulos:
        linhas.append(f'    <circle cx="{cx}" cy="{cy}" r="{r}" fill="none" stroke="{GOLD}"'
                      f' stroke-width="1" opacity="{op}"/>')
    linhas.append('  </g>')
    return "\n".join(linhas)


def moldura_peca(w, h, inset):
    return (f'  <rect{nome("Moldura da peca")} x="{inset}" y="{inset}" width="{w - 2 * inset}"'
            f' height="{h - 2 * inset}" fill="none" stroke="{GOLD}" stroke-width="1.2"'
            f' opacity="0.45"/>')


def logo(x, y, w, h, b64, rotulo="Logo A10"):
    return (f'  <image{nome(rotulo)} x="{x}" y="{y}" width="{w}" height="{h}"'
            f' preserveAspectRatio="xMidYMid meet" xlink:href="data:image/png;base64,{b64}"/>')


def documento(w, h, interior, titulo):
    """SVG sem <style> e sem <defs>: nada que o Figma precise interpretar."""
    return f"""<?xml version="1.0" encoding="UTF-8"?>
<!-- {titulo}
     Padrão A10: navy #0B1624 + dourado #C9A86A, Cormorant Garamond + Poppins.
     Editável no Figma: fonte vai como atributo em cada texto (sem CSS), nenhuma
     máscara/clipPath e cada camada nomeada. Para entrar com a foto, selecione o
     retângulo "Moldura <empreendimento>", Fill > Image, modo Fill — recorta sem
     esticar — e apague o grupo "Marca <empreendimento>". -->
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="{w}" height="{h}" viewBox="0 0 {w} {h}">
{interior}
</svg>
"""
