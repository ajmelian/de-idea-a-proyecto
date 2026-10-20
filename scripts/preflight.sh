#!/usr/bin/env bash
# Read-only preflight for OpenCode v2 and OpenSpec repositories.
# Usage: bash preflight.sh "/absolute/path/with spaces"
set -eu

if [ "${1:-}" = "--help" ]; then
  printf 'Usage: bash preflight.sh [project-directory]\n'
  exit 0
fi

root="${1:-.}"
if [ ! -d "$root" ]; then
  printf 'ERROR: directory does not exist: %s\n' "$root" >&2
  exit 2
fi
cd -- "$root"

printf 'Project: %s\n' "$PWD"
printf '%s\n' '--- Local configuration ---'
for file in AGENTS.md opencode.json opencode.jsonc openspec/config.yaml composer.json pom.xml build.gradle build.gradle.kts; do
  if [ -f "$file" ]; then printf 'FOUND %s\n' "$file"; fi
done
for directory in openspec/changes openspec/specs .opencode/skills .opencode/agents; do
  if [ -d "$directory" ]; then printf 'FOUND %s/\n' "$directory"; fi
done

printf '%s\n' '--- Installed commands ---'
if command -v opencode >/dev/null 2>&1; then
  printf 'opencode: '
  opencode --version 2>&1 || printf '%s\n' 'version unavailable'
else
  printf '%s\n' 'opencode: NOT FOUND in PATH'
fi
if command -v openspec >/dev/null 2>&1; then
  printf 'openspec: '
  openspec --version 2>&1 || printf '%s\n' 'version unavailable'
  if [ -d openspec ]; then
    printf '%s\n' '--- OpenSpec changes (read-only) ---'
    openspec list 2>&1 || printf '%s\n' 'OpenSpec list unavailable'
  fi
else
  printf '%s\n' 'openspec: NOT FOUND in PATH'
fi

printf '%s\n' '--- Git (read-only) ---'
if command -v git >/dev/null 2>&1 && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git status --short 2>&1 || printf '%s\n' 'git status unavailable'
else
  printf '%s\n' 'No Git worktree detected'
fi
printf '%s\n' 'Preflight completed; no project files were intentionally modified.'
