# Convite · Coinvestimento imobiliário em Balneário Camboriú — v3

Convite em PDF, A4 paisagem, 3 páginas, para o grupo fechado de cirurgiões-dentistas
(Rafael, PH, Monte Alto, A10 Investimentos).

A v3 abre pelas pessoas: p.1 apresenta Adilson e Rafa, p.2 conta as duas histórias,
p.3 explica o formato e o encontro. Sem número de rentabilidade, sem promessa de
retorno, sem link — o CTA é responder a mensagem.

## Arquivos

| Arquivo | O que é |
|---|---|
| `CONVITE_BC_ODONTO_INVEST_v3.html` | **fonte único** (HTML + CSS, sem dependência externa além das fontes) |
| `CONVITE_BC_ODONTO_INVEST_v3.pdf` | PDF canônico — sai com a paleta que estiver no `<body>` do HTML |
| `CONVITE_BC_ODONTO_INVEST_v3_A_escura.pdf` | Variação A · p.1 navy · p.2 creme · p.3 navy |
| `CONVITE_BC_ODONTO_INVEST_v3_B_creme.pdf` | Variação B · creme dominante, navy só nos blocos de destaque |
| `preview/` | páginas rasterizadas (150 dpi) + comparativos A × B |
| `_build/render.py` | script de render (Playwright + Chromium) |
| `_build/fonts/` | cache local das fontes do Google Fonts, para render offline |

## Trocar a variação de paleta

No `<body>` do HTML, troque a classe: `pal-a` (escuras alternadas) ou `pal-b`
(creme dominante). Só isso — todas as cores derivam de tokens por superfície.
Depois rode o render de novo.

## Trocar os retratos pelas fotos reais

Os blocos de retrato já estão no tamanho e na proporção finais (**recorte vertical
2:3**, ex.: 43 × 64,5 mm na p.1). Para entrar com as fotos:

1. Salve `adilson.jpg` e `rafa.jpg` na mesma pasta do HTML.
2. Descomente o bloco `RETRATOS REAIS` no fim do CSS.

Isso já aplica preto e branco (`grayscale`), recorte sem distorção (`cover`) e
esconde o rótulo do placeholder. Uma edição cobre os dois lugares onde cada pessoa
aparece (p.1 e p.2).

## Re-renderizar

```bash
cd _build && python3 render.py
```

Requer `playwright` (pip) e o Chromium em `/opt/pw-browsers/chromium`. O script
intercepta `fonts.googleapis.com` / `fonts.gstatic.com` e responde com o cache de
`_build/fonts`, então funciona sem internet. O HTML mantém o `<link>` normal do
Google Fonts, e por isso abre certo em qualquer máquina com rede.

Depois de gerar, o script confere sozinho: largura da página (para pegar o
*shrink-to-fit* do Chromium), altura de cada página e se as duas fontes realmente
entraram no render em vez de cair no fallback.

## Identidade

- Navy `#0B1624` · champagne `#C19C51` · creme `#F0EBDD`
- Cormorant Garamond (títulos, nomes, citações, numerais) + Inter (corpo, labels)
- Sem sombra, sem ícone, sem emoji; raio de canto 4px; filetes de 1px em champagne

Nota: o padrão A10 usa Poppins na sans; aqui o corpo é Inter, conforme pedido para
esta peça.

## Ainda pendente (sai destacado em champagne no PDF)

**Adilson** — anos de mercado · nº de empreendimentos entregues · ano de fundação da
A10 · como começou (origem / primeira obra / o que fazia antes) · frase própria sobre
por que só constrói em BC · detalhe humano (família, rotina de obra).

**Rafael Monte Alto** — ano do primeiro investimento · como conheceu o Adilson · o que
o convenceu · resultado do primeiro aporte · motivo de abrir para o grupo.

**A definir** — se o PH entra como terceira pessoa no material ou permanece só como
participante do grupo. Hoje ele não aparece; a p.1 está montada para duas pessoas
(grid 7/5) e comportaria um terceiro bloco na p.2 sem refazer a página.

**Fotos** — retratos do Adilson e do Rafa (vertical, 2:3).
