#!/usr/bin/env bash
# Validate this Team Pack and make it the active TeamNest team.
# TeamNest Core is found in this order: $1, $TEAMNEST_CORE_DIR,
# a sibling ../TeamNest checkout, then a `teamnest` command on PATH.
set -euo pipefail
PACK_DIR=$(cd "$(dirname "$0")" && pwd)
CLI=""
for dir in "${1:-}" "${TEAMNEST_CORE_DIR:-}" "$PACK_DIR/../TeamNest"; do
  if [ -n "$dir" ] && [ -f "$dir/bin/teamnest.mjs" ]; then CLI="$dir/bin/teamnest.mjs"; break; fi
done
core() { if [ -n "$CLI" ]; then node "$CLI" "$@"; else teamnest "$@"; fi; }
if [ -z "$CLI" ] && ! command -v teamnest >/dev/null; then
  echo "TeamNest Core was not found. Clone it next to this pack (../TeamNest), set TEAMNEST_CORE_DIR, or pass its path." >&2
  exit 1
fi
core validate-pack "$PACK_DIR"
core apply-pack "$PACK_DIR"
echo "Applied the Team Pack. Restart Herdr if TeamNest was already running."
