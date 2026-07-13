# A10_PADRAO — biblioteca-mestre de criativos

Este projeto guarda o **padrão visual validado da A10** (azul-marinho + dourado + creme, Cormorant Garamond + Poppins) em 9 arquivos-molde SVG, prontos para receber conteúdo de qualquer empreendimento novo. O objetivo: você manda o conteúdo no chat, eu preencho um molde já aprovado e devolvo a peça em SVG editável no Figma — sem redesenhar identidade a cada pedido.

```
A10_PADRAO/
├── templates/        ← os 9 moldes-mestre (NUNCA editar/sobrescrever estes arquivos)
├── assets/           ← logos em base64 (A10 dourado/escuro/creme, R21 dourado)
├── exemplos/         ← preview PNG de cada molde "vazio", para consulta visual
├── saidas/           ← peças finais reais, uma subpasta por empreendimento
├── render_preview.ps1
└── preview_templates.ps1
```

---

## 1. Como pedir uma peça (o que mandar no chat)

Mande, em qualquer ordem, os itens abaixo. Quanto mais completo, mais rápido eu gero certo de primeira:

1. **Nome do empreendimento** + localização (cidade/bairro).
2. **Objetivo da peça**: apresentação institucional? condição de pagamento? portfólio/galeria? (isso define qual dos 5 layouts uso — ver seção 2).
3. **Formato**: Feed (1080×1350), Stories (1080×1920), ou os dois.
4. **Textos**: headline, texto de apoio, stats/números que quer destacar, texto do botão. Se não mandar copy pronta, eu escrevo no tom já validado (ver seção 4) e te mostro antes.
5. **Fotos**: você me diz *quantas* fotos entram e *o que* cada uma mostra (ex.: "foto 1 = fachada ao entardecer, foto 2 = piscina") — **eu não preciso do arquivo de imagem ainda**. Eu gero a peça com placeholders nomeados e dimensionados exatamente onde cada foto deve entrar; você (ou eu, se enviar os arquivos depois) substitui no Figma sem esticar nada, porque o placeholder já tem a proporção certa.
6. **Parceria** (se houver): incorporadora parceira co-branded (como A10 × R21 no Pátio Estaleiro) ou só A10.

Eu então: copio o molde certo de `templates/` para `saidas/<Empreendimento>/`, substituo os textos e ajusto os blocos de foto (quantidade/proporção se for diferente do padrão), renderizo um preview PNG e te mostro antes de finalizar.

---

## 2. Os 5 layouts — quando usar cada um

| # | Nome | Uso | Fotos | Arquivos |
|---|------|-----|-------|----------|
| **L1** | Hero Cream | Anúncio/institucional de **um único empreendimento**, tom de abertura de campanha | 1 foto grande | `L1_Hero_Cream_Feed_1080x1350.svg`, `L1_Hero_Cream_Stories_1080x1920.svg` |
| **L2** | Portfólio Navy | Mostrar **portfólio da incorporadora** (vários empreendimentos lado a lado) | 3 fotos (ou 2, ver seção 3) | `L2_Portfolio_Navy_Feed_1080x1350.svg` |
| **L3** | Hero Full-Bleed | Peça de impacto, foto ocupando 100% do fundo, texto sobreposto — ótima para Stories de abertura | 1 foto de fundo | `L3_Hero_FullBleed_Feed_1080x1350.svg`, `L3_Hero_FullBleed_Stories_1080x1920.svg` |
| **L4** | Condições de Pagamento | Peça focada em **condição comercial** (entrada, saldo, prazo) de 1–2 imóveis específicos | 2 fotos em cards | `L4_PaymentConditions_Feed_1080x1350.svg`, `L4_PaymentConditions_Stories_1080x1920.svg` |
| **L5** | Galeria + Número Grande | Como o L4, mas com fotos em tela cheia e um número gigante em destaque (ex.: "180 meses") | 2 fotos cheias | `L5_PaymentCombo_Feed_1080x1350.svg`, `L5_PaymentCombo_Stories_1080x1920.svg` |

Regra prática: **L1/L3** = "conheça o empreendimento" (1 imóvel, foto única). **L2** = "conheça o portfólio" (vários empreendimentos). **L4/L5** = "condições de pagamento" de um empreendimento específico (1–2 unidades à venda).

---

## 3. Fotos: quantidade flexível

Cada molde já vem com um número padrão de placeholders (1, 2 ou 3, conforme a tabela acima). Se o seu caso tiver uma quantidade diferente:

- **Menos fotos que o padrão** (ex.: L2 com 2 em vez de 3): eu removo um placeholder e redistribuo a largura dos outros dois proporcionalmente (mantendo a mesma altura e o mesmo espaçamento entre eles).
- **Mais fotos** (ex.: 3 imóveis num L4): eu adapto a grade (3 colunas mais estreitas em vez de 2), sempre preservando as proporções de card/moldura/legenda do padrão — nunca esticando foto.
- **Um empreendimento só, sem comparação**: use L1 ou L3 (1 foto), não L4/L5.

Todo placeholder de foto já nasce com a proporção final exata (ex.: "464×272px", "1080×560px") — é só a foto real entrar recortada (`slice`) nessa proporção, nunca distorcida.

---

## 4. Identidade — o que NUNCA muda entre peças

