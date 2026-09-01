# fotos/ — uma foto por empreendimento

A grade de `index.html` tem 7 molduras na proporção **4:5 (1080 × 1350 — Feed do padrão A10)**.
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
