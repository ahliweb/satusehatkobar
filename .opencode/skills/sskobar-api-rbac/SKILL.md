---
name: sskobar-api-rbac
description: Implement Satu Sehat Kobar API routes with the standard response envelope, the auth→RBAC→ABAC→validation→service→audit order, and mandatory audit events. Use when an SSK issue adds or changes an endpoint, permission, or access rule.
---

# SSK API + RBAC/ABAC + Audit

Authoritative contract: `docs/prd/05.API Service Contract...` and `docs/prd/10.Security and Privacy Checklist`. This skill is the executable summary.

## Handler order (every endpoint)

`auth middleware → RBAC check → ABAC scope → input validation → service call → audit write → response envelope`

Handlers are **thin** — no business logic. Put logic, RBAC/ABAC enforcement, and audit writes in the service layer.

## Response envelope

```jsonc
// single:  { "data": { ... }, "meta": { "request_id": "...", "timestamp": "..." } }
// list:    { "data": [ ... ], "pagination": { "page", "per_page", "total", "total_pages" }, "meta": {...} }
// error:   { "error": { "code": "VALIDATION_ERROR|FORBIDDEN|CONFLICT|NOT_FOUND|WORKFLOW_ERROR", "message": "<Bahasa Indonesia>", "details": { "field": ["..."] } }, "meta": {...} }
```

- Error `message` is always in **Bahasa Indonesia**.
- Timeouts: 30s default, 120s for PDF generation.

## RBAC / ABAC

- **RBAC** (17 roles) decides whether an action is allowed — check the permission slug.
- **ABAC** decides data scope by attributes: `unit_id`, `faskes_id`, owner, subordinate, and finance scope (`dinas_all` vs `faskes_own`, DEC-011).
- Enforce in the **service layer**, never UI-only. Hiding a button is not access control.
- A denied access that matters is itself an audit/security event.

## Audit

- Every mutation writes to `satusehat_audit_logs` with at least `user_id`, `action`, `entity_type`, `entity_id`, `timestamp` (doc 04 P5).
- Approvals, uploads, logins, exports, downloads, and admin actions are auditable events.

## Files (typical)

`routes/<x>.ts` (thin) · `services/<x>.ts` (logic + RBAC/ABAC + audit) · `schemas/<x>.ts` (validation) · `permissions.ts` · `audit.ts`.

## Checklist

- [ ] Envelope correct (data/pagination/meta or error).
- [ ] Order: auth → RBAC → ABAC → validation → service → audit → response.
- [ ] RBAC permission + ABAC scope enforced in service.
- [ ] Mutation writes an audit event; denials logged where relevant.
- [ ] Error messages in Bahasa Indonesia; file endpoints use signed URL/proxy (binding `MEDIA`), never raw R2 keys.
