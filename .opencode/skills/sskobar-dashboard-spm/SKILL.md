---
name: sskobar-dashboard-spm
description: Implement the Satu Sehat Kobar dashboard aggregate endpoint with KV caching and the 12-indicator SPM tracker. Use for EPIC-08 issues (satusehat-dashboard / spm-health).
---

# SSK Dashboard & SPM

Plugins `satusehat-dashboard` + `spm-health`. Builds on `sskobar-data-d1` + `sskobar-api-rbac`. Authoritative: `docs/prd/05`, `docs/prd/15` (KPI), `docs/prd/12` (DEC-014).

## Aggregate endpoint + cache (DEC-014)

- `GET /dashboard/aggregate` returns the main KPIs; target render < 3s.
- Cache in **`ctx.kv`** (not a separate KV binding) with **TTL 15 min**. Key `dashboard:aggregate:{unit_id}:{period}`.
- Invalidate on significant mutation (e.g. a new ST reaching `final_approved`).
- Filters: `unit_id`, `faskes_id`, `period` (month/quarter/year); keep filters in URL params. Approval-status summary widget (pending/returned/approved/rejected, last 30 days) reads cache when available.

## SPM tracker (12 indicators)

- `GET /spm/tracker` returns 12 indicators with target vs realisation; filter period + faskes.
- Indicators are **computed** from agenda + ST + verified evidence (read via service contracts/snapshots, not other plugins' tables directly).
- `spm-health` master is **seed-only in MVP** (DEC: CRUD is Phase 2): seed `code, name, target_percentage, calculation_method` for the 12 indicators, idempotent.

## Notes

- Dashboard is read-mostly; still enforce ABAC (a Kabid sees their unit/faskes scope).
- Don't make the dashboard real-time/no-cache (rejected, CHG-008) — use the 15-min KV cache.

## Checklist
- [ ] Aggregate cached in ctx.kv (key+TTL) + invalidation · [ ] 12 SPM indicators computed + filters · [ ] SPM seed idempotent (seed-only) · [ ] ABAC scope on dashboard reads.
