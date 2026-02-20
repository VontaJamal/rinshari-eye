#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<USAGE
Usage:
  bootstrap-downstream.sh --guide-url <git-url> --repos <csv-local-paths> --owner <github-owner> --create-pr <true|false>

Example:
  bootstrap-downstream.sh \
    --guide-url https://github.com/VontaJamal/rinshari-eye.git \
    --repos /path/repoA,/path/repoB \
    --owner VontaJamal \
    --create-pr true
USAGE
}

GUIDE_URL=""
REPOS_CSV=""
OWNER=""
CREATE_PR="false"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --guide-url) GUIDE_URL="$2"; shift 2 ;;
    --repos) REPOS_CSV="$2"; shift 2 ;;
    --owner) OWNER="$2"; shift 2 ;;
    --create-pr) CREATE_PR="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown argument: $1" >&2; usage; exit 1 ;;
  esac
done

if [[ -z "$GUIDE_URL" || -z "$REPOS_CSV" || -z "$OWNER" ]]; then
  usage
  exit 1
fi

if ! command -v gh >/dev/null 2>&1; then
  echo "gh CLI is required" >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
PRE_TEMPLATE="$ROOT_DIR/templates/design-preflight.md"
SOUL_TEMPLATE="$ROOT_DIR/templates/site-soul-brief.md"

if [[ ! -f "$PRE_TEMPLATE" || ! -f "$SOUL_TEMPLATE" ]]; then
  echo "Expected templates not found in $ROOT_DIR/templates" >&2
  exit 1
fi

trim() {
  local s="$1"
  s="${s#${s%%[![:space:]]*}}"
  s="${s%${s##*[![:space:]]}}"
  printf '%s' "$s"
}

upsert_managed_block() {
  local file="$1"
  local start_marker="$2"
  local end_marker="$3"
  local content="$4"
  local block_file
  mkdir -p "$(dirname "$file")"
  touch "$file"
  block_file="$(mktemp)"
  printf '%s\n' "$content" > "$block_file"

  if grep -q "$start_marker" "$file"; then
    awk -v s="$start_marker" -v e="$end_marker" -v cfile="$block_file" '
      function print_block(  line) {
        while ((getline line < cfile) > 0) print line
        close(cfile)
      }
      BEGIN { inblock=0 }
      {
        if (index($0, s)) {
          print_block()
          inblock=1
          next
        }
        if (index($0, e)) {
          inblock=0
          next
        }
        if (!inblock) print
      }
    ' "$file" > "$file.tmp" && mv "$file.tmp" "$file"
  else
    if [[ -s "$file" ]]; then
      printf '\n' >> "$file"
      cat "$block_file" >> "$file"
      printf '\n' >> "$file"
    else
      cat "$block_file" > "$file"
      printf '\n' >> "$file"
    fi
  fi

  rm -f "$block_file"
}

IFS=',' read -r -a REPO_PATHS <<< "$REPOS_CSV"

