# -*- coding: utf-8 -*-
"""A10 · tudo em uma página, formato grande — 2480×1754 deitado.

Proporção A-series (√2): imprime exato em A3, A2 ou A1 sem recorte, e como é
vetor não perde nada ao ampliar. Coluna de texto à esquerda; o portfólio ocupa
a direita com 7 molduras verticais 4:5 em 4 + 3, e a faixa de investimento
fecha a folha embaixo. Editável no Figma.
"""
import pathlib
import sys

sys.path.insert(0, str(pathlib.Path(__file__).parent))
from padrao_a10 import (GOLD, SERIF, campo, documento, fundo, linha, logo,
                        moldura_foto, moldura_peca, nome, paragrafo, txt)

RAIZ = pathlib.Path(__file__).resolve().parents[4]
DEST = pathlib.Path(__file__).parent.parent
LOGO = (RAIZ / "A10_PADRAO/assets/a10.b64").read_text().strip().replace("\n", "")

W, H, INSET = 2480, 1754, 60
ESQ, COL, DIR = 120, 800, 2360      # coluna de texto · início do portfólio · margem
CW, CH, GAP = 498, 622, 32          # moldura vertical 4:5 — 498×622px
EMPS = ["Cape Town", "Holmes Residence", "Solenne",
        "Pátio Estaleiro", "Aurora", "Florence Garden"]        # 3 + 3

# ------------------------------------------------- coluna de texto (esquerda)
coluna = [
    logo(ESQ, 130, 200, 79, LOGO),

    txt(ESQ, 330, "Uma incorporadora", fonte=SERIF, tam=58, peso="600", anc="start",
        rotulo="Headline 1"),
    txt(ESQ, 396, "de alto padrão em", fonte=SERIF, tam=58, peso="600", anc="start",
        rotulo="Headline 2"),
    txt(ESQ, 462, "Balneário Camboriú", fonte=SERIF, tam=58, cor=GOLD, peso="600",
        anc="start", rotulo="Headline 3"),
    linha(ESQ, 520, ESQ + 200, 520, 0.5, "Regua"),

    txt(ESQ, 570, "QUEM SOMOS", tam=14, cor=GOLD, peso="500", op="0.85", espaco=4,
        anc="start", rotulo="Rotulo quem somos"),
    paragrafo([
        "A A10 desenvolve residências de alto",
        "padrão em Balneário Camboriú, em parceria",
        "com a R21 Empreendimentos. Do terreno à",
        "entrega das chaves, o cuidado está em cada",
        "detalhe do projeto: arquitetura, localização",
        "e acabamento.",
    ], 612, passo=30, x=ESQ, tam=20, op="0.88", anc="start"),

    campo(ESQ, 830, 600, 150, "FAIXA DE INVESTIMENTO", "a partir de R$ [inserir valor]",
          "Campo faixa de investimento", tam_valor=40, tam_rotulo=15, dy_rotulo=52,
          dy_valor=112),
    txt(ESQ + 300, 1006, "Variável por empreendimento", tam=14, op="0.45",
        rotulo="Nota investimento"),

    txt(ESQ, 1064, "COMO CONDUZIMOS O PRIMEIRO CONTATO", tam=14, cor=GOLD, peso="500",
        op="0.85", espaco=2.5, anc="start", rotulo="Rotulo primeiro contato"),
    paragrafo([
        "Antes de indicar qualquer empreendimento,",
        "buscamos entender o momento de quem está do",
        "outro lado: se o objetivo é moradia, investimento",
        "ou uma segunda residência. A partir disso,",
        "indicamos a opção que melhor se encaixa — não",
        "a que está em destaque no momento.",
    ], 1106, passo=29, x=ESQ, tam=19, op="0.88", anc="start"),

    txt(ESQ, 1360, "Vamos conversar?", fonte=SERIF, tam=38, cor=GOLD, peso="600",
        anc="start", rotulo="Titulo fechamento"),
]
CONTATO = [("TELEFONE / WHATSAPP", "[inserir número]"),
           ("INSTAGRAM", "[inserir @]"),
           ("SITE", "[inserir endereço]")]
for k, (rotulo, valor) in enumerate(CONTATO):
    y = 1430 + k * 44
    coluna.append(f'  <g{nome(f"Campo {rotulo}")}>')
    coluna.append(txt(ESQ, y, rotulo, tam=13, cor=GOLD, peso="500", op="0.8", espaco=2.5,
                      anc="start"))
    coluna.append(txt(ESQ + 250, y, valor, fonte=SERIF, tam=22, peso="500", op="0.55",
                      italico=True, anc="start"))
    coluna.append('  </g>')
coluna.append(txt(ESQ, 1660, "A10 EMPREENDIMENTOS · BALNEÁRIO CAMBORIÚ · SC", tam=13,
                  op="0.3", peso="500", espaco=3.5, anc="start", rotulo="Assinatura"))

# ------------------------------------------------------- portfólio (direita)
portfolio = [
    linha(740, 130, 740, 1640, 0.18, "Divisor vertical"),
    txt(COL, 172, "NOSSO PORTFÓLIO", tam=17, cor=GOLD, peso="500", op="0.9", espaco=6,
        anc="start", rotulo="Rotulo portfolio"),
    txt(DIR, 172, "Um portfólio que hoje reúne:", tam=19, op="0.5", anc="end",
        rotulo="Olho"),
    f'  <g{nome("Portfolio")}>',
]
LARG = DIR - COL                                   # 1560
for i, rot in enumerate(EMPS):                     # 3 em cima, 3 embaixo
    x = COL + (CW + GAP) * (i % 3)
    y = 232 if i < 3 else 934
    portfolio.append(moldura_foto(x, y, CW, CH, rot, i + 1, rx=12, tam_nome=34,
                                  dy_nome=54))
portfolio.append('  </g>')

interior = "\n".join([
    fundo(W, H, [(2400, 160, 440, 0.10), (80, 1620, 360, 0.08)]),
    moldura_peca(W, H, INSET),
    *coluna, *portfolio,
])

p = DEST / "Institucional_A10_UmaPagina_A3_2480x1754.svg"
p.write_text(documento(W, H, interior, "A10 · Institucional em uma página (formato grande)"),
             encoding="utf-8")
print("gerado:", p.name, p.stat().st_size, "bytes · moldura", CW, "x", CH)
