---
name: dotfiles-consistency
description: Orchestrate a cross-tool consistency review + fix workflow for this dotfiles repo. Fans out three reviewers (theme, keybindings, bootstrap/repro) in parallel over tmux, zsh, neovim, lazygit, lazydocker, yazi, btop, hyprland, then synthesizes one prioritized report and routes fixes to quark. Triggers on: make my dotfiles consistent, improve tmux and cli consistency, dotfiles consistency, theme consistency across tools, keybinding consistency, audit my configs for consistency, are my configs consistent, re-run the consistency check, update the consistency review, consistency review again, recheck dotfiles consistency, fix the consistency findings. NOT for recommending a single neovim plugin (use polaron), implementing one specific edit from a known spec (use quark/implement directly), or a security review (use security-review).
---

# Dotfiles Consistency Orchestrator

Coordinates the consistency harness for this repo. The analysis methodology lives in the global **`dotfiles-audit`** skill — this orchestrator does NOT re-implement it; it parallelizes it across three focused reviewers and synthesizes their output.

## Team (sub-agent fan-out / fan-in)

Three independent read-only reviewers, run **in parallel** (one Agent call each, in a single message). They don't talk to each other — each owns one dimension and returns distilled findings. Fixes are routed afterward to `quark`.

| Agent | Dimension | model |
|-------|-----------|-------|
| `theme-reviewer` | Catppuccin frappe flavor uniformity, hardcoded colors, theme presence per tool | opus |
| `keybind-reviewer` | Colemak `hnei` navigation + common-action parity across tools | opus |
| `repro-reviewer` | stow coverage, submodules, lockfiles, prerequisites, hygiene | opus |

Why sub-agents and not a team: the three dimensions are independent, so there's no cross-talk to coordinate — fan-out/fan-in is lighter and finishes at the speed of the slowest reviewer.

## Workflow

### Phase 0 — context check
- If `_workspace/consistency/` holds prior reports AND the user asks for a partial recheck → re-run only the relevant reviewer(s).
- If it exists and the user wants a fresh full pass → move it to `_workspace/consistency_prev/` and re-run all three.
- If it doesn't exist → initial run.

### Phase 1 — fan out (parallel)
Spawn all three reviewers in ONE message (concurrent). Each Agent call MUST pass `model: "opus"`. Give each the repo root (`/Users/anhhong/project/dotfiles`) and the tool list. Each reviewer loads `dotfiles-audit` itself (declared in its frontmatter) — do not inject skill instructions.

Write each reviewer's raw output to `_workspace/consistency/0{1,2,3}_{agent}_findings.md` for audit trail.

### Phase 2 — fan in (synthesize)
In the main session, merge the three reports into ONE prioritized list:
- Group by severity (HIGH → MED → LOW), not by tool.
- Dedup overlapping findings (a tool can show up in multiple dimensions).
- Preserve each finding's `file:line` + concrete fix.
- Surface conflicts (e.g. a binding that can't satisfy hnei in a given tool) with both sides, don't silently drop.

Output the synthesized report to the user. Save it to `_workspace/consistency/00_report.md`.

### Phase 3 — fix (opt-in)
Do NOT auto-edit. Present the fix plan and ask which findings to apply. For approved fixes, route to `quark` (via `/implement`) with the concrete edit instructions the reviewers produced. After edits, offer to re-run the affected reviewer to confirm the drift is gone.

## Data flow
- **Return value** — each reviewer's findings come back to the main session.
- **File based** — raw reports + synthesized report under `_workspace/consistency/` (audit trail; gitignored or cleaned, not committed).
- **Hand-off** — synthesized fix plan → `quark` for edits.

## Error handling
- A reviewer that fails once: retry once. If it fails again, continue and note the missing dimension explicitly in the synthesized report (never silently skip).
- Conflicting findings across reviewers: keep both, attribute each to its source, let the user decide.

## Test scenarios
- **Normal:** "make my dotfiles consistent" → 3 reviewers fan out → one prioritized report → user picks fixes → quark applies → re-run confirms.
- **Partial recheck:** "recheck just the theme consistency" → only `theme-reviewer` runs, prior keybind/repro reports reused from `_workspace/consistency/`.
- **Error:** `repro-reviewer` fails twice → report ships with theme + keybind findings and a clear "bootstrap dimension not reviewed this run" note.
