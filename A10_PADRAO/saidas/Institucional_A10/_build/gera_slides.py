# -*- coding: utf-8 -*-
"""Apresentação institucional A10 — 6 slides 1920×1080, editáveis no Figma."""
import pathlib
import sys

sys.path.insert(0, str(pathlib.Path(__file__).parent))
from padrao_a10 import (CREAM, GOLD, SANS, SERIF, campo, documento, fundo, logo,
                        moldura_foto, moldura_peca, nome, paragrafo, regua, txt)

RAIZ = pathlib.Path(__file__).resolve().parents[4]
DEST = pathlib.Path(__file__).parent.parent / "apresentacao"
DEST.mkdir(parents=True, exist_ok=True)
LOGO = (RAIZ / "A10_PADRAO/assets/a10.b64").read_text().strip().replace("\n", "")

W, H, INSET = 1920, 1080, 44
CW, CH, GAP = 420, 525, 40          # moldura vertical 4:5
GRID_Y = 230
GRID_X = 290                        # 3 molduras centradas na tela

EMPS = ["Cape Town", "Holmes Residence", "Solenne",
        "Pátio Estaleiro", "Aurora", "Florence Garden"]     # 3 por slide

CIRCULOS = [(1860, 120, 340, 0.10), (60, 1000, 280, 0.08)]


def base(numero, total=6, com_logo=True):
    partes = [fundo(W, H, CIRCULOS), moldura_peca(W, H, INSET)]
    if com_logo:
        partes.append(logo(96, 86, 150, 59, LOGO))
        partes.append(txt(1824, 1000, f"{numero:02d} / {total:02d}", tam=14, cor=GOLD,
                          op="0.5", peso="500", anc="end", espaco=3, rotulo="Paginacao"))
    return "\n".join(partes)


def fila(rotulos, x0, primeiro):
    corpo = [f'  <g{nome("Portfolio")}>']
    for j, rot in enumerate(rotulos):
        corpo.append(moldura_foto(x0 + (CW + GAP) * j, GRID_Y, CW, CH, rot, primeiro + j,
                                  tam_nome=32, dy_nome=52))
    corpo.append('  </g>')
    return "\n".join(corpo)


# ------------------------------------------------------------------ 01 capa
capa = "\n".join([
    base(1, com_logo=False),
    logo(830, 250, 260, 102, LOGO),
    regua(432),
    txt(960, 552, "Uma incorporadora", fonte=SERIF, tam=120, peso="600", rotulo="Headline 1"),
    txt(960, 678, "de alto padrão em", fonte=SERIF, tam=120, peso="600", rotulo="Headline 2"),
    txt(960, 804, "Balneário Camboriú", fonte=SERIF, tam=120, cor=GOLD, peso="600",
        rotulo="Headline 3"),
    txt(960, 968, "A10 EMPREENDIMENTOS · BALNEÁRIO CAMBORIÚ · SC", tam=14, op="0.35",
        peso="500", espaco=4, rotulo="Assinatura"),
])

# ------------------------------------------------------------- 02 quem somos
quem = "\n".join([
    base(2),
    regua(320),
    txt(960, 428, "Quem somos", fonte=SERIF, tam=76, cor=GOLD, peso="600", rotulo="Titulo"),
    paragrafo([
        "A A10 desenvolve residências de alto padrão em Balneário",
        "Camboriú, em parceria com a R21 Empreendimentos. Do terreno",
        "à entrega das chaves, o cuidado está em cada detalhe do",
        "projeto: arquitetura, localização e acabamento.",
    ], 540, op="0.88"),
])

# ------------------------------------------------------- 03 e 04 portfólio
portfolio1 = "\n".join([
    base(3),
    txt(960, 132, "Nosso portfólio", fonte=SERIF, tam=64, cor=GOLD, peso="600", rotulo="Titulo"),
    txt(960, 178, "Um portfólio que hoje reúne:", tam=22, op="0.55", rotulo="Olho"),
    fila(EMPS[:3], GRID_X, 1),
])

portfolio2 = "\n".join([
    base(4),
    txt(960, 150, "NOSSO PORTFÓLIO", tam=20, cor=GOLD, peso="500", op="0.85", espaco=6,
        rotulo="Titulo"),
    fila(EMPS[3:], GRID_X, 4),
    campo(610, 862, 700, 118, "FAIXA DE INVESTIMENTO", "a partir de R$ [inserir valor]",
          "Campo faixa de investimento", tam_valor=34, dy_rotulo=40, dy_valor=84),
    txt(960, 1008, "Variável por empreendimento", tam=13, op="0.45", rotulo="Nota"),
])

# ------------------------------------------------------- 05 primeiro contato
contato = "\n".join([
    base(5),
    regua(300),
    txt(960, 408, "Como conduzimos o primeiro contato", fonte=SERIF, tam=76, cor=GOLD,
        peso="600", rotulo="Titulo"),
    paragrafo([
        "Antes de indicar qualquer empreendimento, buscamos entender",
        "o momento de quem está do outro lado: se o objetivo é",
        "moradia, investimento ou uma segunda residência. A partir",
        "disso, indicamos a opção que melhor se encaixa — não a que",
        "está em destaque no momento.",
    ], 524, op="0.88"),
])

# ------------------------------------------------------------ 06 fechamento
CAMPOS = [("TELEFONE / WHATSAPP", "[inserir número]"),
          ("INSTAGRAM", "[inserir @]"),
          ("SITE", "[inserir endereço]")]
fechamento = "\n".join([
    base(6, com_logo=False),
    logo(830, 228, 260, 102, LOGO),
    regua(400),
    txt(960, 530, "Vamos conversar?", fonte=SERIF, tam=96, peso="600", rotulo="Titulo"),
    txt(960, 600, "Conte em que momento você está — a indicação vem depois.", tam=24,
        op="0.7", rotulo="Apoio"),
    "\n".join(campo(340 + k * 430, 700, 380, 126, rot, val, f"Campo {rot}", tam_valor=34)
              for k, (rot, val) in enumerate(CAMPOS)),
    txt(960, 968, "A10 EMPREENDIMENTOS · BALNEÁRIO CAMBORIÚ · SC", tam=14, op="0.35",
        peso="500", espaco=4, rotulo="Assinatura"),
])

SLIDES = [
    ("01_Capa", "Slide 01 · Capa", capa),
    ("02_QuemSomos", "Slide 02 · Quem somos", quem),
    ("03_Portfolio_1de2", "Slide 03 · Nosso portfólio (1/2)", portfolio1),
    ("04_Portfolio_2de2", "Slide 04 · Nosso portfólio (2/2)", portfolio2),
    ("05_PrimeiroContato", "Slide 05 · Como conduzimos o primeiro contato", contato),
    ("06_Fechamento", "Slide 06 · Vamos conversar", fechamento),
]

for arquivo, titulo, interior in SLIDES:
    p = DEST / f"A10_Apresentacao_{arquivo}_1920x1080.svg"
    p.write_text(documento(W, H, interior, f"A10 · {titulo}"), encoding="utf-8")
    print("gerado:", p.name, p.stat().st_size, "bytes")
