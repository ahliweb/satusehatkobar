---
name: sskobar-e2e-release
description: Implement Satu Sehat Kobar end-to-end/UAT tests, the consolidated UAT/demo seed (17 roles + full sample flow), and the deployment + smoke + rollback runbook. Use for EPIC-16 issues.
---

# SSK E2E, UAT & Release

Validates and ships the whole MVP. Authoritative: `docs/prd/06` (UAT scenarios §3, go-live §4, rollback §5), `docs/prd/07` (repo/deploy SOP), `docs/deployment/cloudflare.md`. Location: `awcmsmicro-dev/e2e/awcms-micro/` (Playwright, see `awcmsmicro-dev/playwright.config.ts`).

## E2E test suite (doc 06 §3)

- Cover the full MVP path end-to-end: Agenda → ST/SPPD → Approval (incl. finance auto-skip) → Generate PDF → Upload signed → Evidence (all participants) → Verify → Journal → Dashboard/SPM → Archive → MMC draft.
- One spec per module (§3.1–§3.10) plus a happy-path "golden flow" spec that chains all modules.
- Test **RBAC/ABAC across the 17 roles** and across faskes (cross-faskes chain, finance dinas_all vs faskes_own).
- Keep tests deterministic: seed first (REL-02), reset between runs.

## Consolidated UAT/demo seed (doc 06 §2.4)

- One idempotent seed that creates: 17 role users with correct permissions + unit/faskes/finance scope, org units, region, faskes, personnel, SPM, holidays, and a sample agenda→ST→…→archive flow in known states.
- Composes the per-plugin seeds in dependency order (BE-09) — do not duplicate them; orchestrate.
- Re-runnable without duplicates (upsert by natural key).

## Deployment + smoke + rollback (doc 06 §4–5, doc 07)

- Repeatable deploy to Cloudflare (Worker + D1 + R2 + KV bindings) per `docs/deployment/cloudflare.md`; secrets via `wrangler secret put` (BE/EPIC-11-003).
- Post-deploy **smoke test**: health (#26), login, one create+read per core module, dashboard render.
- **Rollback runbook**: documented, tested on staging; DB backup before schema change (EPIC-11-004); RTO ≤ 4h / RPO ≤ 24h (doc 19).
- Go-live gate (doc 06 §4): 0 Critical, 0 High; all Must-Have UAT scenarios pass.

## Checklist
- [ ] Golden-flow E2E + per-module specs pass · [ ] 17-role RBAC/ABAC covered · [ ] idempotent consolidated seed (orchestrates per-plugin seeds) · [ ] smoke test green post-deploy · [ ] rollback tested on staging · [ ] go-live gate criteria documented.
