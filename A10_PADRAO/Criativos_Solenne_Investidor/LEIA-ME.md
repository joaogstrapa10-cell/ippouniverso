# SOLENNE × A10 — 12 criativos · ângulo investidor

Pegada de investimento: a A10 como **incorporadora com esteira contínua de oportunidades**.
Fala com investidor, não com comprador de imóvel.

6 copies aprovadas × 2 formatos = **12 arquivos SVG editáveis no Figma**.

| Arquivo | Bloco | Headline (resumo) | CTA |
|---|---|---|---|
| `Solenne_E1_Feed_1080x1350.svg` / `_Stories_1080x1920.svg` | 1 — A esteira | A A10 não tem um empreendimento. Tem uma esteira… | QUERO ACOMPANHAR AS OPORTUNIDADES |
| `Solenne_E2_…` | 1 — A esteira | Oportunidade boa não é anunciada. É indicada. | QUERO FAZER PARTE |
| `Solenne_E3_…` | 1 — A esteira | Enquanto o mercado espera o próximo lançamento… | QUERO ESTAR POSICIONADO |
| `Solenne_I1_…` | 2 — Olhar de incorporador | Existe o lado de quem compra o imóvel… | QUERO SABER MAIS |
| `Solenne_I3_…` | 2 — Olhar de incorporador | Investir em imóvel é uma coisa… | QUERO ENTENDER |
| `Solenne_I4_…` | 2 — Olhar de incorporador | Olhe Balneário Camboriú como incorporador… | QUERO SABER MAIS |

As copies foram aplicadas **exatamente** como aprovadas — nenhuma palavra alterada.
Elementos opcionais entram só onde o script pedia: **badge** só em E1 (com a bolinha
vermelha desenhada em vetor, não emoji — emoji não renderiza em SVG/Figma); **dados**
em E1, E2, I1 e I3; E3 e I4 sem dados, como no roteiro.

---

## Template

Mesma arquitetura do modelo já validado no AURORA, com a marca SOLENNE:

- **Feed 1080×1350** — foto full-bleed à esquerda, painel creme à direita (cantos
  esquerdos arredondados, r=44), conteúdo centralizado na coluna.
- **Stories 1080×1920** — foto no topo, painel creme na base (cantos superiores
  arredondados, r=52). O CTA fecha em y≈1710 para não brigar com a UI do Instagram.
- Ordem vertical em ambos: **logo → badge → headline → filete dourado → sub → dados → CTA**.

### Identidade

| Elemento | Valor |
|---|---|
| Painel creme | `#EDEAD9` |
| Navy (texto, pílulas, CTA) | `#1F2C50` |
| Texto de apoio (sub) | `#4A5878` |
| Dourado (labels + filete) | `#B08D4F` |
| Texto sobre navy | `#F4F1E5` |
| Bolinha do badge | `#D6453C` |
| Fonte | **Helvetica Neue** (Medium 500 headline · Regular 400 sub · Bold 700 badge/CTA) |
| Logo | curvas do vetor oficial (não depende de fonte) |

Corpo de texto é **ajustado por peça**: a régua escolhe o maior corpo que mantenha o
menor número de linhas possível (feed 34–50px, stories 41–62px na headline). Copies
mais longas entram um pouco menores — é o que mantém as 6 peças com o mesmo peso visual.

---

## Editar no Figma

Arraste o `.svg` para o Figma. Todo texto entra **vivo** (não é imagem), com as camadas nomeadas:

```
FOTO                     → imagem de fundo (troque o fill para mudar a foto)
PAINEL_CREME             → painel de fundo do conteúdo
LOGO_SOLENNE
  ├ LOGO_SOLENNE_MONOGRAMA
  └ LOGO_SOLENNE_WORDMARK
BADGE / BADGE_TEXTO
HEADLINE  → HEADLINE_L1, L2, L3…   (uma camada por linha)
FILETE
SUB       → SUB_L1, L2…
DADOS     → DADO1_LABEL, DADO1_VALOR, DADO2_…
CTA / CTA_TEXTO (ou CTA_TEXTO_L1, _L2 quando o CTA usa duas linhas)
```

Se o Figma não achar **Helvetica Neue** na máquina, ele pede uma substituta — escolha
Helvetica Neue Medium/Regular/Bold para manter a quebra de linha como está.

---

## Fontes dos assets

- **Logo**: vetor oficial da A10 no Drive — `Solenne - Logo__09.svg` (monograma) e
  `Solenne - Logo__13.svg` (wordmark), recolorados no dourado da peça. São as curvas
  originais, não uma recriação.
- **Foto**: render oficial da torre ao entardecer (`capetown/solenne_build/solenne.jpg`),
  pré-composta no tamanho exato de cada formato em `_build/foto_*.jpg`. As 12 peças usam
  a mesma render em dois enquadramentos; para variar por criativo, troque o fill da
  camada `FOTO`.

## Regerar

```bash
cd _build
python3 gen_solenne_investidor.py     # escreve os 12 SVG na pasta acima
python3 render.py                     # PNG de conferência em _build/preview/
```

Para trocar copy, editar a lista `CREATIVES` no gerador — o layout se recompõe sozinho
(quebra de linha, corpo de texto, altura das pílulas e espaçamento).
