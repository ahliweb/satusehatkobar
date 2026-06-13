# AWCMS-Micro Changelog

## 0.1.8 - 2026-06-13

- Syncs EmDash upstream from `4075652a` to `34dd430b` (v0.15.0 → v0.19.0).
- Creates `awcms-latest/` folder: new upstream reference snapshot of `ahliweb/awcms-micro` at `279126bf`.
- Adds `scripts/update-awcms-latest.sh` for refreshing `awcms-latest/` from `ahliweb/awcms-micro`.
- Integrates `update-awcms-latest.sh` into the combined `sync-and-validate-awcmsmicro-dev.sh` wrapper.
- Fixes protected paths: renames `templates/awcms-micro-default-cloudflare` to `templates/awcms-sskobar-cloudflare` in `scripts/awcmsmicro-dev-protected-paths.txt` to match the current template name.
- Brings in EmDash migrations 041 (`content_locale_list_index`), 042 (`byline_fields`), and 043 (`content_references`) into `awcmsmicro-dev/packages/core/src/database/migrations/`.
- Adds architecture and workflow Mermaid diagrams to `docs/repository-structure.md`, `docs/synchronization-workflow.md`, `docs/operator-workflow.md`, and `docs/awcms-micro-implementation-boundaries.md`.
- Updates `README.md` with `awcms-latest/` in root structure, converts maintenance script list to a table, and refreshes the standard workflow steps.
- Adds `# AGENTS` heading to `AGENTS.md` and documents the `awcms-latest/` folder in the root layout.
- Updates `docs/upstream-sync/UPSTREAM_SYNC_STATUS.md` with new SHA, open issue list, and AWCMS-Micro reference block.
- Creates GitHub issues #4–#9 to track: D1 backup credentials (#4), migrations 041–043 (#5), byline custom fields for sikesra (#6), content references for gallery (#7), @atcute v2 alignment (#8), and .dev.vars → .env migration (#9).

## 0.1.7 - 2026-06-13

- Adds a dedicated failure classification for `awcms-sskkobar` config validation and aligns the environment-configuration doc example with the canonical repository URL.
## 0.1.6 - 2026-06-13

- Integrates the canonical `awcms-sskkobar` configuration validation into the main validation workflow and the combined sync-and-validate wrapper.
## 0.1.5 - 2026-06-13

- Expands the root `.env` sync flow so it updates related deployment, workflow, template, and operator example files from a single source of truth.
## 0.1.4 - 2026-06-13

- Adds canonical `awcms-sskkobar` configuration validation and teaches the deploy workflow to read the canonical template identifier alongside the template package target.
## 0.1.3 - 2026-06-13

- Aligns the root workspace environment, Cloudflare deployment defaults, backup resource names, and operational documentation with the canonical `awcms-sskkobar` template and resource identifiers.
## 0.1.2 - 2026-06-13

- Corrects the root environment model so variable names stay standard while `sskobar_` is used for managed remote-service values, and updates automation and documentation to match.
## 0.1.1 - 2026-06-13

- Introduces a canonical root `.env` using the `ss_kobar_` namespace, adds sync automation for local Cloudflare development values, and updates root documentation for the new environment-management workflow.
## 0.1.0 - 2026-05-28

- Introduces the root-level AWCMS-Micro versioning and changelog system for maintenance-workspace changes.

## Workspace Snapshot - 2026-06-13

- EmDash upstream: `34dd430b35032535a972e9ed718c0eacaeae2029` from `emdash-latest/`
- AWCMS-Micro upstream: `279126bffd279d56b085de238cf2b845d5ffd586` from `awcms-latest/`
- Root version: `0.1.8`

### Plugins

- `@awcms-micro/plugin-gallery` `0.0.4` - Fix gallery admin media picking, add media import/listing, and restore paginated gallery management.
- `@awcms-micro/plugin-sikesra` `0.1.1` - Localizes the plugin-local navigation fallback copy, ABAC helper labels, and verification flow notes so the example plugin surface stays aligned with the active locale.
- `@emdash-cms/plugin-ai-moderation` `0.2.0` - latest changelog section: 0.2.0
- `@emdash-cms/plugin-api-test` `0.0.3` - latest changelog section: 0.0.3
- `@emdash-cms/plugin-atproto` `0.2.0` - latest changelog section: 0.2.0
- `@emdash-cms/plugin-audit-log` `0.2.0` - latest changelog section: 0.2.0
- `@emdash-cms/plugin-color` `0.2.0` - latest changelog section: 0.2.0
- `@emdash-cms/plugin-embeds` `0.1.23` - latest changelog section: 0.1.23
- `@emdash-cms/plugin-field-kit` `0.1.0` - latest changelog section: 0.1.0
- `@emdash-cms/plugin-forms` `0.2.4` - latest changelog section: 0.2.4
- `@emdash-cms/plugin-marketplace-test` `0.1.2` - latest changelog section: 0.1.2
- `@emdash-cms/plugin-sandboxed-test` `0.0.3` - latest changelog section: 0.0.3
- `@emdash-cms/plugin-webhook-notifier` `0.2.0` - latest changelog section: 0.2.0

### Templates

- `@awcms-micro/template-default-example` `0.0.2` - Adds plugin-owned navigation exports for the AWCMS-Micro example plugin and updates the default Node template guidance to match the plugin-and-template-only release model.
- `@awcms-sskobar/template-sskobar-cloudflare` `0.1.0` - latest changelog section: 0.1.0
- `@emdash-cms/template-blank` `0.0.3` - latest changelog section: 0.0.3
- `@emdash-cms/template-blog` `0.0.3` - latest changelog section: 0.0.3
- `@emdash-cms/template-blog-cloudflare` `0.0.3` - latest changelog section: 0.0.3
- `@emdash-cms/template-marketing` `0.0.3` - latest changelog section: 0.0.3
- `@emdash-cms/template-marketing-cloudflare` `0.0.3` - latest changelog section: 0.0.3
- `@emdash-cms/template-portfolio` `0.0.3` - latest changelog section: 0.0.3
- `@emdash-cms/template-portfolio-cloudflare` `0.0.3` - latest changelog section: 0.0.3
- `@emdash-cms/template-starter` `0.0.3` - latest changelog section: 0.0.3
- `@emdash-cms/template-starter-cloudflare` `0.0.3` - latest changelog section: 0.0.3
