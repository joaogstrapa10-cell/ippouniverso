# IPPO_PADRAO — banners de curso

Sistema visual para as peças de curso do **Instituto IPPO**, derivado do documento
`IPPO_Direcionamento_Identidade.pdf` (Parâmetros de Identidade · Referência: Padrão Apple,
preparado pela VLUW para validação de Giulliano).

Cinco variações de composição para a Especialização em Implantodontia, mais duas
derivações de formato. Todas vivem em `canvas/` como artboards editáveis.

---

## 1. O que o documento de marca fixa (e não se negocia entre peças)

| Parâmetro | Regra | Valor |
|---|---|---|
| Base cromática | Navy como base única | `#061824` (variação profunda `#04121B`, `#04111A`) |
| Assinatura | Cyan-teal **como assinatura mínima**, nunca preenchendo grandes áreas | `#02D3B4` |
| Neutro claro | Texto e superfícies claras | `#F7FAFB` (nunca branco puro `#FFF`) |
| Hierarquia de texto | Fios e rótulos em opacidade, não em nova cor | `rgba(247,250,251,0.14 / 0.38 / 0.56 / 0.64)` |
| Tipografia | **Um** sistema tipográfico, 2 a 3 pesos ativos por tela | ver seção 3 |
| Espaço | Margens generosas; espaço como hierarquia, não como vazio decorativo | 72px (feed) · 90–110px (peças de silêncio) |
| Destaque | **Um destaque real por peça** | a manchete, e só ela |
| Fotografia | Corpo docente / caso real como herói; fundo neutro; sem elementos concorrentes | recorte `slice`, nunca esticado |
| Tom de voz | Frases curtas, sem exclamação, benefício antes de especificação | ver seção 5 |
| Urgência | Informação, nunca gancho principal | "Vagas limitadas" é célula de spec, não badge |

### Correções em relação ao banner atual

Três coisas do banner da Turma 18 saem do padrão aprovado, e as cinco variações corrigem:

1. **O dourado (`#C9A87C`) não existe na paleta IPPO.** A base aprovada é navy + cyan-teal.
   Dourado + navy + creme é o padrão de outro cliente da pasta (`A10_PADRAO`) — não misturar.
2. **Quatro badges no topo** (`ESPECIALIZAÇÃO`, `VAGAS LIMITADAS`, `TURMA 18`, `28 MESES`)
   competem entre si e com a manchete. Viola "um destaque por peça". Agora: um eyebrow
   único, e a informação dura desce para uma faixa subordinada.
3. **"VAGAS LIMITADAS" como badge** transforma urgência em gancho. O documento pede o
   contrário: urgência como informação. Virou uma célula de spec ao lado de início e duração.

---

## 2. As 5 variações — quando usar cada uma

| # | Nome | Composição | Use quando | Fraqueza |
|---|---|---|---|---|
| **V1** | Herói Docente | Foto em sangria total, véu navy, manchete de uma palavra, faixa de spec com ícones | Peça padrão de abertura de turma. **Recomendada como base do sistema.** | Depende de foto forte; com foto fraca a peça cai |
| **V2** | Trilha de Especificação | Centralizada, faixa de numerais grandes (`28` / `18` / `Mar`) entre fios | A informação dura é o argumento: prazo, turma, data de início | Simetria é a mais fácil de imitar; diferencia menos |
| **V3** | Silêncio | Margem 110px, frase como argumento, foto contida como product shot | Campanha de posicionamento, não de matrícula | Rebaixa a foto de herói a apoio; a serifa sai do sistema único |
| **V4** | Grade Editorial | Foto deslocada sangrando à direita, trilho vertical na margem, chip atravessando a grade | Quer a peça mais autoral — reconhecível como IPPO mesmo sem logo | Assimetria é a mais frágil quando o texto muda de tamanho |
| **V5** | Assinatura Teal | Tipo no topo, foto em recorte ancorada na base, halo teal, palavra-chave em degradê | Fixar o cyan-teal na memória da marca | Gasta o maior orçamento de teal; exige PNG sem fundo |

**Regra prática:** V1 e V2 para captação (uma tem foto como argumento, a outra tem
número como argumento). V3 para institucional. V4 e V5 quando a peça precisa carregar
a marca sozinha, sem o logo fazendo o trabalho.

## 2.1 Formatos

| Formato | Medida | Arquivo |
|---|---|---|
| Feed | 1080×1350 | as cinco variações |
| Stories | 1080×1920 | `Stories.dc.html` (sistema V1) |
| Hero de site | 1920×1080 | `SiteHero.dc.html` (sistema V1) |

**Corpo de fonte não muda entre formatos.** O que muda é o espaçamento vertical — mesma
regra do `A10_PADRAO`. Stories respeita a área segura do Instagram: 148px no topo,
236px na base. O hero de site é o **único** lugar com CTA, e é um só
("Conheça o programa →") — nunca dois CTAs disputando a mesma área.

---

## 3. Tipografia — quatro sistemas em teste

O documento pede **um** sistema para todos os materiais. As cinco variações existem para
escolher qual, não para conviver. Depois de validado, um vale para tudo.

| Sistema | Pesos | Onde está | Caráter |
|---|---|---|---|
| **Manrope** ← recomendado | 400 / 500 / 800 | V1, Stories, SiteHero, rótulos da V3 | Geométrica levemente quadrada; neutra como a SF, mas com calor — serve ao "não elitizado" |
| Schibsted Grotesk | 400 / 500 / 600–700 | V2, V4 | Grotesca editorial, mais seca e institucional |
| Instrument Serif + Manrope | 400 (serifa) + 400/500 | V3 | Testa o eixo humano do `#familiaIPPO`; sai do sistema único |
| Instrument Sans | 400 / 500 / 700 | V5 | Compacta e técnica, boa para manchete longa |

