# -*- coding: utf-8 -*-
"""A10 · tudo em uma página — 1920×1080 deitado, editável no Figma.

Três faixas: masthead + Quem somos · os 7 empreendimentos · investimento,
primeiro contato e contato.
"""
import pathlib
import sys

sys.path.insert(0, str(pathlib.Path(__file__).parent))
from padrao_a10 import (CREAM, GOLD, SERIF, campo, documento, fundo, linha, logo,
                        moldura_foto, moldura_peca, nome, paragrafo, txt)

RAIZ = pathlib.Path(__file__).resolve().parents[4]
DEST = pathlib.Path(__file__).parent.parent
LOGO = (RAIZ / "A10_PADRAO/assets/a10.b64").read_text().strip().replace("\n", "")

W, H, INSET = 1920, 1080, 44
ESQ, DIR = 90, 1830                 # margens de conteúdo
CW, CH, GAP = 233, 155, 18          # moldura deitada 3:2, 7 em fila
EMPS = ["Cape Town", "Holmes Residence", "Solenne", "Pátio Estaleiro",
        "Aurora", "Diamond Hill", "Florence Garden"]

# ---------------------------------------------------- faixa 1: marca + quem somos
masthead = [
    logo(ESQ, 92, 168, 66, LOGO),
    linha(300, 96, 300, 252, 0.3, "Regua vertical"),
    txt(340, 152, "Uma incorporadora de alto padrão", fonte=SERIF, tam=58, peso="600",
        anc="start", rotulo="Headline 1"),
    txt(340, 214, "em Balneário Camboriú", fonte=SERIF, tam=58, cor=GOLD, peso="600",
        anc="start", rotulo="Headline 2"),
    txt(1230, 110, "QUEM SOMOS", tam=13, cor=GOLD, peso="500", op="0.85", espaco=4,
        anc="start", rotulo="Rotulo quem somos"),
    paragrafo([
        "A A10 desenvolve residências de alto padrão em",
        "Balneário Camboriú, em parceria com a R21",
        "Empreendimentos. Do terreno à entrega das chaves,",
        "o cuidado está em cada detalhe do projeto:",
        "arquitetura, localização e acabamento.",
    ], 158, passo=30, x=1230, tam=19, op="0.88", anc="start"),
]

# ------------------------------------------------------- faixa 2: portfólio
portfolio = [
    linha(ESQ, 330, DIR, 330, 0.2, "Divisor 1"),
    txt(ESQ, 404, "NOSSO PORTFÓLIO", tam=16, cor=GOLD, peso="500", op="0.9", espaco=6,
        anc="start", rotulo="Rotulo portfolio"),
    txt(DIR, 404, "Um portfólio que hoje reúne:", tam=17, op="0.5", anc="end",
        rotulo="Olho"),
    f'  <g{nome("Portfolio")}>',
]
for i, rot in enumerate(EMPS):
    portfolio.append(moldura_foto(ESQ + (CW + GAP) * i, 470, CW, CH, rot, i + 1,
                                  rx=8, tam_nome=24, dy_nome=43, compacta=True))
portfolio.append('  </g>')

# --------------------------------- faixa 3: investimento · contato · fechamento
base = [
    linha(ESQ, 726, DIR, 726, 0.2, "Divisor 2"),
    linha(630, 776, 630, 960, 0.18, "Divisor vertical 1"),
    linha(1360, 776, 1360, 960, 0.18, "Divisor vertical 2"),

    campo(ESQ, 776, 500, 118, "FAIXA DE INVESTIMENTO", "a partir de R$ [inserir valor]",
          "Campo faixa de investimento", tam_valor=30),
    txt(ESQ + 250, 922, "Variável por empreendimento", tam=12.5, op="0.45",
        rotulo="Nota investimento"),

    txt(690, 800, "COMO CONDUZIMOS O PRIMEIRO CONTATO", tam=13, cor=GOLD, peso="500",
        op="0.85", espaco=3, anc="start", rotulo="Rotulo primeiro contato"),
    paragrafo([
        "Antes de indicar qualquer empreendimento, buscamos entender",
        "o momento de quem está do outro lado: se o objetivo é moradia,",
        "investimento ou uma segunda residência. A partir disso,",
        "indicamos a opção que melhor se encaixa — não a que está em",
        "destaque no momento.",
    ], 834, passo=28, x=690, tam=18, op="0.88", anc="start"),

    txt(1420, 806, "Vamos conversar?", fonte=SERIF, tam=38, cor=GOLD, peso="600",
        anc="start", rotulo="Titulo fechamento"),
]
CONTATO = [("TELEFONE / WHATSAPP", "[inserir número]"),
           ("INSTAGRAM", "[inserir @]"),
           ("SITE", "[inserir endereço]")]
for k, (rotulo, valor) in enumerate(CONTATO):
    y = 856 + k * 46
    base.append(f'  <g{nome(f"Campo {rotulo}")}>')
    base.append(txt(1420, y, rotulo, tam=11, cor=GOLD, peso="500", op="0.8", espaco=2.5,
                    anc="start"))
    base.append(txt(1420, y + 22, valor, fonte=SERIF, tam=22, peso="500", op="0.55",
                    italico=True, anc="start"))
    base.append('  </g>')
base.append(txt(960, 1006, "A10 EMPREENDIMENTOS · BALNEÁRIO CAMBORIÚ · SC", tam=12,
                op="0.3", peso="500", espaco=4, rotulo="Assinatura"))

interior = "\n".join([
    fundo(W, H, [(1860, 120, 340, 0.10), (60, 1000, 280, 0.08)]),
    moldura_peca(W, H, INSET),
    *masthead, *portfolio, *base,
])

p = DEST / "Institucional_A10_UmaPagina_1920x1080.svg"
p.write_text(documento(W, H, interior, "A10 · Institucional em uma página"), encoding="utf-8")
print("gerado:", p.name, p.stat().st_size, "bytes")
