# Upstream Sync Status

## Source

- Upstream repository URL: `https://github.com/emdash-cms/emdash`
- Upstream branch: `main`
- Upstream commit SHA: `34dd430b35032535a972e9ed718c0eacaeae2029`
- Sync date: `2026-06-13T09:53:52Z`
- Operator: `unggul`
- Target folder: `emdash-latest/`
- Development workspace: `awcmsmicro-dev/`

## AWCMS-Micro Reference

- Upstream repository URL: `https://github.com/ahliweb/awcms-micro`
- Upstream branch: `main`
- Upstream commit SHA: `279126bffd279d56b085de238cf2b845d5ffd586`
- Fetch date: `2026-06-13T09:54:35Z`
- Target folder: `awcms-latest/`

## Status Summary

Synced to EmDash `34dd430b`. `emdash-latest/` and `awcmsmicro-dev/` both refreshed successfully. `awcms-latest/` updated from `ahliweb/awcms-micro` for the first time. EmDash jumped from v0.15.0 → v0.19.0 with three new migrations (041–043) and two significant new systems: byline custom fields and content references. Protected paths fix: renamed `templates/awcms-micro-default-cloudflare` → `templates/awcms-sskobar-cloudflare` in `awcmsmicro-dev-protected-paths.txt` to match the current template name.

## Key Changes in This Sync

- EmDash core packages upgraded: v0.15.0 → v0.19.0
- New migration 041: `content_locale_list_index` — i18n composite index optimization
- New migration 042: `byline_fields` — custom fields on bylines (new tables: `_emdash_byline_fields`, `_emdash_byline_field_values`, `_emdash_byline_field_group_values`)
- New migration 043: `content_references` — directed content relationships (new tables: `_emdash_relations`, `_emdash_content_references`)
- New feature: repeater image subfields with `MediaValue` support
- New API route: `GET /_emdash/api/content/{collection}/authors`
- New API route: `GET /_emdash/api/admin/plugins/registry/artifact`
- Tooling: `oxfmt` 0.34 → 0.54, `oxlint` 1.66 → 1.69, Playwright 1.58 → 1.60
- `@atcute/*` packages aligned to v2
- `create-emdash` scaffolds `.env` instead of `.dev.vars`
- Created `awcms-latest/` folder: snapshot of `ahliweb/awcms-micro` main branch
- Created `scripts/update-awcms-latest.sh`
- Fixed protected paths: `templates/awcms-micro-default-cloudflare` → `templates/awcms-sskobar-cloudflare`
- `scripts/sync-and-validate-awcmsmicro-dev.sh` now also runs `update-awcms-latest.sh`
- GitHub issues created: #4 (D1 backup), #5 (migrations), #6 (byline fields), #7 (content references), #8 (@atcute v2), #9 (.env migration)

## Validation Status

| Check | Status | Notes |
| --- | --- | --- |
| Upstream fetch into `emdash-latest/` | Passed | SHA `34dd430b` from EmDash `main` |
| Upstream fetch into `awcms-latest/` | Passed | SHA `279126bf` from `ahliweb/awcms-micro` `main` |
| Rebuild `awcmsmicro-dev/` from `emdash-latest/` | Passed | Protected paths restored; 1537 stale transient dirs pruned |
| Protected path fix: `awcms-sskobar-cloudflare` | Passed | Restored from git HEAD after protected-paths correction |
| Validation script execution | Pending | Run `bash scripts/validate-awcmsmicro-dev.sh` to update |

## Open Actions

| Issue | Title | Status |
| --- | --- | --- |
| #4 | Configure Cloudflare credentials and run D1 backup | Open |
| #5 | Apply EmDash migrations 041–043 | Open |
| #6 | Evaluate byline custom fields for awcms-micro-sikesra | Open |
| #7 | Evaluate content references for awcms-micro-gallery | Open |
| #8 | Align @atcute peer deps to v2 | Open |
| #9 | Migrate .dev.vars → .env in awcms-sskobar-cloudflare | Open |

## Notes

- `emdash-latest/` remains the clean upstream snapshot.
- `awcms-latest/` is the clean upstream snapshot of `ahliweb/awcms-micro` (the full parent workspace).
- `awcmsmicro-dev/` is the workspace for AWCMS-Micro-specific plugin and template additions.
- Migrations 041–043 are present in `awcmsmicro-dev/packages/core/src/database/migrations/` and must be applied to all environments (see issue #5).
- Any accepted downstream divergence must be logged in `DIVERGENCE_LOG.md`.
