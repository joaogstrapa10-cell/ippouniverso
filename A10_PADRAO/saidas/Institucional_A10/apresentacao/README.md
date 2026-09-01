# Apresentação institucional A10 — slides 16:9

Mesma peça do one-pager, quebrada em 4 slides de 1920×1080, no padrão da casa
(navy #0B1624 + dourado #C9A86A, Cormorant Garamond + Poppins, moldura inset).

| # | Slide | Conteúdo |
|---|-------|----------|
| 01 | Capa | Logo A10 + "Uma incorporadora de alto padrão em Balneário Camboriú" |
| 02 | Quem somos | Texto institucional (A10 × R21, do terreno à entrega das chaves) |
| 03 | Nosso portfólio | As 7 molduras nomeadas em fila + faixa de investimento |
| 04 | Primeiro contato | Como conduzimos o primeiro contato |

## Arquivos

- `*.svg` — **a fonte editável** (Figma, Illustrator, Inkscape). É aqui que se mexe.
- `*_preview.png` — render de cada slide com as fontes reais, 1920×1080.
- `A10_Apresentacao_Institucional.pdf` — 4 páginas 16:9, para apresentar ou enviar.
- `A10_Apresentacao_Institucional.pptx` — os 4 slides como imagem de fundo, para
  abrir no PowerPoint/Keynote/Google Slides. O texto **não** é editável aqui;
  para mudar texto, edite o SVG e gere de novo.

## Colocar as fotos (slide 03)

As 7 molduras são de 229×286px — a mesma proporção 4:5 do Feed 1080×1350. Dentro
de `<g clip-path="url(#fotoN)">`, troque o `<rect>` por um `<image>` com o mesmo
x/y/width/height:

```xml
<image x="98" y="320" width="229" height="286"
       preserveAspectRatio="xMidYMid slice"
       xlink:href="data:image/jpeg;base64,..."/>
```

Ordem: foto1 Cape Town, foto2 Holmes Residence, foto3 Solenne, foto4 Pátio
Estaleiro, foto5 Aurora, foto6 Diamond Hill, foto7 Florence Garden — cada um
comentado no próprio arquivo. `slice` recorta para preencher, nunca estica.
