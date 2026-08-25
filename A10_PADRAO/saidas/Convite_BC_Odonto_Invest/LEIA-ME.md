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
| `adilson.jpg` · `rafa.jpg` | retratos tratados, já usados nas p.1 e p.2 |
| `preview/` | páginas rasterizadas (150 dpi) + comparativos A × B |
| `_fotos/` | fotos originais, recortes com fundo transparente e retratos gerados |
| `_build/retratos.py` | pipeline dos retratos (recorte, enquadramento, tratamento, fundo) |
| `_build/render.py` | script de render (Playwright + Chromium) |
| `_build/fonts/` | cache local das fontes do Google Fonts, para render offline |

## Trocar a variação de paleta

No `<body>` do HTML, troque a classe: `pal-a` (escuras alternadas) ou `pal-b`
(creme dominante). Só isso — todas as cores derivam de tokens por superfície.
Depois rode o render de novo.

## Retratos

`adilson.jpg` e `rafa.jpg` já estão nos quatro blocos de retrato (p.1 e p.2). Saem
de `_build/retratos.py`, que faz tudo a partir das fotos originais em `_fotos/`:

1. **Recorte** — remove o fundo com `rembg` (modelo `isnet-general-use`), encolhe a
   máscara 1px e suaviza, para não sobrar franja da cor do fundo original.
2. **Enquadramento 2:3** — normaliza pela **largura da cabeça**, não pela altura do
   corpo: as duas fotos vieram com recortes diferentes (uma até a cintura, outra até
   o peito), e sem isso os rostos saíam em escalas visivelmente distintas.
3. **Tratamento** — monocromático quente (duotone de sombra neutra para creme), em
   vez de cinza puro, para casar com a paleta.
4. **Fundo** — navy `#0B1624` com halo de luz atrás da cabeça, **igual nos dois**, e
   queda de luz no pé do quadro. O sujeito dissolve nessa queda: os dois originais
   terminam num corte reto na altura do peito, e a dissolução esconde isso.

Os recortes com fundo transparente ficam em `_fotos/recorte_*.png`, reaproveitáveis
em outras peças.

Para trocar por outras fotos: substitua os arquivos em `_fotos/` (mantendo os nomes
`origem_1` = Adilson e `origem_2` = Rafael) e rode:

```bash
cd _build && python3 retratos.py
```

O halo é navy levantado com só um sopro de champagne dentro. Misturar champagne
direto no navy dá cast oliva — azul mais amarelo —, então o dourado fica na
tipografia, não na foto.

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

**Conferir** — o jaleco da foto do Rafael traz "Prof. Raphael Alto"; o material usa
"Rafael Monte Alto". Confirmar qual grafia vai no convite.
