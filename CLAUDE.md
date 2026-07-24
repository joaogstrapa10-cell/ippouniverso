# CLAUDE.md — Base (template) de site para clínica odontológica de alto padrão

Memória de trabalho entre sessões. Manter atualizado.

---

## 1. Contexto do projeto

Construir a **BASE (template)** de um site para clínica odontológica de alto padrão no Brasil.
Depois de validada, a base é replicada e customizada individualmente para **3 sócios**:
**Dalton, Rogério e Décio** — cada um com sua própria clínica/site.

**Referência de layout e pegada visual** (estrutura + estética a seguir):
`https://productized-agency-template-acetern.vercel.app/`

**Fonte de conteúdo** (textos, imagens, seções a reaproveitar):
`https://suzukiodontologia.com.br/` — WordPress/Elementor, clínica **Suzuki Odontologia**,
Curitiba/PR. Posicionamento atual: conservador/institucional. A base nova deve elevar isso
sem perder a autoridade.

**Stack:** projeto gerado no **Lovable** (React + Vite + TypeScript + Tailwind + shadcn/ui),
repositório no GitHub.

**Objetivo de arquitetura:** replicar para Dalton, Rogério e Décio deve ser
`trocar src/content/clinica.ts + tokens de tema`, **sem tocar em componente**.

---

## 2. Divisão de papéis

| Quem | Faz |
|---|---|
| **Usuário (João)** | Opera a interface do Lovable: cria o projeto, conecta o GitHub em Settings/Integrations, puxa o sync após os pushes. Fornece dados que só ele tem (telefone correto, fotos, CRO dos sócios). |
| **Claude** | Opera o repositório: raspa as fontes, escreve o prompt do Lovable, mapeia o código gerado, refatora, integra componentes, commita e faz push. |

**Regra dura:** Claude **não** acessa nem automatiza o Lovable. Quando precisar de uma ação
na UI do Lovable, pede explicitamente e **para**.

---

## 3. Regras de operação

### Créditos Lovable
- Lovable é usado para **uma geração inicial** e para os syncs.
- Todo refino visual, ajuste de copy e correção acontece **no repo, por Claude** — não por
  prompts novos no Lovable.
- Por isso o prompt-mestre da Fase 1 precisa acertar de primeira.

### Tokens
- Antes de ler qualquer arquivo, localizar com `rg`/glob. Ler apenas os trechos necessários
  (offset/limit). Nunca ler arquivo inteiro acima de ~400 linhas.
- **Nunca ler:** `node_modules/`, `dist/`, `package-lock.json`, `*.lock`, assets binários,
  `src/components/ui/*` do shadcn (assumir comportamento padrão).
- **Nunca rodar** `npm run dev` nem qualquer processo em watch.
- Validar com `npx tsc --noEmit` e `npm run build`, **só ao final de cada fase**, e reportar
  **apenas as linhas de erro** — nunca o log completo.
- Edições cirúrgicas (str_replace). Não reescrever arquivos inteiros para mudar poucas linhas.
- Não mostrar diffs longos. Resumir em bullets: `arquivo → o que mudou e por quê`.
- Não repetir de volta conteúdo que acabou de ser escrito em arquivo. Dizer só o caminho.
- Agrupar dúvidas: **máximo 3 perguntas por vez**, e só quando a decisão for irreversível ou
  depender de informação que só o usuário tem. Se puder decidir com bom senso, decidir e
  registrar a decisão em uma linha no log abaixo.
- Pedir OK antes de **qualquer** `git commit`.

### Checkpoints
- Ao final de **cada fase**, parar e esperar OK explícito antes de avançar. **Não emendar fases.**

### Git
- Branch de desenvolvimento: `claude/dental-clinic-site-base-s7tibx`
- Push sempre com `git push -u origin <branch>`. Retry em falha de rede: 2s, 4s, 8s, 16s.
- Não abrir Pull Request sem pedido explícito.

---

## 4. Restrições de conteúdo e compliance

- **CFO-196/2019** restringe divulgação de antes/depois em publicidade odontológica.
  Qualquer galeria de comparação deve ser **genérica e reutilizável** (estrutura da clínica,
  tecnologia, processo), sem copy que prometa resultado.
