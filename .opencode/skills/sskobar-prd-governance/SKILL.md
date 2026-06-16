---
name: sskobar-prd-governance
description: Use when updating `docs/prd`, adding or revising Mermaid diagrams, synchronizing AI-ready issue docs/templates, or aligning `README.md`, `AGENTS.md`, and root docs with the latest active Satu Sehat Kobar PRD package and MVP scope.
---

# SSK PRD Governance

Use this skill when the task is documentation governance rather than product-code implementation.

## Primary Sources

Read these first unless the task is explicitly narrower:

1. `docs/prd/20.Master Document Index and Implementation Guide.docx.md`
2. `docs/prd/24.TECHNICAL_IMPLEMENTATION_REFERENCES.md`
3. `docs/prd/25.AI_READY_ISSUE_PLAYBOOK_AND_INDEX.md`
4. `README.md`
5. `AGENTS.md`

## PRD Package Rules

- Treat `docs/prd/` as one package. Keep counts accurate: **26 Markdown documents = 1 PRD induk + 25 supporting docs**.
- Every active PRD document should contain at least one **useful** Mermaid diagram. Add diagrams only when they improve navigation, dependency understanding, workflow clarity, or implementation safety.
- Do not add decorative diagrams. Prefer `flowchart`, `sequenceDiagram`, `erDiagram`, `gantt`, `timeline`, or `quadrantChart` only when they match the document's purpose.
- When a document already has a correct diagram, prefer a minimal update over replacing it.

## AI-Ready Issue Rules

- Keep GitHub issues self-contained for a junior AI model with limited tokens.
- Reference pinned issue `#11` for shared invariants when relevant.
- Cite only 1–2 doc sections plus 1 skill in each issue.
- Keep issue scope atomic: one cohesive unit, usually 1–3 days of work.
- Sync `docs/prd/08.*`, `docs/prd/25.*`, and `.github/ISSUE_TEMPLATE/*.md` when the issue-writing standard changes.

## Root Sync Checklist

When PRD governance changes, verify whether these files also need updates:

- `README.md`
- `AGENTS.md`
- `docs/README.md`
- `docs/repository-structure.md`
- `docs/implementation-instructions.md`

Update root references when any of these change:

- PRD package size or entry points
- skill inventory under `.opencode/skills/`
- MVP issue coverage or execution order
- document authority or reading order

## Archive Rule

- If a document is no longer authoritative but still needed for history, move it into an archive location with a short note that it is historical and no longer the primary reference.
- Do not keep two active documents that define the same rule without stating which one wins.

## Scope Guardrails

- Keep recommendations inside MVP scope unless the task explicitly asks for post-MVP planning.
- Do not pull Phase 2 integrations into active MVP instructions.
- Prefer changes that reduce ambiguity for future implementation, review, maintenance, and integration.

## Verification

- Re-check Mermaid coverage with a content search before finishing.
- Re-check root references to doc counts, skills, and issue ranges.
- If you change any skill under `.opencode/skills/`, remind the user to restart OpenCode so the updated skill is loaded in future sessions.
