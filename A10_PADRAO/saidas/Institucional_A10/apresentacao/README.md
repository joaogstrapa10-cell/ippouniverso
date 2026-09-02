# Apresentação institucional A10 — slides 16:9

Mesma peça do one-pager, quebrada em 6 slides de 1920×1080, no padrão da casa
(navy #0B1624 + dourado #C9A86A, Cormorant Garamond + Poppins, moldura inset).

| # | Slide | Conteúdo |
|---|-------|----------|
| 01 | Capa | Logo A10 + "Uma incorporadora de alto padrão em Balneário Camboriú" |
| 02 | Quem somos | Texto institucional (A10 × R21, do terreno à entrega das chaves) |
| 03 | Nosso portfólio 1/2 | Cape Town, Holmes Residence, Solenne, Pátio Estaleiro |
| 04 | Nosso portfólio 2/2 | Aurora, Diamond Hill, Florence Garden + faixa de investimento |
| 05 | Primeiro contato | Como conduzimos o primeiro contato |
| 06 | Fechamento | "Vamos conversar?" + campos de telefone, Instagram e site |

## Arquivos

- `*.svg` — **a fonte editável** (Figma, Illustrator, Inkscape). É aqui que se mexe.
- `*_preview.png` — render de cada slide com as fontes reais, 1920×1080.
- `A10_Apresentacao_Institucional.pdf` — 6 páginas 16:9, para apresentar ou enviar.
- `A10_Apresentacao_Institucional.pptx` — os 6 slides como imagem de fundo, para
  abrir no PowerPoint/Keynote/Google Slides. O texto **não** é editável aqui;
  para mudar texto, edite o SVG e gere de novo.

## Editável no Figma

Os SVG são feitos para abrir editáveis no Figma (`File > Import` ou arrastar):

- **fonte como atributo em cada texto**, sem `<style>` e sem classes CSS — o Figma
  ignora CSS na importação e trocaria tudo por Inter. Cormorant Garamond e Poppins
  são fontes do Google, já disponíveis no Figma;
- **nenhuma máscara ou `clipPath`** — cada moldura de foto é um retângulo simples,
  selecionável com um clique;
- **camadas nomeadas**: `Fundo`, `Moldura da peca`, `Logo A10`, `Titulo`,
  `Portfolio` e, dentro dele, um grupo por empreendimento (`Foto 1 - Cape Town`)
  com `Moldura Cape Town`, `Marca Cape Town` e `Nome Cape Town`.

### Colocar as fotos (slides 03 e 04)

1. selecione o retângulo `Moldura <empreendimento>`;
2. em **Fill**, troque a cor por **Image** e escolha a foto;
3. deixe o modo em **Fill** — recorta para preencher, sem esticar (é o mesmo que
   `preserveAspectRatio="slice"` do padrão A10);
4. apague o grupo `Marca <empreendimento>` (o ícone e o "FOTO 390×260px").

As molduras são deitadas, 390×260px (3:2). Fora do Figma, dá para editar o SVG
direto: troque o `fill` do retângulo por um `<image>` de mesmo x/y/width/height
com `preserveAspectRatio="xMidYMid slice"`.

## Regerar

Os arquivos são gerados por script, em `../_build/`:

```bash
python3 ../_build/gera_slides.py     # escreve os 6 SVG
node ../_build/render.cjs            # previews PNG + PDF do deck
```

`render.cjs` embute as fontes de `Apresentacao_Portfolio_3D/_build/fonts_embedded.css`,
então o preview sai com a tipografia certa sem depender de rede. O PPTX é montado
a partir dos previews (python-pptx).