- **Zero lorem ipsum.** Onde faltar informação, usar placeholder explícito e nomeado
  (ex: `[CRO-PR 00000]`), nunca texto genérico de preenchimento.
- Sem clichê de estoque: dente branco brilhando, sorriso genérico, azul-claro de consultório.
- Não replicar o vazamento `http://localhost/website-susuki-odontologia/...` (resíduo da
  agência anterior) encontrado num link de logo do site antigo.

---

## 5. Estado das fases

| Fase | Descrição | Estado |
|---|---|---|
| 0 | Mapear antes de executar | **Concluída com ressalva** — OK do usuário em 24/07; egress policy bloqueou as fontes (ver §7) |
| 1 | Prompt-mestre do Lovable (`docs/prompt-lovable.md`) | **Concluída** — prompt enviado ao Lovable via MCP em 24/07 |
| 2 | Assumir o repositório gerado | **Bloqueada** — aguardando o GitHub ser conectado na UI do Lovable |
| 3 | Primeiro ciclo completo de edição | Não iniciada |
| 4 | Componente de destaque do 21st.dev | Não iniciada |
| 5 | Preparar a replicação (`docs/replicacao.md`) | Não iniciada |

---

## 6. Arquivos deste projeto

| Caminho | Conteúdo |
|---|---|
| `CLAUDE.md` | Este arquivo. Contexto, papéis, regras, log de decisões. |
| `docs/referencia-layout.md` | Especificação de layout extraída da referência visual. |
| `docs/conteudo-fonte.md` | Conteúdo consolidado do site antigo, com proveniência marcada. |
| `docs/prompt-lovable.md` | Fase 1. Prompt único para colar no Lovable. |
| `docs/replicacao.md` | Fase 5. Passo a passo para gerar as 3 variantes. |

---

## 7. Bloqueio de rede ativo (ambiente)

A sessão roda em ambiente remoto com **network policy de allowlist**. Hosts testados:

| Host | Resultado |
|---|---|
| `productized-agency-template-acetern.vercel.app` | **403 — bloqueado** |
| `suzukiodontologia.com.br` | **403 — bloqueado** |
| `21st.dev` | **403 — bloqueado** |
| `example.com`, `vercel.com`, `web.archive.org` | **403 — bloqueado** |
| `github.com` | liberado |
| `registry.npmjs.org` | liberado |

`WebSearch` funciona (não passa pelo egress proxy), mas devolve só fragmentos indexados —
não substitui a raspagem das páginas.

**Consequência:** as fontes primárias não podem ser lidas por Claude. Resolver por uma das vias:
1. Ampliar a network policy do ambiente para incluir os 3 hosts
   (ver `https://code.claude.com/docs/en/claude-code-on-the-web`); **ou**
2. O usuário cola o conteúdo das páginas / exporta os assets manualmente.

Nunca contornar a policy (proxies de terceiros, mirrors). Reportar o host bloqueado.

---

## 8. Projeto no Lovable

| Campo | Valor |
|---|---|
| Nome | Dentis Base Template |
| `project_id` | `9d05bd27-0257-47ec-bd63-1901ee5d1c12` |
| Workspace | `Giulliano's Lovable` (`9G3fAkdnuvQqWzEwcVjW`), plano pro |
| Editor | `https://lovable.dev/projects/9d05bd27-0257-47ec-bd63-1901ee5d1c12` |
| Preview | `https://id-preview--9d05bd27-0257-47ec-bd63-1901ee5d1c12.lovable.app` |
| Criado | 2026-07-24, prompt enviado via MCP |

### Stack real do scaffold (≠ do que o prompt assumiu)

O prompt da Fase 1 assumiu Vite + `tailwind.config.ts` + `src/index.css` + npm.
O scaffold que o Lovable entregou é outro:

| Prompt assumiu | Scaffold real |
|---|---|
| Vite + React puro | **TanStack Start** (`src/router.tsx`, `src/routes/`, `src/server.ts`, `src/start.ts`) |
| `tailwind.config.ts` | **não existe** — Tailwind v4, config CSS-first via `@theme` |
| `src/index.css` | `src/styles.css` |
| `npm install` | **bun** (`bun.lock`, `bunfig.toml`) |
| "sem router" | scaffold é router-based; a página vive em `src/routes/index.tsx` |

