---
name: UI/UX (AI-ready work packet)
about: Self-contained UI/UX or design-system issue executable by a junior AI model.
title: "[UI] <short title> — <area>"
labels: ["feat", "ui-ux", "ai-ready"]
---

## 1. Context Capsule (invariants — do not re-derive)

- Admin UI lives in each Native plugin's `admin.tsx` (React). Shared shell/tokens live in the `awcms-sskobar-cloudflare` template + a shared UI module.
- **Kumo semantic tokens** for all colors/spacing — never hardcode light-only values; dark + light must both stay readable.
- **Mobile-first** (usable at 375px), max 3 clicks for a primary action, visible loading/success/error states, contrast ≥ 4.5:1, keyboard navigable, screen-reader friendly. (PRD §9.1)
- Each plugin's admin menu is its own collapsible group, placed at the top below Dashboard (AGENTS root policy).
- Full invariants: pinned issue **#11** (`[CAPSULE]`) and `docs/prd/24` §4. Skill: `awcmsmicro-dev/skills/building-emdash-site`.

> **Token budget:** read ONLY PRD `§9` (UI/UX) + the section cited in §3. Do NOT open other PRD files.

## 2. Goal

<!-- One sentence. Backlog/area: EPIC-00-NNN (UI/UX foundation) or a feature's UI slice -->

**Area**: `<area>` · **Sprint/Milestone**: Sprint N

## 3. Authoritative references (read only these)

- PRD `§9` — Kebutuhan UI/UX (navigation tree, per-module UI, principles)
- `docs/nested-navigation-public-and-plugin-header.md` (navigation) / `docs/sikesra-ui-redesign-plan.md` (admin UI patterns)

## 4. Scope — exact changes

- [ ] Component/page `<name>` in `<path>`
- [ ] States: loading / empty / error / success
- [ ] Responsive at 375px / 768px / 1280px
- [ ] Tokens: Kumo only (list the tokens used)

## 5. Acceptance Criteria (testable)

- [ ] AC-1 renders correctly in dark + light
- [ ] AC-2 keyboard + screen-reader pass
- [ ] AC-3 responsive at 375px

## 6. Definition of Done

- [ ] No hardcoded colors; Kumo tokens only
- [ ] Dark + light verified; contrast ≥ 4.5:1
- [ ] Component test / story added; lint + typecheck pass
- [ ] No API/business-logic change (UI-only) unless explicitly stated
