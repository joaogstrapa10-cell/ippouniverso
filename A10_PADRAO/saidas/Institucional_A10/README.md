# Institucional A10 — Balneário Camboriú

A mesma apresentação institucional em três formatos, todos no padrão da marca
(navy #0B1624 + dourado #C9A86A, Cormorant Garamond + Poppins) e todos com as
7 molduras de foto nomeadas por empreendimento: Cape Town, Holmes Residence,
Solenne, Pátio Estaleiro, Aurora, Diamond Hill e Florence Garden.

| Peça | Arquivo | Quando usar |
|---|---|---|
| **Uma página, deitada** | `Institucional_A10_UmaPagina_1920x1080.svg` (+ `.pdf`, `_preview.png`) | Tudo numa tela só: marca, quem somos, os 7 empreendimentos, faixa de investimento, primeiro contato e contato. É a peça principal. |
| Apresentação em 6 slides | `apresentacao/` | Quando dá para passar slide a slide (reunião, projeção). |
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
python3 _build/gera_umapagina.py     # a peça de uma página
python3 _build/gera_slides.py        # os 6 slides
python3 _build/gera_onepager.py      # o one-pager vertical
node _build/render.cjs               # previews PNG + PDF do deck
```

`_build/padrao_a10.py` guarda o padrão da marca (cores, fontes, moldura de foto,
campo a preencher) usado pelos três geradores.
