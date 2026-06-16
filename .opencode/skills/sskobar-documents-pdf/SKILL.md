---
name: sskobar-documents-pdf
description: Implement Satu Sehat Kobar document/template/PDF and archive features — template versioning snapshot, PDF generation after final approval, signed-document upload with SHA-256, hash verification, and immutable archive. Use for EPIC-05 and EPIC-09 issues.
---

# SSK Documents, PDF & Archive

Plugins `document-template` (EPIC-05) and `document-archive` (EPIC-09). Builds on `sskobar-data-d1` + `sskobar-api-rbac`. Authoritative: `docs/prd/04`, `docs/prd/05`, `docs/prd/10`, `docs/prd/12` (DEC-009/017).

## Template & versioning (DEC-009)

- `document_templates` (`version, content_html, is_active, …`). One active template per `document_type` at a time. No hard delete — all versions kept.
- On generate, **snapshot** the active template into `document_generated` so later template edits never alter existing documents.

## PDF generation

- Trigger when `duty_requests.status='final_approved'`. Build PDF from the snapshotted template. Store in R2 (`MEDIA`) under a structured path. Expose `GET /duty-requests/:id/document`. Generation timeout budget 120s.

## Signed document + hash

- `POST /duty-requests/:id/signed-document` uploads the signed PDF to R2 under `signed/`. Compute + store SHA-256.
- `GET /duty-requests/:id/verify-document` recomputes the R2 file hash and compares: `{verified, hash_stored, hash_computed}`. Result audited.

## Archive (immutable, DEC-017)

- `document_archives` (`...file_url, file_hash, classification, status, archived_at`). Auto-create `status='active'` when a signed document upload succeeds. **Immutable** after created — no edit/delete.
- Download via short-TTL (≤1h) signed R2 URL; every download writes an audit event; unauthorized ⇒ 403. Search/filter by ST no./unit/period, paginated.

## Files & security

Never expose raw R2 keys — use signed URL/proxy. Validate uploads (type, size, magic bytes). Store only metadata/hash/classification/owner/status in D1.

## Checklist
- [ ] Template snapshot on generate · [ ] PDF on final_approved → R2 · [ ] SHA-256 stored + verify endpoint · [ ] archive immutable · [ ] downloads audited + signed URL.