Consequência para a Fase 2: auditar se o agente criou um `tailwind.config.ts` inerte
(ignorado pelo Tailwind v4) e migrar os tokens para `@theme` no `src/styles.css`.
Usar `bun install`, não `npm install`.

O scaffold também traz `AGENTS.md` e `.lovable/project.json` — ler antes de refatorar.

---

## 9. Log de decisões (append-only, uma linha por decisão)

- 2026-07-24 — Base do projeto criada na branch `claude/dental-clinic-site-base-s7tibx` do repo `joaogstrapa10-cell/ippouniverso`, que já contém material não relacionado (`A10_PADRAO/`, `EMPREENDIMENTOS A10/`, `capetown/`) — pendente confirmar se é o repo definitivo.
- 2026-07-24 — `CLAUDE.md` e `docs/` ficam na raiz conforme especificado; na Fase 2 serão copiados para o repo gerado pelo Lovable, que passa a ser a fonte única de verdade.
- 2026-07-24 — Fontes primárias (referência de layout, site antigo, 21st.dev) inacessíveis por egress policy do ambiente. Registrado em §7; não contornar.
- 2026-07-24 — `docs/referencia-layout.md` escrito com a ordem de seções fornecida pelo usuário (ground truth) + proposta de sistema visual marcada como `PROPOSTA`, para não bloquear a Fase 1. Substituir por extração real quando a referência for acessível.
- 2026-07-24 — Proveniência do conteúdo marcada por tag em `docs/conteudo-fonte.md` (`[HOME]`, `[WS]`, `[FALTA]`) para nunca confundir dado verificado com inferência.
- 2026-07-24 — `odontosuzuki.com.br`, `suzukikannoodontologia.com.br` e `clinicaseizosuzuki.com.br` são clínicas Suzuki distintas em Curitiba; não misturar conteúdo com a fonte.
- 2026-07-24 — Fase 1 seguiu sem as respostas das lacunas de conteúdo: a geração do Lovable define **estrutura e arquitetura**, e copy vive em `clinica.ts` — preencher depois é edição no repo, custo zero de crédito. Arquitetura errada é que sai caro.
- 2026-07-24 — Instância base do template = **Suzuki / Dr. Dalton** (único conteúdo real disponível). Rogério e Décio derivam trocando `clinica.ts` + accent.
- 2026-07-24 — Seção 9 da referência (pricing) → **"Tratamentos" com `Valor sob avaliação`**: a clínica não divulga preço e não se inventa valor. Formato de 3 cards preservado.
- 2026-07-24 — Depoimentos ficam como `[DEPOIMENTO VERBATIM — Nome]` visível no render. Não se fabrica depoimento atribuído a paciente real.
- 2026-07-24 — Descrições das 8 especialidades no prompt são **rascunho de Claude** (factuais, sem promessa de resultado), não a copy do site. Substituir quando as 8 páginas forem raspadas.
- 2026-07-24 — Telefone exibido e `href` saem do **mesmo campo** de `clinica.ts`, para não repetir o bug do site antigo (display do celular apontando para `tel:4133633040`).
- 2026-07-24 — **Regra do §2 revogada pelo usuário:** um MCP do Lovable ficou disponível e o usuário autorizou Claude a dirigir o Lovable por ele. Claude agora cria projeto e manda mensagem; conectar o GitHub continua manual (o MCP não faz).
- 2026-07-24 — Projeto criado no workspace do **Giulliano** (pro), escolha do usuário, por o plano free do João não aguentar a geração. Crédito consumido é do Giulliano.
- 2026-07-24 — `create_project` estourou o timeout de 60s do cliente MCP mas **o projeto foi criado**. Sempre checar com `list_projects` antes de repetir uma chamada de criação — repetir duplica projeto e queima crédito.
- 2026-07-24 — Scaffold do Lovable é TanStack Start + Tailwind v4 + bun, não Vite + `tailwind.config.ts` + npm. Ver §8. Corrigir o prompt-mestre antes de reusar para Rogério e Décio.