for raw_repo in "${REPO_PATHS[@]}"; do
  repo_path="$(trim "$raw_repo")"
  [[ -z "$repo_path" ]] && continue

  echo "=== Bootstrapping: $repo_path ==="

  if [[ ! -d "$repo_path/.git" ]]; then
    echo "Skipping: not a git repository: $repo_path" >&2
    continue
  fi

  if [[ -n "$(git -C "$repo_path" status --porcelain=v1)" ]]; then
    echo "Skipping dirty repo: $repo_path" >&2
    continue
  fi

  remote_url="$(git -C "$repo_path" remote get-url origin)"
  repo_name="$(basename "${remote_url%.git}")"
  default_branch="$(gh repo view "$OWNER/$repo_name" --json defaultBranchRef --jq '.defaultBranchRef.name')"

  bootstrap_branch="codex/design-guide-bootstrap-${repo_name}"

  git -C "$repo_path" fetch origin "$default_branch"
  git -C "$repo_path" checkout "$default_branch"
  git -C "$repo_path" pull --ff-only origin "$default_branch"
  git -C "$repo_path" checkout -B "$bootstrap_branch"

  if [[ ! -d "$repo_path/design/rinshari-eye" ]]; then
    mkdir -p "$repo_path/design"
    git -C "$repo_path" submodule add "$GUIDE_URL" design/rinshari-eye
  else
    git -C "$repo_path" submodule sync -- design/rinshari-eye || true
    git -C "$repo_path" submodule update --init -- design/rinshari-eye || true
  fi

  if [[ ! -f "$repo_path/docs/site-soul-brief.md" ]]; then
    mkdir -p "$repo_path/docs"
    cp "$SOUL_TEMPLATE" "$repo_path/docs/site-soul-brief.md"
  fi

  AGENTS_BLOCK=$(cat <<'AGENTS'
<!-- rinshari-eye:START -->
## Design Preflight Requirement (Managed)
For any UI/UX change, agents must do all of the following before implementation:
1. Read `design/rinshari-eye/templates/design-preflight.md`.
2. Audit repository animation/motion implementation first and note keep/change decisions.
3. Read relevant files in `design/rinshari-eye/principles/`.
4. Read local `docs/site-soul-brief.md`.
5. In task output/PR, provide:
   - Applied principles
   - Site Soul alignment
   - Animation audit summary
   - AI intent map
<!-- rinshari-eye:END -->
AGENTS
)
  upsert_managed_block "$repo_path/AGENTS.md" "<!-- rinshari-eye:START -->" "<!-- rinshari-eye:END -->" "$AGENTS_BLOCK"

  PR_BLOCK=$(cat <<'PRTMP'
<!-- rinshari-eye:START -->
## Design preflight completed
- [ ] Yes

## Applied principles
- 

## Site Soul alignment
- 

## Animation audit summary
- 

## Whimsy & motion quality bar
- 

## Accessibility parity for motion
- 

## Onboarding impact score (0-5)
- 

## Onboarding update decision
- 

## Feature onboarding manifest change
- featureId:
- version:
- trigger:

## AI usage declaration
- [ ] No AI used
- [ ] AI used

## AI intent and value
- 

## AI data handling
- 

## AI validation and fallback
- 

## Engineering baseline compliance
- [ ] TypeScript strict mode + Zod at boundaries
- [ ] Python exception: Pydantic + Language Exception Record
- [ ] Owner-approved non-TypeScript/non-Python exception + Language Exception Record

## Engineering baseline rationale
- 
<!-- rinshari-eye:END -->
PRTMP
)
  upsert_managed_block "$repo_path/.github/PULL_REQUEST_TEMPLATE.md" "<!-- rinshari-eye:START -->" "<!-- rinshari-eye:END -->" "$PR_BLOCK"

  mkdir -p "$repo_path/.github/workflows"

  cat > "$repo_path/.github/workflows/design-preflight-check.yml" <<'YAML'
name: Design Preflight Check

on:
  pull_request:
    types: [opened, edited, synchronize, reopened]

permissions:
  contents: read
  pull-requests: read

