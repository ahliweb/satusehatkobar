---
name: sskobar-integration-backend
description: Implement Satu Sehat Kobar backend & integration foundations — inter-plugin service contracts (SC-01..11), cross-plugin domain events / cache invalidation, notification channel abstraction, external integration adapter boundary, shared API middleware, observability, and migration ordering. Use for EPIC-14 issues.
---

# SSK Backend & Integration Foundation

Cross-cutting backend layer that keeps plugins decoupled and Phase-2 integrations clean. Builds on `sskobar-api-rbac` + `sskobar-data-d1`. Authoritative: `docs/prd/03` §4 (service contracts), `docs/prd/05` §10 (API), `docs/prd/18` (integration governance), `docs/prd/15` §2 (technical KPI).

## Inter-plugin service contracts (doc 03 §4, rule R3)

- **No undocumented inter-plugin dependency.** A plugin never reads another plugin's tables — it calls a written contract (SC-01..SC-11). Each call enforces permission + ABAC at the boundary.
- Contracts: SC-01 agenda snapshot, SC-02 link ST, SC-03 render template, SC-04 register archive, SC-05 create MMC draft, SC-06 get SPM list, SC-07..11 metrics → dashboard.
- Provide a small **contract registry** so consumers resolve a contract by id; version contracts.

## Cross-plugin events / cache invalidation

- Lightweight domain events decouple triggers (e.g. `duty.final_approved` → invalidate dashboard `ctx.kv` cache #76; `evidence.verified` → journal update). Emit from the owning plugin; subscribers react. No tight coupling.

## Notification channel abstraction (doc 18 §1.2, DEC-016)

- A `NotificationChannel` interface; in-app (#57) is the MVP implementation. WA/email are Phase-2 adapters that plug in without touching business logic.

## External integration boundary (doc 18 §1.1–1.4)

- **Anti-corruption layer:** SSK never touches an external DB; only adapters call external REST. MVP delivers the **adapter interface + outbound-call audit + idempotency + graceful degradation**, plus a no-op/stub adapter. **Do NOT implement Phase-2 externals** (BSrE/SRIKANDI/SIMPEG/SIPD/WA/email).
- Outbound audit fields (§1.4): timestamp, target system, endpoint, status, duration ms, retry attempt — **no sensitive payload**. Use idempotency keys for retried calls.

## API middleware & observability

- Shared response envelope + `request_id` correlation (doc 05 §10.2) across handler→service→audit.
- Structured logging (no sensitive payload) + technical KPI hooks (doc 15 §2): p95 latency, 5xx rate, 403/min/user, storage usage, audit-log-gap detection, alert thresholds.

## Migration/seed ordering

- Plugin migrations/seeds are idempotent and run in dependency order (org_units → personnel → region/faskes → agenda → duty → …). Safe on first request after deploy.

## Checklist
- [ ] No cross-plugin table reads — only contracts · [ ] events decouple triggers · [ ] notification abstraction (in-app now, channels later) · [ ] adapter boundary + outbound audit + idempotency (no Phase-2 impl) · [ ] request_id correlation + KPI hooks · [ ] idempotent ordered migrations.
