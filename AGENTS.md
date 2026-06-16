# AGENTS

This repository is a parent maintenance workspace for AWCMS-Micro and EmDash alignment.

## Root Layout

- `emdash-latest/`: latest synchronized EmDash source tree (upstream reference, read-only)
- `awcms-latest/`: latest synchronized AWCMS-Micro source tree from `ahliweb/awcms-micro` (upstream reference, read-only)
- `awcmsmicro-dev/`: managed clone of `emdash-latest/` used for AWCMS-Micro development
- `docs/`: parent-repository technical documentation
- `scripts/`: root maintenance scripts

## Core Intent

Analyze `https://github.com/emdash-cms/emdash`, then update `https://github.com/ahliweb/awcms-micro` so it stays fully synchronized with EmDash.

`awcms-micro` is an independent repository. It must not act as a host for other repositories in the product or runtime sense. It should serve as an example implementation that fully adopts EmDash 100% and includes only example plugins and example templates that follow the AWCMS-Micro standard, without modifying EmDash core.

Within this parent workspace:

- `emdash-latest/` is the upstream reference snapshot
- `awcmsmicro-dev/` is the development workspace where AWCMS-Micro-specific work is prepared

## Execution Rules

- Proceed step by step using an atomic strategy.
- Prefer small, reviewable changes.
- Rebuild `awcmsmicro-dev/` from `emdash-latest/` before starting new implementation work when synchronization is required.
- Keep AWCMS-Micro release-note inputs and release automation inside preserved downstream boundaries such as `.awcms-changesets/` and `.github/scripts/`.
- Keep the root workspace snapshot in `CHANGELOG.md` aligned with the current EmDash upstream SHA and the latest versions/changelog entries for every plugin and template in `awcmsmicro-dev/`; keep workspace package releases like `awcmsmicro-dev/packages/admin/` aligned with `awcmsmicro-dev/.changeset/`.
- Keep root documentation in sync with the actual folder structure and workflow.
- Keep backup and mirror documentation aligned with the current PAT-based GitLab flow and the safe `.env` overlay used by `scripts/backup/load-config.sh`.
- Treat the root `.env` as the canonical operator config for this workspace and keep derived files synchronized through `scripts/sync-sskobar-env.sh`.
- When work is too large for one pass, split it into smaller tracked tasks.
- If useful, create GitHub issues so work can later be executed by a smaller or lower-cost AI model.

## Language Policy

- English (US) is the official language for this repository's root-level documentation, instructions, scripts, and governance text.
- Preserve `emdash-latest/` exactly as upstream EmDash provides it, including non-US spelling or wording.
- Allow `awcmsmicro-dev/` to inherit upstream wording when it is synchronized from `emdash-latest/`, unless there is a separate AWCMS-Micro-specific reason to change it.
- All active plugins must default to English (`en`) and contain complete, ready-to-use Indonesian (`id`) translations for all key/label definitions.

## Plugin Admin Sidebar Policy

- When any downstream plugin is active, its admin sidebar menu must be positioned at the top, directly below the Dashboard and before default EmDash menus.
- Each plugin's menu items must be grouped into their own distinct collapsible menu group to prevent mixing or cluttering sidebar navigation between different plugins.

## Product Implementation (Satu Sehat Kobar)

- The Satu Sehat Kobar product spec lives in `docs/prd/` and is implemented as Native EmDash plugins plus the `awcmsmicro-dev/templates/awcms-sskobar-cloudflare/` template — not by forking EmDash core.
- Before turning any PRD requirement into code, read `docs/prd/20.Master Document Index and Implementation Guide.docx.md` (entry point) and `docs/prd/24.TECHNICAL_IMPLEMENTATION_REFERENCES.md` (workspace bridge).
- SSK plugins use the **Native** format (React admin + direct data access), named `awcms-micro-<key>` (npm `@awcms-micro/plugin-<key>`), registered in the template `astro.config.mjs` `plugins: []`. Follow the existing `awcms-micro-sikesra` plugin as the reference pattern.
- Persistence default is **direct Cloudflare D1** via `ctx.db` (Kysely) — `docs/prd/04.DATABASE_MVP_SCHEMA.docx.md` is the physical schema. EmDash has no plugin migration runner, so each plugin owns its idempotent schema migrations (`<prefix>_migrations`, run in `install`/`activate`). `ctx.kv` is for cache only; using storage collections as a domain store is an exception. Decision: DEC-019 in `docs/prd/12`; detail: `docs/prd/24` §4.4.
- Use the workspace skills as authoritative guides: `awcmsmicro-dev/skills/creating-plugins` and `awcmsmicro-dev/skills/building-emdash-site`, plus the SSK per-part execution skills `.opencode/skills/sskobar-{plugin-execution,data-d1,api-rbac,ui-admin}`.
- Work is tracked as **AI-ready GitHub issues** (self-contained, sized for a junior AI with limited tokens). Standard + full coverage index: `docs/prd/25.AI_READY_ISSUE_PLAYBOOK_AND_INDEX.md`. Every `ai-ready` issue references pinned issue **#11 `[CAPSULE]`** and cites only 1–2 doc sections. Templates in `.github/ISSUE_TEMPLATE/`; milestones `Sprint 0`–`Sprint 6`. When asked to create the next batch of issues, follow doc 25 §7.

## Root Documentation

- `README.md`
- `docs/README.md`
- `docs/prd/20.Master Document Index and Implementation Guide.docx.md` (product spec entry point)
- `docs/prd/24.TECHNICAL_IMPLEMENTATION_REFERENCES.md` (PRD-to-workspace bridge)
- `docs/awcms-micro-implementation-boundaries.md`
- `docs/repository-structure.md`
- `docs/synchronization-workflow.md`
- `docs/implementation-instructions.md`
- `docs/awcms-micro-versioning.md`
- `docs/awcms-micro-root-versioning.md`
- `docs/operator-workflow.md`
- `docs/environment-configuration.md`
- `docs/decision-records.md`
- `docs/backup/gitlab-mirror-setup.md`
- `docs/security/backup-restore.md`