| Elemento | Valor |
|---|---|
| Fundo claro | `#F0EBDD` (bege claro/creme — **nunca branco puro**) |
| Fundo escuro | `#0B1624` (navy) · cards internos `#101B2C` |
| Dourado (accent/stroke/CTA) | `#C9A86A` · variação clara `#D9BC7C` · texto sobre creme `#AC8A38` / `#B3913F` |
| Headline sobre creme | navy `#1D2C4B` |
| Headline sobre navy | creme `#F5F0E6` |
| CTA em fundo creme | botão navy sólido `#0B1624`, texto dourado |
| CTA em fundo navy/foto | botão dourado sólido `#C9A86A` (ou degradê `#EDD597→#AE883D`), texto navy `#0B1624` |
| Fonte de título/valores | **Cormorant Garamond**, peso 600 (itálico 500 para nomes de imóvel) |
| Fonte de kicker/corpo/labels/CTA | **Poppins**, pesos 400/500/600 |
| Moldura da peça | retângulo inset 28px, stroke dourado 1.2, opacidade 0.45 |

**Tamanhos de fonte são fixos entre Feed e Stories** — nunca reduzo por ser um formato menor. O que muda é o espaçamento vertical, nunca o corpo da fonte. Tabela de referência (todos os layouts usam os mesmos números):

| Elemento | Tamanho |
|---|---|
| Headline (2 linhas) | 92px |
| Kicker | 21px (L1/L2/L3) · 19px (L4/L5) |
| Corpo/body | 25px |
| Nome do imóvel (itálico) | 44px (L4) · 52px (L5) |
| Specs do imóvel (caps) | 12–13px |
| Valor de stat pequeno | 42px |
| Label de stat pequeno (caps) | 12.5–13px |
| Número grande de destaque (L5) | 160px |
| Texto do CTA (caps) | 18–20px |
| Título do painel (caps) | 22px |

## 4.1 Logos — qual variante usar

- **Fundo creme (`#F0EBDD`)** → `a10_dark.b64` (logo A10 em carvão/escuro)
- **Fundo navy sólido ou sobre foto** → `a10.b64` (logo A10 dourado)
- **Parceiro co-branded** (ex.: R21) → sempre a versão dourada, ao lado do A10, mesma altura de base (ver `L4`/`L5` para o espaçamento exato: A10 em `x=368/584`, parceiro em `x=584` com `width=128`)
- Existe também `a10_cream.b64` (quase-branco) — reserva para casos em que o dourado colidir com uma foto muito dourada/amarela de fundo.
- **L1/L2/L3 são peças de marca única A10** (sem parceiro) — só use logo duplo se o empreendimento for parceria, replicando o padrão de L4/L5.

---

## 5. Limites de texto (para não estourar a caixa)

Como o SVG não quebra linha sozinho, sigo estes limites ao preencher (headline especialmente — Cormorant 92px é uma fonte larga):

| Campo | Limite aproximado |
|---|---|
| Cada linha de headline | ~22–24 caracteres |
| Kicker (caps) | ~46 caracteres |
| Cada linha de corpo/body | ~60 caracteres |
| Nome do imóvel (ex. "Casa Mar") | ~14 caracteres |
| Specs do imóvel (caps) | ~34 caracteres |
| Label de stat pequeno (caps) | ~22 caracteres |
| Valor de stat pequeno | ~10 caracteres (mais que isso, eu reduzo o font-size proporcionalmente) |
| Texto do CTA (caps) | ~26 caracteres |
| Título do painel (caps) | ~40 caracteres |

Se o texto que você mandar passar do limite, eu ajusto o `font-size` daquele elemento especificamente (nunca dos outros) ou sugiro uma versão mais curta antes de finalizar.

---

## 6. Fluxo técnico (como eu executo, passo a passo)

1. Copio o(s) template(s) certo(s) de `templates/` para `saidas/<Empreendimento>/`, renomeando (ex.: `NomeDoEmpreendimento_L1_Feed_1080x1350.svg`).
2. Uso a ferramenta de edição para substituir cada `{{TOKEN}}` pelo texto real, e cada bloco de placeholder de foto por `<image>` com o base64 da foto (se você já tiver enviado os arquivos) — ou deixo o placeholder rotulado, se as fotos ainda não existirem.
3. Substituo `@@A10_GOLD@@` / `@@A10_DARK@@` / `@@PARCEIRO_GOLD@@` / `@@LOGO_EMPREENDIMENTO@@` pelos base64 de `assets/` (ou pela marca própria do empreendimento, se houver).
4. Rodo `render_preview.ps1 "caminho\da\peca.svg" 1080 1350` (ou 1080 1920 para stories) e te mostro o PNG antes de considerar pronto.
5. Arquivo final fica em `saidas/<Empreendimento>/`, pronto para você abrir/arrastar no Figma.

---

## 7. Regras que NÃO mudam nunca (mesmo entre incorporadoras diferentes)

- Sempre azul-marinho + dourado + creme — nunca as outras paletas usadas em criativos de outros construtores/projetos que estão soltos na pasta `EMPREENDIMENTOS A10` (ex.: variantes "Luxe" roxa/rosa de outros clientes). Essas paletas **não** fazem parte do padrão A10.
- Fundo claro é sempre bege/creme, nunca branco puro.
- Fotos sempre com `preserveAspectRatio="xMidYMid slice"` — cortar para preencher, nunca esticar (`stretch`).
- Fontes sempre Cormorant Garamond (serifada) + Poppins (sem serifa) — nunca outra combinação.
- Tamanho de fonte de um elemento não muda entre Feed e Stories.
