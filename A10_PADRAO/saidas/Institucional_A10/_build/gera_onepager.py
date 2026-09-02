# -*- coding: utf-8 -*-
"""One-pager institucional A10 — 1080×2360, editável no Figma.

Mantém a moldura em pé 4:5 (a página é vertical). A versão com moldura deitada
é a apresentação, em ../apresentacao/.
"""
import pathlib
import sys

sys.path.insert(0, str(pathlib.Path(__file__).parent))
from padrao_a10 import (GOLD, SERIF, campo, documento, fundo, logo, moldura_foto,
                        moldura_peca, nome, paragrafo, regua, txt)

RAIZ = pathlib.Path(__file__).resolve().parents[4]
DEST = pathlib.Path(__file__).parent.parent
LOGO = (RAIZ / "A10_PADRAO/assets/a10.b64").read_text().strip().replace("\n", "")

W, H, INSET = 1080, 2360, 28
CW, CH, GAP = 221, 276, 22
LIN1, LIN2 = 1064, 1424
EMPS = ["Cape Town", "Holmes Residence", "Solenne",
        "Pátio Estaleiro", "Aurora", "Florence Garden"]

molduras = [f'  <g{nome("Portfolio")}>']
for i, rot in enumerate(EMPS):
    x = 186 + (CW + GAP) * (i % 3)          # 3 + 3, centradas
    y = LIN1 if i < 3 else LIN2
    molduras.append(moldura_foto(x, y, CW, CH, rot, i + 1, rx=10))
molduras.append('  </g>')

interior = "\n".join([
    fundo(W, H, [(1040, 200, 300, 0.10), (30, 2160, 260, 0.08)]),
    moldura_peca(W, H, INSET),
    logo(440, 96, 200, 79, LOGO),
    txt(540, 316, "Uma incorporadora", fonte=SERIF, tam=92, peso="600", rotulo="Headline 1"),
    txt(540, 418, "de alto padrão em", fonte=SERIF, tam=92, peso="600", rotulo="Headline 2"),
    txt(540, 520, "Balneário Camboriú", fonte=SERIF, tam=92, cor=GOLD, peso="600",
        rotulo="Headline 3"),
    regua(596, x=540, largura=150),
    txt(540, 676, "Quem somos", fonte=SERIF, tam=52, cor=GOLD, peso="600", rotulo="Titulo quem somos"),
    paragrafo([
        "A A10 desenvolve residências de alto padrão em Balneário",
        "Camboriú, em parceria com a R21 Empreendimentos. Do terreno",
        "à entrega das chaves, o cuidado está em cada detalhe do",
        "projeto: arquitetura, localização e acabamento.",
    ], 736, passo=36, x=540, tam=25, op="0.88"),
    regua(908, x=540, largura=150, rotulo="Regua 2"),
    txt(540, 988, "Nosso portfólio", fonte=SERIF, tam=52, cor=GOLD, peso="600", rotulo="Titulo portfolio"),
    txt(540, 1030, "Um portfólio que hoje reúne:", tam=19, op="0.55", rotulo="Olho"),
    "\n".join(molduras),
    campo(228, 1800, 624, 140, "FAIXA DE INVESTIMENTO", "a partir de R$ [inserir valor]",
          "Campo faixa de investimento", tam_valor=34),
    txt(540, 1972, "Variável por empreendimento", tam=12.5, op="0.45", rotulo="Nota"),
    regua(2020, x=540, largura=150, rotulo="Regua 3"),
    txt(540, 2096, "Como conduzimos o primeiro contato", fonte=SERIF, tam=52, cor=GOLD,
        peso="600", rotulo="Titulo primeiro contato"),
    paragrafo([
        "Antes de indicar qualquer empreendimento, buscamos entender",
        "o momento de quem está do outro lado: se o objetivo é",
        "moradia, investimento ou uma segunda residência. A partir",
        "disso, indicamos a opção que melhor se encaixa — não a que",
        "está em destaque no momento.",
    ], 2156, passo=36, x=540, tam=25, op="0.88"),
    txt(540, 2306, "A10 EMPREENDIMENTOS · BALNEÁRIO CAMBORIÚ · SC", tam=11.5, op="0.3",
        peso="500", espaco=3, rotulo="Assinatura"),
])

p = DEST / "Institucional_A10_OnePager_1080x2360.svg"
p.write_text(documento(W, H, interior, "A10 · One-pager institucional"), encoding="utf-8")
print("gerado:", p.name, p.stat().st_size, "bytes")
