# fotos/ — uma foto por empreendimento

A grade de `index.html` tem 7 molduras deitadas, na proporção **3:2 (1080 × 720)**.
Cada moldura nasce vazia (fio dourado tracejado + etiqueta com o nome do arquivo esperado) e
se preenche sozinha assim que o arquivo abaixo existir nesta pasta — sem editar o HTML.

| Empreendimento    | Arquivo esperado          |
|-------------------|---------------------------|
| Cape Town         | `cape-town.jpg`           |
| Holmes Residence  | `holmes-residence.jpg`    |
| Solenne           | `solenne.jpg`             |
| Pátio Estaleiro   | `patio-estaleiro.jpg`     |
| Aurora            | `aurora.jpg`              |
| Diamond Hill      | `diamond-hill.jpg`        |
| Florence Garden   | `florence-garden.jpg`     |

A foto entra recortada (`object-fit: cover`) — nunca esticada, conforme o padrão A10. Não é
preciso recortar antes: manda a foto no tamanho original que o recorte é centralizado.
Ideal ≥ 1080 px no lado menor.

## Fotos equivalentes que já existem no repositório

Se a foto oficial ainda não chegou, estas do acervo mostram o mesmo empreendimento:

- Pátio Estaleiro — `EMPREENDIMENTOS A10/PatioEstaleiro_CasaBrisa_foto.jpg` (e `_real.jpg`, `_pordosol.jpg`)
- Aurora — `EMPREENDIMENTOS A10/aurora.jpg`, `aurora2.jpg`, `aurora_piscina.jpg`
- Solenne — `capetown/ref_solene_1.jpg`, `ref_solene_2.jpg`
- Diamond Hill — `EMPREENDIMENTOS A10/diamondhill.jpg`
- Florence Garden — `EMPREENDIMENTOS A10/florencegarden.jpg`
- Holmes Residence — render embutido em `EMPREENDIMENTOS A10/Holmes_Luxe_Feed_1080x1350.svg`

## Ou envie pela própria página

A versão publicada tem um campo de envio em cada moldura (visível para quem pode
editar): arraste a foto na moldura e ela é recortada em 1080 × 720 e salva como
nova versão da página. Depois é só me pedir para trazer essas fotos para cá.

## Versão SVG (editável no Figma)

`Institucional_A10_OnePager_1080x2360.svg` traz a mesma peça no padrão da casa:
7 molduras de 221×276px (a mesma proporção 4:5 do Feed 1080×1350), uma por
empreendimento, com o nome embaixo em Cormorant itálico.

Para colocar a foto, dentro de `<g clip-path="url(#fotoN)">` troque o `<rect>`
por um `<image>` com o mesmo x/y/width/height:

```xml
<image x="64" y="1064" width="221" height="276"
       preserveAspectRatio="xMidYMid slice"
       xlink:href="data:image/jpeg;base64,..."/>
```

O `slice` recorta para preencher — nunca esticar. A ordem dos clipPaths é
foto1 Cape Town, foto2 Holmes Residence, foto3 Solenne, foto4 Pátio Estaleiro,
foto5 Aurora, foto6 Diamond Hill, foto7 Florence Garden (cada um comentado no
próprio arquivo). `_preview.png` é o render do arquivo como está.
