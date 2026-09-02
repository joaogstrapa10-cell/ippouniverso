# Institucional A10 — Balneário Camboriú

A mesma apresentação institucional em vários formatos, todos no padrão da marca
(navy #0B1624 + dourado #C9A86A, Cormorant Garamond + Poppins) e todos com as
6 molduras de foto verticais (4:5) nomeadas por empreendimento: Cape Town,
Holmes Residence, Solenne, Pátio Estaleiro, Aurora e Florence Garden.

| Peça | Arquivo | Quando usar |
|---|---|---|
| **Uma página, formato grande** | `Institucional_A10_UmaPagina_A3_2480x1754.svg` (+ `_A3.pdf`, `_preview.png`) | Tudo numa folha só, deitada, com as molduras grandes (498×622px) em 3 + 3. Proporção A-series: imprime exato em A3, A2 ou A1. É a peça principal. |
| Apresentação em 6 slides | `apresentacao/` | Quando dá para passar slide a slide (reunião, projeção) — 3 molduras de 420×525px por slide. |
| One-pager vertical | `Institucional_A10_OnePager_1080x2360.svg` | Página comprida, para rolar na tela ou imprimir em retrato. |
| Página web | `index.html` | Versão navegável, com envio de foto direto na moldura. |

## Editável no Figma

Todos os SVG são feitos para o Figma abrir editável: fonte como atributo em cada
texto (sem `<style>`, sem classes, sem `@import`), nenhuma máscara ou `clipPath`
e camadas nomeadas. Para colocar a foto: selecione o retângulo
`Moldura <empreendimento>`, em **Fill** troque a cor por **Image**, deixe o modo
em **Fill** (recorta sem esticar) e apague o grupo `Marca <empreendimento>`.

## Regerar

```bash
python3 _build/gera_umapagina.py     # a peça de uma página, formato grande
python3 _build/gera_slides.py        # os 6 slides
python3 _build/gera_onepager.py      # o one-pager vertical
node _build/render.cjs               # previews PNG + PDF do deck
```

`_build/padrao_a10.py` guarda o padrão da marca (cores, fontes, moldura de foto,
campo a preencher) usado pelos três geradores.
