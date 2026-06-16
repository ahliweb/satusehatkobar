---
name: sskobar-evidence-journal
description: Implement Satu Sehat Kobar evidence upload + verification and the auto-filled bidirectional journal. Use for EPIC-06 and EPIC-07 issues (duty-travel domain).
---

# SSK Evidence & Journal

Domain of plugin `duty-travel`. Builds on `sskobar-data-d1` + `sskobar-api-rbac`. Authoritative: `docs/prd/04`, `docs/prd/05`, `docs/prd/10`, `docs/prd/12` (DEC-012/013), `docs/prd/17` (PII).

## Evidence (EPIC-06)

- `duty_evidence` (`...participant_user_id, evidence_type, file_url, file_hash, classification, status, verified_by, verified_at, notes`). Enums: `evidence_type` (laporan_tugas|foto_kegiatan|daftar_hadir|tiket|kwitansi|lainnya), `classification` (public|internal|confidential).
- **All participants** in `duty_request_participants` may upload their own evidence (DEC-012). `POST /duty-requests/:id/evidence` multipart → R2, compute SHA-256, notify verifier.
- `classification` required. `confidential` ⇒ UI warning; classified files need permission `evidence.view_classified`. PII scan is manual + warning in Phase 1 (AI in Phase 2).
- Verify: `POST /duty-evidence/:id/verify` (→`verified`) / `/return` (→`returned`, notes required), notify participant.
- When the last evidence for an ST is verified and all are `verified`, set `duty_requests.status='evidence_verified'` (audited).

## Journal (EPIC-07, DEC-013)

- `duty_journals` (`...completion_status, summary, evidence_ids_json`). Enum `completion_status`: pending|completed|returned.
- Auto-create/update on evidence verification; `completed` when all of the user's evidence is verified; `evidence_ids_json` lists related evidence.
- **Bidirectional:** evidence returned ⇒ journal back to `pending`; re-verified ⇒ `completed`. Every transition audited.
- Export `GET /journals/export?format=csv|xlsx&period=...` (filter unit/period/status). List `GET /journals?...` paginated (default 20, max 100), newest first.

## Checklist
- [ ] All participants can upload own evidence · [ ] classification + PII warning · [ ] verify/return notify · [ ] ST auto-status on full verify · [ ] journal bidirectional + audited · [ ] export/list paginated.