jobs:
  preflight:
    runs-on: ubuntu-latest
    steps:
      - name: Validate PR body design preflight sections
        shell: bash
        run: |
          set -euo pipefail

          body="$(jq -r '.pull_request.body // ""' "$GITHUB_EVENT_PATH")"

          fail() {
            echo "$1" >&2
            exit 1
          }

          [[ -n "$body" ]] || fail "PR body is empty. Fill required design preflight fields."

          printf '%s\n' "$body" | grep -q '^## Design preflight completed' || fail "Missing section: Design preflight completed"
          printf '%s\n' "$body" | grep -q '^## Applied principles' || fail "Missing section: Applied principles"
          printf '%s\n' "$body" | grep -q '^## Site Soul alignment' || fail "Missing section: Site Soul alignment"
          printf '%s\n' "$body" | grep -q '^## Animation audit summary' || fail "Missing section: Animation audit summary"
          printf '%s\n' "$body" | grep -q '^## Whimsy & motion quality bar' || fail "Missing section: Whimsy & motion quality bar"
          printf '%s\n' "$body" | grep -q '^## Accessibility parity for motion' || fail "Missing section: Accessibility parity for motion"
          printf '%s\n' "$body" | grep -q '^## Onboarding impact score (0-5)' || fail "Missing section: Onboarding impact score (0-5)"
          printf '%s\n' "$body" | grep -q '^## Onboarding update decision' || fail "Missing section: Onboarding update decision"
          printf '%s\n' "$body" | grep -q '^## Feature onboarding manifest change' || fail "Missing section: Feature onboarding manifest change"
          printf '%s\n' "$body" | grep -q '^## AI usage declaration' || fail "Missing section: AI usage declaration"
          printf '%s\n' "$body" | grep -q '^## AI intent and value' || fail "Missing section: AI intent and value"
          printf '%s\n' "$body" | grep -q '^## AI data handling' || fail "Missing section: AI data handling"
          printf '%s\n' "$body" | grep -q '^## AI validation and fallback' || fail "Missing section: AI validation and fallback"
          printf '%s\n' "$body" | grep -q '^## Engineering baseline compliance' || fail "Missing section: Engineering baseline compliance"
          printf '%s\n' "$body" | grep -q '^## Engineering baseline rationale' || fail "Missing section: Engineering baseline rationale"

          printf '%s\n' "$body" | grep -Eq '^- \[[xX]\] Yes' || fail "You must check '- [x] Yes' under Design preflight completed"

          applied="$(printf '%s\n' "$body" | awk '/^## Applied principles/{flag=1;next}/^## /{flag=0}flag')"
          soul="$(printf '%s\n' "$body" | awk '/^## Site Soul alignment/{flag=1;next}/^## /{flag=0}flag')"
          animation="$(printf '%s\n' "$body" | awk '/^## Animation audit summary/{flag=1;next}/^## /{flag=0}flag')"
          whimsy="$(printf '%s\n' "$body" | awk '/^## Whimsy & motion quality bar/{flag=1;next}/^## /{flag=0}flag')"
          motion_a11y="$(printf '%s\n' "$body" | awk '/^## Accessibility parity for motion/{flag=1;next}/^## /{flag=0}flag')"
          onboarding_score="$(printf '%s\n' "$body" | awk '/^## Onboarding impact score \(0-5\)/{flag=1;next}/^## /{flag=0}flag')"
          onboarding_decision="$(printf '%s\n' "$body" | awk '/^## Onboarding update decision/{flag=1;next}/^## /{flag=0}flag')"
          onboarding_manifest="$(printf '%s\n' "$body" | awk '/^## Feature onboarding manifest change/{flag=1;next}/^## /{flag=0}flag')"
          ai_usage="$(printf '%s\n' "$body" | awk '/^## AI usage declaration/{flag=1;next}/^## /{flag=0}flag')"
          ai_intent="$(printf '%s\n' "$body" | awk '/^## AI intent and value/{flag=1;next}/^## /{flag=0}flag')"
          ai_data="$(printf '%s\n' "$body" | awk '/^## AI data handling/{flag=1;next}/^## /{flag=0}flag')"
          ai_validation="$(printf '%s\n' "$body" | awk '/^## AI validation and fallback/{flag=1;next}/^## /{flag=0}flag')"
          engineering="$(printf '%s\n' "$body" | awk '/^## Engineering baseline compliance/{flag=1;next}/^## /{flag=0}flag')"
          engineering_rationale="$(printf '%s\n' "$body" | awk '/^## Engineering baseline rationale/{flag=1;next}/^## /{flag=0}flag')"

          applied_clean="$(printf '%s' "$applied" | sed 's/[[:space:]-]//g')"
          soul_clean="$(printf '%s' "$soul" | sed 's/[[:space:]-]//g')"
          animation_clean="$(printf '%s' "$animation" | sed 's/[[:space:]-]//g')"
          whimsy_clean="$(printf '%s' "$whimsy" | sed 's/[[:space:]-]//g')"
          motion_a11y_clean="$(printf '%s' "$motion_a11y" | sed 's/[[:space:]-]//g')"
          onboarding_score_clean="$(printf '%s' "$onboarding_score" | sed 's/[[:space:]-]//g')"
          onboarding_decision_clean="$(printf '%s' "$onboarding_decision" | sed 's/[[:space:]-]//g')"
          onboarding_manifest_clean="$(printf '%s' "$onboarding_manifest" | sed 's/[[:space:]-]//g')"
          ai_intent_clean="$(printf '%s' "$ai_intent" | sed 's/[[:space:]-]//g')"
          ai_data_clean="$(printf '%s' "$ai_data" | sed 's/[[:space:]-]//g')"
          ai_validation_clean="$(printf '%s' "$ai_validation" | sed 's/[[:space:]-]//g')"
          ai_usage_checked_count="$(printf '%s\n' "$ai_usage" | grep -Ec '^- \[[xX]\] (No AI used|AI used)$' || true)"
          ai_used_checked_count="$(printf '%s\n' "$ai_usage" | grep -Ec '^- \[[xX]\] AI used$' || true)"
          engineering_rationale_clean="$(printf '%s' "$engineering_rationale" | sed 's/[[:space:]-]//g')"
          engineering_checked_count="$(printf '%s\n' "$engineering" | grep -Ec '^- \[[xX]\] ' || true)"

          [[ -n "$applied_clean" ]] || fail "Applied principles section cannot be empty"
          [[ -n "$soul_clean" ]] || fail "Site Soul alignment section cannot be empty"
          [[ -n "$animation_clean" ]] || fail "Animation audit summary section cannot be empty"
          [[ -n "$whimsy_clean" ]] || fail "Whimsy & motion quality bar section cannot be empty"
          [[ -n "$motion_a11y_clean" ]] || fail "Accessibility parity for motion section cannot be empty"
          [[ -n "$onboarding_score_clean" ]] || fail "Onboarding impact score (0-5) section cannot be empty"
          [[ -n "$onboarding_decision_clean" ]] || fail "Onboarding update decision section cannot be empty"
          score_value="$(printf '%s\n' "$onboarding_score" | grep -Eo '[0-5]' | head -n 1 || true)"
          [[ -n "$score_value" ]] || fail "Onboarding impact score must include a numeric value from 0 to 5"
          decision_value="$(printf '%s\n' "$onboarding_decision" | tr '[:upper:]' '[:lower:]' | grep -Eo 'none|copy-only|mini-tour' | head -n 1 || true)"
          [[ -n "$decision_value" ]] || fail "Onboarding update decision must include one of: none, copy-only, mini-tour"
          if [[ "$score_value" -ge 3 ]]; then
            [[ -n "$onboarding_manifest_clean" ]] || fail "Feature onboarding manifest change is required when onboarding impact score is 3-5"
            feature_id_value="$(printf '%s\n' "$onboarding_manifest" | awk -F ':' 'tolower($0) ~ /featureid/ {gsub(/^[[:space:]]+|[[:space:]]+$/, \"\", $2); print $2; exit}')"
            version_value="$(printf '%s\n' "$onboarding_manifest" | awk -F ':' 'tolower($0) ~ /version/ {gsub(/^[[:space:]]+|[[:space:]]+$/, \"\", $2); print $2; exit}')"
            trigger_value="$(printf '%s\n' "$onboarding_manifest" | awk -F ':' 'tolower($0) ~ /trigger/ {gsub(/^[[:space:]]+|[[:space:]]+$/, \"\", $2); print $2; exit}')"
            [[ -n "$feature_id_value" ]] || fail "Feature onboarding manifest change must include featureId when onboarding impact score is 3-5"
            [[ -n "$version_value" ]] || fail "Feature onboarding manifest change must include version when onboarding impact score is 3-5"
            [[ -n "$trigger_value" ]] || fail "Feature onboarding manifest change must include trigger when onboarding impact score is 3-5"
          fi
          [[ "$ai_usage_checked_count" -ge 1 ]] || fail "AI usage declaration must check '- [x] No AI used' or '- [x] AI used'"
          [[ -n "$ai_intent_clean" ]] || fail "AI intent and value section cannot be empty"
          [[ -n "$ai_data_clean" ]] || fail "AI data handling section cannot be empty"
          [[ -n "$ai_validation_clean" ]] || fail "AI validation and fallback section cannot be empty"
          if [[ "$ai_used_checked_count" -ge 1 ]]; then
            [[ -n "$ai_data_clean" ]] || fail "AI data handling must be filled when '- [x] AI used' is selected"
            [[ -n "$ai_validation_clean" ]] || fail "AI validation and fallback must be filled when '- [x] AI used' is selected"
          fi
          [[ "$engineering_checked_count" -ge 1 ]] || fail "Engineering baseline compliance must have at least one checked option"
          [[ -n "$engineering_rationale_clean" ]] || fail "Engineering baseline rationale section cannot be empty"
