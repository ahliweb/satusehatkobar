---
name: Feature (AI-ready work packet)
about: Self-contained feature issue executable by a junior AI model with a limited token budget.
title: "[FEAT] <short title> — <plugin>"
labels: ["feat", "ai-ready"]
---

<!--
This template produces a SELF-CONTAINED work packet. A junior AI model with a
small token budget must be able to finish it WITHOUT reading the whole PRD.
Embed the exact facts it needs; cite at most 1–2 doc sections + 1 skill.
See docs/prd/25.AI_READY_ISSUE_PLAYBOOK_AND_INDEX.md for the authoring rules.
-->

## 1. Context Capsule (invariants — do not re-derive)

- Workspace plugin dir: `awcmsmicro-dev/packages/plugins/awcms-micro-<key>/` · npm `@awcms-micro/plugin-<key>` · slug `awcms-micro-<key>` · format **Native** (`src/index.ts` descriptor + definition + `admin.tsx` + `emdash-plugin.jsonc`). Pattern to copy: `awcms-micro-sikesra`.
- Persistence: **direct D1 via `ctx.db` (Kysely)**. Schema = `docs/prd/04.DATABASE_MVP_SCHEMA.docx.md`. Each plugin owns **idempotent** migrations (`<prefix>_migrations`) run in `install`/`activate`. `ctx.kv` = cache only. Always parameter-bind. No cross-plugin FK — relate in the service layer + snapshot. (DEC-019)
- API envelope: `{ data, meta }` / `{ data, pagination, meta }` / `{ error: { code, message, details }, meta }`. Error messages in **Bahasa Indonesia**. Handler order: auth → RBAC → ABAC → validation → service → audit → envelope. Handlers thin; logic in services.
- Every mutation writes an audit event. Enforce RBAC/ABAC in the **service layer**, never UI-only.
- Bindings: D1 `DB`, R2 `MEDIA`, KV `SESSION`, Images `IMAGES`. Register the plugin in `templates/awcms-sskobar-cloudflare/astro.config.mjs` `plugins:[]` + `package.json`, and add its path to `scripts/awcmsmicro-dev-protected-paths.txt` + `docs/awcms-micro-implementation-boundaries.md`.
- Full invariants: pinned issue **#11** (`[CAPSULE]`) and `docs/prd/24` §4. Skill: `awcmsmicro-dev/skills/creating-plugins`.

> **Token budget:** read ONLY the doc sections cited in §3 + `docs/prd/24` §4. Do NOT open other PRD files.

## 2. Goal

<!-- One sentence: what user value this delivers. Backlog ID: EPIC-NN-NNN -->

**Backlog**: EPIC-NN-NNN · **Plugin**: `<key>` · **Sprint/Milestone**: Sprint N

## 3. Authoritative references (read only these)

- PRD: `docs/prd/<file>` §X — <topic>
- Skill: `awcmsmicro-dev/skills/<skill>/SKILL.md`

## 4. Scope — exact changes

**Data (D1 via `ctx.db`)**
- [ ] Table `<prefix>_<name>` columns: … (copy from doc 04). Migration step in `<prefix>_migrations`, idempotent.

**API**
- [ ] `<METHOD> /api/<path>` — purpose. Auth: yes/no · RBAC: `permission.name` · ABAC: `<rule>`

**Service / domain**
- [ ] `services/<x>.ts` — logic, audit event `<event>`

**UI (if any)**
- [ ] `admin.tsx` page/component `<name>` — Kumo tokens, dark+light, mobile-first (375px)

## 5. Acceptance Criteria (testable)

- [ ] AC-1 …
- [ ] AC-2 …

## 6. Definition of Done

- [ ] Idempotent migration added + runs on a clean DB
- [ ] Service enforces RBAC + ABAC; mutation writes audit event
- [ ] Unit + integration tests pass; types generated (`emdash types`)
- [ ] Plugin registered + boundary path added (if new plugin)
- [ ] Lint + typecheck pass (`bash scripts/validate-awcmsmicro-dev.sh`)
- [ ] Error messages in Bahasa Indonesia; envelope correct
