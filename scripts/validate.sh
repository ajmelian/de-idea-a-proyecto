#!/usr/bin/env bash
# Validate this skill package before committing or releasing.
# Read-only: does not modify the repository.
set -eu

repo_root=$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd)
cd -- "$repo_root"

failures=0

fail() {
  printf 'FAIL: %s\n' "$*" >&2
  failures=$((failures + 1))
}

ok() {
  printf 'ok: %s\n' "$*"
}

printf '%s\n' '--- Package structure ---'
for file in SKILL.md README.md INSTALL.md LICENSE CHANGELOG.md; do
  if [ -s "$file" ]; then ok "$file"; else fail "missing or empty: $file"; fi
done

for directory in references scripts; do
  if [ -d "$directory" ]; then ok "$directory/"; else fail "missing directory: $directory"; fi
done

printf '%s\n' '--- SKILL.md frontmatter ---'
if ! python3 - "$repo_root" <<'PY'
import os
import re
import sys

root = sys.argv[1]
path = os.path.join(root, "SKILL.md")
errors = []

try:
    with open(path, encoding="utf-8") as handle:
        text = handle.read()
except OSError as exc:
    print(f"FAIL: cannot read SKILL.md: {exc}", file=sys.stderr)
    sys.exit(1)

if not text.startswith("---\n"):
    errors.append("SKILL.md must start with a YAML frontmatter block")
    frontmatter = ""
    body = text
else:
    end = text.find("\n---\n", 4)
    if end == -1:
        errors.append("frontmatter is not closed with '---'")
        frontmatter = ""
        body = text
    else:
        frontmatter = text[4:end]
        body = text[end + 5:]

fields = {}
for line in frontmatter.splitlines():
    if not line.strip() or line.lstrip().startswith("#"):
        continue
    if ":" not in line:
        errors.append(f"invalid frontmatter line: {line!r}")
        continue
    key, value = line.split(":", 1)
    fields[key.strip()] = value.strip().strip('"').strip("'")

name = fields.get("name", "")
description = fields.get("description", "")

if not name:
    errors.append("frontmatter field 'name' is required")
elif not re.fullmatch(r"[a-z0-9]+(?:-[a-z0-9]+)*", name):
    errors.append(f"'name' must be lowercase with hyphens only: {name!r}")
elif len(name) > 64:
    errors.append(f"'name' exceeds 64 characters: {len(name)}")

expected_name = os.path.basename(root)
if name and name != expected_name:
    errors.append(f"'name' ({name!r}) does not match directory ({expected_name!r})")

if not description:
    errors.append("frontmatter field 'description' is required")
elif len(description) > 1024:
    errors.append(f"'description' exceeds 1024 characters: {len(description)}")
elif len(description) < 40:
    errors.append(f"'description' is too short to be useful: {len(description)} characters")

if not body.strip():
    errors.append("SKILL.md body is empty")

if errors:
    for error in errors:
        print(f"FAIL: {error}", file=sys.stderr)
    sys.exit(1)

print(f"ok: name={name} description={len(description)} chars")
PY
then
  failures=$((failures + 1))
fi

printf '%s\n' '--- Relative links ---'
if ! python3 - "$repo_root" <<'PY'
import os
import re
import sys

root = sys.argv[1]
pattern = re.compile(r"\[[^\]]*\]\(([^)]+)\)")
errors = []

for current, _, files in os.walk(root):
    if ".git" in current.split(os.sep):
        continue
    for filename in files:
        if not filename.endswith(".md"):
            continue
        path = os.path.join(current, filename)
        with open(path, encoding="utf-8") as handle:
            text = handle.read()
        for target in pattern.findall(text):
            target = target.strip().split("#", 1)[0].split(" ", 1)[0]
            if not target or target.startswith(("http://", "https://", "mailto:", "/")):
                continue
            resolved = os.path.normpath(os.path.join(current, target))
            if not os.path.exists(resolved):
                rel = os.path.relpath(path, root)
                errors.append(f"{rel}: broken relative link -> {target}")

if errors:
    for error in errors:
        print(f"FAIL: {error}", file=sys.stderr)
    sys.exit(1)
print("ok: all relative links resolve")
PY
then
  failures=$((failures + 1))
fi

printf '%s\n' '--- Shell scripts ---'
for script in scripts/*.sh; do
  [ -e "$script" ] || continue
  if [ ! -x "$script" ]; then
    fail "not executable: $script"
  fi
  if bash -n "$script"; then ok "syntax: $script"; else fail "syntax error: $script"; fi
  if command -v shellcheck >/dev/null 2>&1; then
    if shellcheck -S warning "$script"; then ok "shellcheck: $script"; else fail "shellcheck: $script"; fi
  fi
done

printf '%s\n' '--- Forbidden artifacts ---'
for path in logs .env node_modules; do
  if [ -e "$path" ]; then fail "must not be published: $path"; fi
done

if command -v grep >/dev/null 2>&1; then
  if grep -rInE --exclude-dir=.git --exclude=validate.sh \
    'BEGIN (RSA|OPENSSH|EC|PGP) PRIVATE KEY' . >/dev/null 2>&1; then
    fail "possible private key committed"
  else
    ok "no private key material found"
  fi
fi

printf '%s\n' '--- Summary ---'
if [ "$failures" -ne 0 ]; then
  printf 'Validation failed with %s issue(s).\n' "$failures" >&2
  exit 1
fi
printf '%s\n' 'Validation passed.'
