#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
FIXTURE_PARENT="${TMPDIR:-/tmp}"
FIXTURE_PARENT="${FIXTURE_PARENT%/}"
FIXTURE_ROOT="$(mktemp -d "$FIXTURE_PARENT/rinshari-eye-bootstrap-test.XXXXXX")"

cleanup() {
  case "$FIXTURE_ROOT" in
    "$FIXTURE_PARENT"/rinshari-eye-bootstrap-test.*)
      rm -rf -- "$FIXTURE_ROOT"
      ;;
    *)
      echo "Refusing to remove unexpected fixture path: $FIXTURE_ROOT" >&2
      ;;
  esac
}
trap cleanup EXIT

check_body() {
  local body="$1"
  local heading
  local headings=(
    "Design preflight completed"
    "Applied principles"
    "Site Soul alignment"
    "Animation audit summary"
    "Reference and reuse decision"
    "CSS craft and behavior summary"
    "Whimsy & motion quality bar"
    "Accessibility parity for motion"
    "Onboarding impact score (0-5)"
    "Onboarding update decision"
    "Feature onboarding manifest change"
    "AI usage declaration"
    "AI intent and value"
    "AI data handling"
    "AI validation and fallback"
    "Engineering baseline compliance"
    "Engineering baseline rationale"
  )

  for heading in "${headings[@]}"; do
    printf '%s\n' "$body" | grep -Fq "## $heading" || {
      echo "Generated PR body is missing heading: $heading" >&2
      return 1
    }
  done

  printf '%s\n' "$body" | grep -Eq '^- \[[xX]\] Yes$'
  printf '%s\n' "$body" | grep -Eq '^- Outcome/gap: .+'
  printf '%s\n' "$body" | grep -Eq '^- Local foundation: .+'
  printf '%s\n' "$body" | grep -Eq '^- Sources inspected: .+'
  printf '%s\n' "$body" | grep -Eqi '^- Candidate decisions:.*(keep|adapt|build|reject)'
  printf '%s\n' "$body" | grep -Eq '^- Provenance and risk gates: .+'
  printf '%s\n' "$body" | grep -Eq '^- Major regions and user jobs: .+'
  printf '%s\n' "$body" | grep -Eq '^- Content/focus order and layout ownership: .+'
  printf '%s\n' "$body" | grep -Eq '^- Intrinsic and responsive constraints: .+'
  printf '%s\n' "$body" | grep -Eq '^- Typography and media behavior: .+'
  printf '%s\n' "$body" | grep -Eq '^- Integrated proof matrix: .+'
  printf '%s\n' "$body" | grep -Eq '^- [0-5]$'
  printf '%s\n' "$body" | grep -Eq '^- (none|copy-only|mini-tour)$'
  printf '%s\n' "$body" | grep -Eq '^- \[[xX]\] (No AI used|AI used)$'
  printf '%s\n' "$body" | grep -Fq -- '- [x] No implementation-language change'
}

gh() {
  if [[ "$1" == "repo" && "$2" == "view" ]]; then
    printf '%s\n' main
    return 0
  fi

  if [[ "$1" == "pr" && "$2" == "create" ]]; then
    local body=""
    while (( $# )); do
      if [[ "$1" == "--body" ]]; then
        shift
        body="$1"
      fi
      shift
    done
    check_body "$body"
    return 0
  fi

  return 1
}
export -f check_body gh

remote_path="$FIXTURE_ROOT/remote.git"
repo_path="$FIXTURE_ROOT/repo"

git init --bare --initial-branch=main "$remote_path" >/dev/null
git clone "$remote_path" "$repo_path" >/dev/null 2>&1
git -C "$repo_path" switch -c main >/dev/null
git -C "$repo_path" config user.name "Rinshari Eye Test"
git -C "$repo_path" config user.email "rinshari-eye-test@example.invalid"
git -C "$repo_path" commit --allow-empty -m "test: initialize downstream fixture" >/dev/null
git -C "$repo_path" push -u origin main >/dev/null

GIT_ALLOW_PROTOCOL=file "$SCRIPT_DIR/bootstrap-downstream.sh" \
  --guide-url "$ROOT_DIR" \
  --repos "$repo_path" \
  --owner VontaJamal \
  --create-pr true

[[ -z "$(git -C "$repo_path" status --porcelain=v1)" ]]
git -C "$repo_path" diff --check origin/main...HEAD

for managed_file in \
  "$repo_path/AGENTS.md" \
  "$repo_path/.github/PULL_REQUEST_TEMPLATE.md"; do
  if grep -nE '[[:blank:]]+$' "$managed_file"; then
    echo "Generated managed file contains trailing whitespace: $managed_file" >&2
    exit 1
  fi
done

grep -Fq -- '- [ ] No implementation-language change' \
  "$repo_path/.github/PULL_REQUEST_TEMPLATE.md"

expected_guide_commit="$(git -C "$ROOT_DIR" rev-parse HEAD)"
actual_guide_commit="$(git -C "$repo_path/design/rinshari-eye" rev-parse HEAD)"
[[ "$actual_guide_commit" == "$expected_guide_commit" ]]

scheduled_body="$(
  awk '
    /^          body: \|/ { capture=1; next }
    capture && /^          labels: \|/ { capture=0 }
    capture { sub(/^            /, ""); print }
  ' "$repo_path/.github/workflows/update-rinshari-eye-submodule.yml"
)"
check_body "$scheduled_body"

if check_body $'## Design preflight completed\n- [x] Yes' 2>/dev/null; then
  echo "Incomplete PR body unexpectedly passed validation" >&2
  exit 1
fi

echo "Downstream bootstrap regression test passed"
