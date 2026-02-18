#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<USAGE
Usage:
  sync-agents-baseline.sh --write
  sync-agents-baseline.sh --check
USAGE
}

mode=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --write) mode="write"; shift ;;
    --check) mode="check"; shift ;;
    -h|--help) usage; exit 0 ;;
    *)
      echo "Unknown argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if [[ -z "$mode" ]]; then
  usage
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DOCTRINE_TEMPLATE="$ROOT_DIR/templates/agents-baseline-doctrine.md"

if [[ ! -f "$DOCTRINE_TEMPLATE" ]]; then
  echo "Missing doctrine template: $DOCTRINE_TEMPLATE" >&2
  exit 1
fi

declare -a REPO_ROOTS=(
  "/Users/vonta/Documents/Code Repos/Agent_Intro"
  "/Users/vonta/Documents/Code Repos/DJWS"
  "/Users/vonta/Documents/Code Repos/NexusCrypto"
  "/Users/vonta/Documents/Code Repos/Nexuslytics"
  "/Users/vonta/Documents/Code Repos/VontaJamal"
  "/Users/vonta/Documents/Code Repos/ck-at"
  "/Users/vonta/Documents/Code Repos/ck-flash"
  "/Users/vonta/Documents/Code Repos/link-tracker"
  "/Users/vonta/Documents/Code Repos/magic-lantern"
  "/Users/vonta/Documents/Code Repos/prediction-claw-culling-games"
  "/Users/vonta/Documents/Code Repos/rinshari-ui"
  "/Users/vonta/Documents/Code Repos/synclink"
  "/Users/vonta/Documents/Code Repos/your-next-watch"
)

START_MARKER="<!-- CORE-DOCTRINE:START -->"
END_MARKER="<!-- CORE-DOCTRINE:END -->"

DOCTRINE_CONTENT="$(cat "$DOCTRINE_TEMPLATE")"
MANAGED_BLOCK="$START_MARKER
$DOCTRINE_CONTENT
$END_MARKER"

upsert_file() {
  local target="$1"

  if [[ ! -f "$target" ]]; then
    cat > "$target" <<NEWFILE
$MANAGED_BLOCK

## Local Repository Overrides
- Add repository-specific constraints, product requirements, and implementation notes below this line.
NEWFILE
    return
  fi

  if grep -q "$START_MARKER" "$target"; then
    awk -v s="$START_MARKER" -v e="$END_MARKER" -v c="$MANAGED_BLOCK" '
      BEGIN { inblock=0 }
      {
        if (index($0, s)) {
          print c
          inblock=1
          next
        }
        if (index($0, e)) {
          inblock=0
          next
        }
        if (!inblock) print
      }
    ' "$target" > "$target.tmp"
    mv "$target.tmp" "$target"
  else
    {
      printf '%s\n\n' "$MANAGED_BLOCK"
      cat "$target"
    } > "$target.tmp"
    mv "$target.tmp" "$target"
  fi
}

check_file() {
  local target="$1"
  local repo_name="$2"

  if [[ ! -f "$target" ]]; then
    echo "[FAIL] $repo_name missing AGENTS.md"
    return 1
  fi

  local marker_count
  marker_count="$(grep -Ec '<!-- CORE-DOCTRINE:(START|END) -->' "$target" | tr -d ' ')"
  if [[ "$marker_count" -ne 2 ]]; then
    echo "[FAIL] $repo_name must contain exactly one CORE-DOCTRINE block"
    return 1
  fi

  local block
  block="$(awk -v s="$START_MARKER" -v e="$END_MARKER" '
    BEGIN { capture=0 }
    {
      if (index($0, s)) { capture=1; print; next }
      if (capture) print
      if (index($0, e)) { exit }
    }
  ' "$target")"

  if [[ "$block" != "$MANAGED_BLOCK" ]]; then
    echo "[FAIL] $repo_name CORE-DOCTRINE block does not match canonical template"
    return 1
  fi

  for required in \
    "Protagonist Commander" \
    "Saint of Aesthetics" \
    "Saint of Security" \
    "Saint of Accessibility" \
    "Saint of Testing" \
    "codex/*" \
    "clean git tree before running verification/testing" \
    "clean git tree before declaring work complete" \
    "behavior-first tests" \
    "hourly/nightly" \
    "weekly/monthly/quarterly"; do
    if ! printf '%s\n' "$block" | grep -Fq "$required"; then
      echo "[FAIL] $repo_name CORE-DOCTRINE block missing: $required"
      return 1
    fi
  done

  echo "[OK] $repo_name"
}

status=0
for repo_root in "${REPO_ROOTS[@]}"; do
  if [[ ! -d "$repo_root/.git" ]]; then
    echo "[SKIP] Not a git repo: $repo_root"
    continue
  fi

  target="$repo_root/AGENTS.md"
  repo_name="$(basename "$repo_root")"

  if [[ "$mode" == "write" ]]; then
    upsert_file "$target"
    echo "[WRITE] $target"
  else
    if ! check_file "$target" "$repo_name"; then
      status=1
    fi
  fi
done

exit "$status"
