---
name: sskobar-plugin-execution
description: Build or extend a Satu Sehat Kobar (SSK) feature as a Native EmDash/AWCMS-Micro plugin. Use this when implementing any SSK GitHub issue (EPIC-xx) — it gives the format, naming, registration, persistence (direct D1), API, RBAC/ABAC, audit, and Definition of Done so a limited-token model can finish without reading the whole PRD.
---

# SSK Plugin Execution

Use for any Satu Sehat Kobar implementation issue. This is the execution contract; the issue body carries the domain specifics. Read ONLY the doc sections the issue cites + `docs/prd/24` §4. Do not open the whole PRD.

## Invariants (do not re-derive)

- **Plugin = Native EmDash plugin.** Dir `awcmsmicro-dev/packages/plugins/awcms-micro-<key>/`, npm `@awcms-micro/plugin-<key>`, slug `awcms-micro-<key>`. Copy the shape of `awcms-micro-sikesra` (`src/index.ts` descriptor + definition + `admin.tsx` + `emdash-plugin.jsonc`).
- **Persistence = direct D1 via `ctx.db` (Kysely).** Schema is `docs/prd/04.DATABASE_MVP_SCHEMA.docx.md` (physical). See skill `sskobar-data-d1`.
- **API envelope + RBAC/ABAC + audit.** See skill `sskobar-api-rbac`.
- **Admin UI = React in `admin.tsx`, Kumo tokens, dark+light, mobile-first.** See skill `sskobar-ui-admin`.
- Bindings: D1 `DB`, R2 `MEDIA`, KV `SESSION` (cache only), Images `IMAGES`.

## Steps

1. **Locate / scaffold the plugin.** If it exists, edit it. If new, scaffold `awcms-micro-<key>` from the `awcms-micro-sikesra` shape. Reference: `awcmsmicro-dev/skills/creating-plugins/SKILL.md`.
2. **Descriptor (`src/index.ts`)** — `format: "native"`, `id`, `version`, `entrypoint`, `adminEntry`, capabilities. Side-effect-free (runs in Vite at build).
3. **Definition (runtime)** — `definePlugin({ hooks, routes })`. Put lifecycle hooks (`install`/`activate`) that run the plugin's idempotent migrations.
4. **Data** — implement tables from doc 04 via `ctx.db` + an idempotent `<prefix>_migrations` module. Skill `sskobar-data-d1`.
5. **Service layer** — all business logic, RBAC + ABAC checks, and audit writes live here. Handlers stay thin.
6. **Routes** — follow the envelope + handler order. Skill `sskobar-api-rbac`.
7. **Admin UI** — only if the issue asks. Skill `sskobar-ui-admin`.
8. **Register** the plugin in `templates/awcms-sskobar-cloudflare/astro.config.mjs` `plugins:[]` + `package.json`, and add its path to `scripts/awcmsmicro-dev-protected-paths.txt` + `docs/awcms-micro-implementation-boundaries.md`.
9. **Verify** — `bash scripts/validate-awcmsmicro-dev.sh` (install, typecheck, lint, test, build). Generate types via `emdash types` when schema/collections change.

## Definition of Done

- [ ] Idempotent migration runs clean on an empty DB.
- [ ] Service enforces RBAC + ABAC; every mutation writes an audit event.
- [ ] Unit + integration tests pass; types generated.
- [ ] Plugin registered + boundary path added (new plugins).
- [ ] Lint + typecheck pass; envelope correct; error messages in Bahasa Indonesia.

## Ease of development & future integration

- Keep domain logic in services with explicit relational tables (doc 04) so Phase-2 integrations (SIMPEG, SIPD, BSrE, BI/reporting) can read clean SQL.
- No cross-plugin FK or direct cross-plugin table reads — use a service contract + snapshot. This keeps plugins independently buildable and integrable.
