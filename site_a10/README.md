# Site A10 Empreendimentos

Portfólio da **A10 Empreendimentos**, construído no **Lovable**
(React + TanStack Start + Tailwind + shadcn/ui) seguindo o padrão visual validado da
A10 (creme + navy + dourado · Cormorant Garamond + Poppins).

> **Formato atual: deck cinematográfico (single-page vertical).** O site é uma única
> página em slideshow com scroll-snap (14 cenas, cada uma 100vh): capa creme → 8
> empreendimentos em foto full-bleed com moldura dourada, número fantasma e specs →
> slides de encerramento ("Um portfólio · uma direção", manifesto "Vamos construir
> juntos" com link WhatsApp, assinatura A10 × R21, notas, "Fim"). Tem barra de
> progresso, dots de navegação laterais, navegação por teclado (↑/↓, PgUp/PgDn,
> Home/End), parallax suave e reveal-on-scroll. Réplica refinada do deck de referência
> (netlify) aprovado pelo cliente.
>
> *(Histórico: uma primeira versão era institucional multi-página — home, portfólio,
> sobre, contato e páginas de detalhe. Foi substituída pelo deck a pedido.)*

## Links do projeto (Lovable)

- **Projeto:** Ippouniverse Explorer — `8239c145-1e56-4f56-8db3-e2fcc3da863f`
- **Workspace:** Giulliano's Lovable
- **Editor:** https://lovable.dev/projects/8239c145-1e56-4f56-8db3-e2fcc3da863f
- **Preview:** https://id-preview--8239c145-1e56-4f56-8db3-e2fcc3da863f.lovable.app

> O código-fonte do site vive no repositório interno do Lovable. Esta pasta guarda a
> **documentação** e as **fotos web** que alimentam o site.

## Estrutura do site (deck — rota única `/`)

| # | Cena | Descrição |
|---|------|-----------|
| 1 | Capa | Creme, logo A10, "Nossos *empreendimentos.*", stats 08 · Torres · Casas, "role para caminhar" |
| 2–9 | Empreendimentos | 1 por tela: foto full-bleed + moldura dourada, número fantasma, título serif/dourado, tag, specs (Tipologia, Destaque/Parceria, Localização, Status), inset da foto secundária (Pátio Estaleiro e Aurora) |
| 10 | Direção | Navy, "10" gigante, "Um portfólio · uma direção" |
| 11 | Manifesto | "Vamos construir *juntos.*" + link discreto WhatsApp "Falar com a A10" |
| 12 | Assinatura | A10 × R21 |
| 13 | Notas | Aviso sobre dados "a confirmar" |
| 14 | Fim | "A10 · Portfólio 2026" / "Fim" |

## Os 8 empreendimentos e o mapeamento de fotos

As fotos web otimizadas estão em [`fotos_web/`](./fotos_web/). Cada arquivo é nomeado
pelo `slug` usado no site.

| # | Slug | Nome | Tipologia | Foto principal | Foto secundária |
|---|------|------|-----------|----------------|-----------------|
| 1 | `patio-estaleiro` | Pátio Estaleiro (A10 × R21) | Casas de alto padrão | `patio-estaleiro.jpg` (Casa Mar) | `patio-estaleiro-2.jpg` (Casa Brisa) |
| 2 | `aurora` | Residencial Aurora | Torre residencial | `aurora.jpg` (torre) | `aurora-2.jpg` (piscina/lazer) |
| 3 | `hub-240` | Hub 240 | Torre multiuso | `hub-240.jpg` | — |
| 4 | `sunstar-tower` | Sunstar Tower | Torre residencial | `sunstar-tower.jpg` (rooftop vista mar) | — |
| 5 | `san-andreas` | Residencial San Andreas | Torre residencial | `san-andreas.jpg` | — |
| 6 | `san-valentin` | Residencial San Valentin | Torre residencial | `san-valentin.jpg` (fachada assinatura) | — |
| 7 | `villa-do-mar` | Villa do Mar | Torre residencial | `villa-do-mar.jpg` | — |
| 8 | `casa-colombo` | Casa Colombo | Residência exclusiva | `casa-colombo.jpg` | — |

- **Hero da home:** `home-hero.jpg` (torre Aurora com piscina refletindo — foto-assinatura do portfólio).

As fotos originais em alta ficam na pasta `../EMPREENDIMENTOS A10/`. As versões em
`fotos_web/` foram redimensionadas/otimizadas (JPEG progressivo, qualidade ~84) para uso web.

## Identidade visual (tokens A10)

| Token | Valor |
|-------|-------|
| Creme (fundo claro) | `#F0EBDD` (nunca branco puro) |
| Navy (fundo escuro) | `#0B1624` · cards `#101B2C` |
| Dourado | `#C9A86A` · claro `#D9BC7C` · sobre creme `#AC8A38` |
| Fonte títulos/valores | Cormorant Garamond (600; itálico 500 para nomes) |
| Fonte corpo/labels/CTA | Poppins (400/500/600) |

Referência completa em [`../A10_PADRAO/INSTRUCOES.md`](../A10_PADRAO/INSTRUCOES.md).

## Dados comerciais pendentes

Localização e status de vários empreendimentos estão como **"A confirmar"** de propósito.
Assim que os dados oficiais forem definidos, atualizar em `src/lib/empreendimentos.ts` no
projeto Lovable (campos `localizacao` e `status`).

## Como atualizar

1. Abrir o **editor** do projeto no Lovable (link acima).
2. Para trocar/adicionar fotos: enviar as imagens no chat do Lovable com o nome do `slug`
   e pedir para substituir; o agente sobe para a CDN (`lovable-assets`) e atualiza
   `src/lib/empreendimentos.ts` + rotas.
3. Para publicar o site: usar **Publish** no Lovable (gera um domínio `*.lovable.app`;
   domínio próprio pode ser configurado nas settings do projeto).