Todas são Google Fonts (licença aberta, instaláveis no Figma). Fallbacks de métrica
próxima já estão declarados em cada arquivo.

### Escala tipográfica (feed 1080×1350)

| Elemento | Tamanho | Peso | Tracking |
|---|---|---|---|
| Eyebrow / kicker (caps) | 20–21px | 500 | 4.2–4.6px |
| Manchete de uma palavra | 94–112px | 700–800 | −3.2 a −3.4px |
| Manchete de duas linhas | 72–76px | 700 | −2.2px |
| Manchete serifada (V3) | 96px | 400 | −1.4px |
| Linha de apoio | 27–30px | 400 | line-height 1.42 |
| Numeral de spec (V2) | 62px | 700 | −2px |
| Valor de spec | 22–26px | 500 | — |
| Rótulo de spec (caps) | 14–15px | 500 | 2.4–3.2px |
| Linha de docentes | 18–20px | 400 | — |

---

## 4. Ícones

Traço, nunca preenchimento. Grade de 24px, `stroke-width: 1.5`, `stroke-linecap: round`,
sempre em `#02D3B4`. Desenhados inline em SVG — sem biblioteca, sem emoji, sem dingbat.

Conjunto atual: calendário (início), relógio (duração), pessoas (vagas), cadeira (vagas,
variação da V4), seta (CTA). Ícone novo entra seguindo a mesma grade e o mesmo traço.

---

## 5. Copy — o filtro

Benefício antes de especificação, uma ideia por peça, sem exclamação. As linhas em uso:

- V1 / Stories / SiteHero — "28 meses de formação clínica ao lado de quem opera todos os dias."
- V2 — "Domínio técnico, cuidado humano."
- V3 — "Técnica que se aprende operando."
- V5 — "Prática clínica supervisionada do primeiro ao último módulo."

Limites por campo, para não estourar a caixa (medidos com as fontes reais e com o
fallback, o que for mais largo):

| Campo | Limite |
|---|---|
| Manchete de uma palavra | ~15 caracteres |
| Cada linha de manchete dupla | ~20 caracteres |
| Eyebrow (caps) | ~34 caracteres |
| Linha de apoio | ~62 caracteres por linha, 2 linhas |
| Valor de spec | ~12 caracteres |
| Rótulo de spec (caps) | ~10 caracteres |

Se o texto passar, ajusto o `font-size` **daquele elemento**, nunca dos outros.

---

## 6. Fotos — o que falta para fechar

Cada peça já tem um **placeholder na proporção final**, com os cinco docentes no mesmo
arranjo da foto real (Jacira à frente à esquerda, Fabrício atrás, Julio à frente ao
centro, Filipe atrás à direita, Dalton à direita) e um rótulo tracejado
`FOTO · CORPO DOCENTE`.

Para trocar pelo arquivo real:

1. Substituir o bloco `<svg>` do placeholder por `<img src="corpo-docente.jpg">`
   (ou, no canvas, arrastar a imagem sobre o quadro).
2. Sempre `object-fit: cover` / `preserveAspectRatio="xMidYMid slice"` — **cortar para
   preencher, nunca esticar**.
3. **V5 exige PNG sem fundo** (recorte). As outras quatro aceitam a foto com fundo, porque
   o véu navy resolve o contraste.
4. O `viewBox` do placeholder sempre bate com a caixa que o contém. Se mudar a altura da
   caixa, mudar o `viewBox` junto — `slice` com proporções diferentes amplia a arte e
   empurra conteúdo fora da peça.

---

## 7. Fluxo técnico

Os artboards são arquivos `.dc.html` em `canvas/`, um por peça, montados num canvas único.

```bash
cd IPPO_PADRAO/canvas
B="<diretório da skill design>"
node "$B/seed-canvas.mjs" --template "$B/payload.template.html" \
  --out banners-curso-ippo.html --title "Banners de Curso IPPO" \
  --artboard Main.dc.html --artboard V2_TrilhaSpec.dc.html \
  --artboard V3_Silencio.dc.html --artboard V4_GradeEditorial.dc.html \
  --artboard V5_AssinaturaTeal.dc.html --artboard Stories.dc.html \
  --artboard SiteHero.dc.html --canvas canvas.json
node "$B/seed-canvas.mjs" --check banners-curso-ippo.html
```

`canvas.json` define posição, títulos, as duas páginas (Variações · Formatos) e as notas
de cada opção. `banners-curso-ippo.html` é o arquivo gerado — nunca editar à mão,
sempre regerar a partir dos `.dc.html`.

### Conferir geometria antes de entregar

Chromium headless renderiza cada peça no tamanho exato e denuncia vazamento:

```bash
chrome --headless --no-sandbox --hide-scrollbars --virtual-time-budget=6000 \
  --window-size=1080,1350 --screenshot=out.png file:///caminho/peca.html
```

Atenção: as pré-visualizações exibidas em chat cortam os últimos ~60px de imagens altas.
Para saber se algo realmente vazou, medir `getBoundingClientRect()` contra a altura do
artboard — não confiar no olho sobre a imagem reduzida.

### Templates SVG para Figma

Ainda não existem. O padrão do repo (`A10_PADRAO/templates/`) é um SVG-molde por layout
com `{{TOKEN}}`. Faz sentido gerar depois da validação de **uma** variação — cinco jogos
de molde antes da escolha criam cinco fontes de verdade para manter.
