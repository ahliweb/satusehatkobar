---
name: sskobar-master-data
description: Implement Satu Sehat Kobar master-data foundation — official/local region, health facilities, organization units, document numbering, signatories, holidays, transport, and personnel (employees/positions/supervisors). Use for EPIC-13 issues (addenda doc 21/22/23).
---

# SSK Master Data Foundation

Prerequisite data for the whole flow. Builds on `sskobar-data-d1` + `sskobar-api-rbac`. Authoritative: `docs/prd/21` (wilayah/faskes/lokasi), `docs/prd/22` (org/numbering/signatories/SPM/holidays/transport), `docs/prd/23` (pegawai). Persistence: direct D1 via `ctx.db`, idempotent migrations (DEC-019).

## Plugins & ownership

- `official-region` (`region_*`, doc 21 §3) — Must Have, Sprint 1. Kemendagri hierarchy Provinsi→Desa; seed Kotawaringin Barat + Kalteng.
- `local-region` (`local_region_*`, doc 21 §4) — Should Have. Non-Kemendagri areas.
- `health-facility` (`hf_*`, doc 21 §5) — Must Have, Sprint 1. `hf_health_facilities`, `hf_facility_contacts`, `hf_facility_services` + coordinates. Foundation for ABAC faskes.
- `personnel` (`employees`, `employee_*`, doc 23 §2) — Must Have, Sprint 1. employees + positions + supervisors; user↔employee; personnel API + ABAC.
- Platform/duty master (doc 22): `organization_units` (§2), `duty_numbering_sequences` (§3, atomic auto-increment per unit), `duty_signatories` (§4), `satusehat_holidays` (§6), `duty_transport_modes` (§7). `spm_services` (§5) is already issue #78.

## Rules

- **Seed-first, idempotent.** Master data is seeded at setup; re-running the seed must not duplicate (upsert by natural key / `INSERT ... ON CONFLICT`).
- **Reference validation:** agenda/ST reference region/faskes/employee by id — validate existence in the service layer (no runtime FK). Snapshot personnel into documents (doc 23 §3) so later edits don't change historical ST.
- **Numbering must be atomic + audit-safe** (doc 22 §3.3): allocate the next number in a transaction; never reuse.
- **ABAC foundation:** `unit_id`/`faskes_id` come from org units + faskes; personnel ABAC per doc 23 §8.
- MVP = manual input + seed; **SIMPEG/SIPD sync is Phase 2** (doc 23 §5.3) — keep clean extension points, don't build sync now.

## Checklist
- [ ] Tables + prefixes per doc 21/22/23 · [ ] idempotent seed (no dup) · [ ] API + RBAC/ABAC · [ ] numbering atomic · [ ] snapshot for documents · [ ] no Phase-2 sync in MVP.
