---
name: sskobar-data-d1
description: Persist Satu Sehat Kobar plugin data directly in Cloudflare D1 via ctx.db (Kysely), with a plugin-owned idempotent migration module. Use when an SSK issue creates/changes tables, writes queries, or sets up a plugin's schema. Implements DEC-019.
---

# SSK Data on D1 (direct, via `ctx.db`)

Default persistence for every SSK plugin (DEC-019). `docs/prd/04.DATABASE_MVP_SCHEMA.docx.md` is the **physical** schema. EmDash has no plugin migration runner, so each plugin owns its migrations.

## Rules

- Access D1 through `ctx.db` (Kysely `Kysely<Database>`). Always parameter-bind; never string-concat SQL.
- Table/index names use the plugin prefix from doc 04: `agenda_*`, `duty_*`, `document_*`, `satusehat_*`, etc.
- Conventions (doc 04 §1.2): PK `id TEXT` = `lower(hex(randomblob(8)))`; timestamps `TEXT NOT NULL DEFAULT (datetime('now'))`; enums via `CHECK (col IN (...))`; booleans `INTEGER 0/1`; JSON as `TEXT`. **No FK constraints** — enforce relations in the service layer.
- Soft delete via `deleted_at TEXT NULL`. Snapshot data from other plugins (e.g. `agenda_snapshot`) — never read another plugin's tables directly.
- `ctx.kv` is for cache only (e.g. dashboard metrics, TTL 15 min) — not a domain store.

## Idempotent migration module

Each plugin has a `migrations` module run in the `install`/`activate` lifecycle hooks. It must be safe to re-run (first request after deploy may trigger it). Track applied steps in `<prefix>_migrations`.

```ts
// e.g. duty: ensure schema, idempotent
export async function runDutyMigrations(db /* Kysely<Database> */) {
  await db.schema.createTable("duty_migrations").ifNotExists()
    .addColumn("step", "text", c => c.primaryKey())
    .addColumn("applied_at", "text", c => c.notNull().defaultTo(sql`(datetime('now'))`))
    .execute();
  await step(db, "001_duty_requests", async () => {
    await db.schema.createTable("duty_requests").ifNotExists()
      /* columns per doc 04 */ .execute();
    await db.schema.createIndex("duty_requests_status_idx").ifNotExists()
      .on("duty_requests").column("status").execute();
  });
}
// step(): skip if already in duty_migrations, else run + record. Keep each step idempotent on its own.
```

## Checklist

- [ ] Tables + indexes match doc 04 (names, columns, prefixes).
- [ ] Migration is idempotent and recorded in `<prefix>_migrations`.
- [ ] Queries parameter-bound; no cross-plugin table access.
- [ ] Soft delete + snapshot where doc 04 requires it.
- [ ] Indexes only for dashboard/workflow/ABAC lookups (doc 04 P10), not every column.

## Why direct D1 (ease of dev + integration)

Explicit relational tables = standard SQL/Kysely, real joins/indexes, and a clean surface for Phase-2 integrations (SIMPEG, SIPD, BI/reporting) and exports. Keep the schema faithful to doc 04 so external systems can rely on it.
