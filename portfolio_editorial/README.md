# Portfólio Editorial · SVGs editáveis no Figma

Recriação vetorial dos três layouts de apresentação do portfólio
**Solenne** + **Pátio Estaleiro** (Balneário Camboriú / SC). Cada PNG foi
reconstruído como SVG 100% vetorial — nada rasterizado, nada convertido em
contorno (`<path>`) — para que **todo elemento seja editável no Figma**.

## Arquivos

| Variante | Arquivo | Descrição |
|----------|---------|-----------|
| **1a** | `1a_Editorial_MeioAMeio_1080x2400.svg` | Editorial · Meio a Meio — dois panos divididos por filete dourado com losango |
| **1b** | `1b_GradeClassica_DuasColunas_1080x2400.svg` | Grade Clássica · Duas Colunas — colunas espelhadas com ficha técnica listada |
| **1c** | `1c_TorreEditorial_Assimetrico_1080x2400.svg` | Torre Editorial · Assimétrico — Solenne como lançamento-âncora no topo; Pátio Estaleiro em faixa abaixo |

Prévias em PNG na pasta `preview/`. O gerador (`build_svgs.py`) reproduz os
três arquivos e documenta os tokens de design.

## Como importar no Figma

1. **Arraste o `.svg`** para dentro de um frame no Figma (ou
   *File → Place image / Import*).
2. O Figma converte cada `<text>` em **camada de texto editável** e cada
   forma em **vetor editável**.
3. **Fontes** (baixe/ative antes de abrir, o Figma puxa direto do Google Fonts):
   - **Bodoni Moda** — títulos serifados (Solenne, Pátio Estaleiro) e frases em itálico
   - **Poppins** — rótulos, ficha técnica e textos de apoio
   Se não estiverem instaladas, o Figma pede para substituir — basta escolher
   Bodoni Moda / Poppins na lista.

> Dica: a textura de listras diagonais é um grupo de linhas (`<line>`)
> recortado por uma máscara. No Figma ela vem como um grupo — selecione e
> oculte/exclua se quiser um fundo liso, ou troque os placeholders
> `FOTO · …` e `QR CODE` pelas imagens reais.

## Tokens de design

| Token | Valor |
|-------|-------|
| Navy base | `#0B1A2D` (gradiente `#0C1C31` → `#081320`) |
| Navy painel | `#08131F` |
| Dourado | `#C9A86A` (claro `#E3C77E`) |
| Creme (títulos) | `#F3ECDB` |
| Cinza (apoio) | `#AEB8C2` |
| Listras | `#2C4763` |
| Canvas | 1080 × 2400 px (proporção vertical do mockup) |

Placeholders a substituir: `LOGO · IMOBILIÁRIA`, os blocos `FOTO · …`
(imagens dos empreendimentos) e `QR CODE`.
