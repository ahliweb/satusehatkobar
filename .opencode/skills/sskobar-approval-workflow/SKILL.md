---
name: sskobar-approval-workflow
description: Implement the Satu Sehat Kobar duty-travel approval engine — DB-configured multi-step chain, finance auto-skip, finance ABAC scope, in-app notifications, return/reject, and the approver queue. Use for EPIC-04 issues.
---

# SSK Approval Workflow

Plugin `duty-travel`. Builds on `sskobar-api-rbac` + `sskobar-data-d1`. Authoritative: `docs/prd/05`, `docs/prd/10`, decisions `docs/prd/12` (DEC-005/006/011/015/016).

## Engine

- Chain is **DB-configured** in `duty_approval_step_config` (per `org_level`), never hardcoded (DEC-005). The engine reads it to pick the next step.
- Each step records to `duty_approval_history`. Actions: `approve`, `return`, `reject`.
- **Finance skip (DEC-006):** if `is_budgeted = false`, the finance step is auto-set `status='skipped'`, `skip_reason='not_budgeted'`, no finance notification, flow continues.
- **Cross-faskes (DEC-015):** the chain `org_level` comes from the primary participant's `primary_health_facility_id` on `duty_requests`.

## Finance ABAC (DEC-011)

- Finance role attribute `scope`: `dinas_all` (sees all ST) vs `faskes_own` (only own unit/faskes). Filter queries by scope; cross-unit access ⇒ 403. Enforce in the service.

## Notifications (DEC-016, in-app only Phase 1)

- Table `satusehat_notifications` (`id,user_id,type,payload_json,read_at,created_at`). Create on step entry. `GET /notifications` (unread), `PATCH /notifications/:id/read`.

## Transitions

- `return` requires `return_notes` → ST back to `draft` + `returned` flag, notify requester, allow resubmit.
- `reject` (top approver) requires `reject_reason` → terminal `rejected`, notify requester + prior approvers.
- Approver queue: `GET /duty-requests?pending_my_approval=true` with unit/date/priority filters and list-view actions.

## Checklist
- [ ] Steps from config, not hardcoded · [ ] history recorded · [ ] finance skip + ABAC scope correct · [ ] every transition audited + notified · [ ] envelope + Bahasa Indonesia errors.
