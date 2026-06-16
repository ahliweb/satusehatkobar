---
name: sskobar-ui-admin
description: Build Satu Sehat Kobar admin UI (React in a Native plugin's admin.tsx) following PRD §9 — Kumo semantic tokens, dark+light, mobile-first, accessible, nested sidebar per plugin. Use for any SSK UI/UX issue or the UI slice of a feature.
---

# SSK Admin UI

Authoritative: PRD `§9` (Kebutuhan UI/UX) + `docs/sikesra-ui-redesign-plan.md` (admin patterns) + `docs/nested-navigation-public-and-plugin-header.md` (navigation). Reference implementation: `awcms-micro-sikesra/src/admin.tsx`.

## Hard rules

- **Kumo semantic tokens only** for color/spacing. Never hardcode light-only colors — dark and light must both stay readable.
- **Mobile-first**: usable at 375px; verify 375 / 768 / 1280. Primary action ≤ 3 clicks.
- **Accessibility**: contrast ≥ 4.5:1, keyboard navigable, screen-reader friendly, visible focus.
- **Feedback states**: every async surface has loading / empty / error / success (toast or inline).
- **Navigation**: each plugin's admin menu is its own collapsible group, at the top below Dashboard (AGENTS root policy). Badge counts where the nav tree (PRD §9.2) shows them (e.g. Persetujuan pending count).
- **Language**: UI labels default `en` with complete `id` translations; user-facing errors in Bahasa Indonesia.

## Per-module UI cues (PRD §9.3)

- Agenda: create/edit form, monthly calendar, SPM filter.
- ST/SPPD: 4-step wizard (vertical stepper), participant table, budget table, real-time per-step validation.
- Persetujuan: visual approval timeline, contextual action buttons, nav badge.
- Dokumen: inline PDF preview, generate/download/upload, upload progress bar.
- Bukti: multi-file drag-drop, photo preview, per-file classification checklist.
- Dashboard: KPI cards, SPM chart, pending list.
- Arsip: full-text search, date/type filters, download.

## Checklist

- [ ] No hardcoded colors; Kumo tokens only; dark + light verified.
- [ ] Responsive at 375/768/1280; keyboard + screen-reader pass.
- [ ] Loading/empty/error/success states present.
- [ ] Sidebar group correct; badges where specified.
- [ ] UI-only change (no API/business-logic) unless the issue says otherwise.

## Ease of development

Build shared primitives (cards, tables, status badges, toasts, wizard stepper, form groups) once in a shared UI module and reuse across plugins, so each feature's UI slice stays small and consistent.