YAML

  cat > "$repo_path/.github/workflows/update-rinshari-eye-submodule.yml" <<'YAML'
name: Update rinshari-eye submodule

on:
  schedule:
    - cron: '0 14 * * 1,4'
  workflow_dispatch:

permissions:
  contents: write
  pull-requests: write

jobs:
  update-submodule:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          fetch-depth: 0
          submodules: true

      - name: Update submodule pointer to latest main
        shell: bash
        run: |
          set -euo pipefail
          git submodule sync --recursive
          git submodule update --init --recursive
          git -C design/rinshari-eye fetch origin main
          git -C design/rinshari-eye checkout origin/main

      - name: Create pull request
        uses: peter-evans/create-pull-request@v6
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          branch: codex/bump-rinshari-eye-submodule
          base: main
          title: "chore: bump rinshari-eye submodule"
          commit-message: "chore: bump rinshari-eye submodule"
          body: |
            Automated update of `design/rinshari-eye` to latest `main`.
          labels: |
            automation
            design-system
          add-paths: |
            design/rinshari-eye
YAML

  git -C "$repo_path" add .gitmodules design/rinshari-eye docs/site-soul-brief.md AGENTS.md .github/PULL_REQUEST_TEMPLATE.md .github/workflows/design-preflight-check.yml .github/workflows/update-rinshari-eye-submodule.yml

  if git -C "$repo_path" diff --cached --quiet; then
    echo "No changes to commit for $repo_name"
    git -C "$repo_path" checkout "$default_branch"
    git -C "$repo_path" branch -D "$bootstrap_branch" || true
    continue
  fi

  git -C "$repo_path" commit -m "chore: bootstrap rinshari-eye design guide integration"
  git -C "$repo_path" push -u origin "$bootstrap_branch"

  if [[ "$CREATE_PR" == "true" ]]; then
    if ! gh pr create \
      --repo "$OWNER/$repo_name" \
      --base "$default_branch" \
      --head "$bootstrap_branch" \
      --title "chore: bootstrap rinshari-eye design integration" \
      --body "This PR bootstraps rinshari-eye integration with submodule, agent preflight policy, PR template fields, and CI workflows."; then
      echo "PR may already exist for $repo_name; continuing"
    fi
  fi

done
