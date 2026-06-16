---
name: Docs / Governance (AI-ready work packet)
about: Self-contained documentation or governance issue executable by a junior AI model with a limited token budget.
title: "[DOCS] <short title> — <area>"
labels: ["docs", "ai-ready"]
---

## 1. Context Capsule (invariants — do not re-derive)

- `docs/prd/` is one active package: **26 Markdown documents** = 1 PRD induk + 25 supporting docs.
- `docs/prd/20.*` is the entry point, `docs/prd/24.*` is the technical bridge, and `docs/prd/25.*` is the AI-ready issue playbook.
- Every active PRD doc should contain at least one **useful** Mermaid diagram; do not add decorative diagrams.
- Root references that often need sync: `README.md`, `AGENTS.md`, `docs/README.md`, `docs/repository-structure.md`, `docs/implementation-instructions.md`.
- If a document is no longer authoritative but still needed for history, move it to an archive location and mark it as historical.
- Skill to load: `.opencode/skills/sskobar-prd-governance/SKILL.md`.

> **Token budget:** read ONLY the files cited below. Do not scan unrelated PRD files.

## 2. Goal

**Area**: `<prd|root-docs|issue-template|archive>` · **Sprint/Milestone**: `<if applicable>`

## 3. Authoritative references (read only these)

- Doc: `<path>` §X — `<topic>`
- Skill: `.opencode/skills/sskobar-prd-governance/SKILL.md`

## 4. Scope — exact changes

- [ ] Files to update: `<path1>`, `<path2>`
- [ ] Mermaid update/addition: `<diagram type + purpose>`
- [ ] Root-doc sync required: yes/no
- [ ] Archive move required: yes/no

## 5. Acceptance Criteria (testable)

- [ ] AC-1 Referensi dokumen tetap konsisten dan tidak saling bertentangan
- [ ] AC-2 Diagram Mermaid membantu navigasi, alur, dependency, atau implementasi
- [ ] AC-3 Jumlah dokumen, entry point, skill, dan issue/template references sudah sinkron

## 6. Definition of Done

- [ ] Semua file target diperbarui
- [ ] Search coverage Mermaid / referensi terkait sudah diverifikasi
- [ ] Tidak ada instruksi aktif yang duplikat atau bertentangan
- [ ] Jika skill lokal diubah, catat bahwa OpenCode perlu di-restart
