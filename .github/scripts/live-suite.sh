#!/usr/bin/env bash
set -uo pipefail

suite_name="$1"
shift

log_file="${RUNNER_TEMP}/live-${suite_name}.log"
started_at=$(date +%s)
cargo test --all-features "$@" 2>&1 | tee "$log_file"
cargo_status=${PIPESTATUS[0]}
elapsed=$(($(date +%s) - started_at))

totals=$(awk '/^test result:/ {
  for (i = 1; i <= NF; i++) {
    if ($i == "passed;") passed += $(i - 1)
    if ($i == "failed;") failed += $(i - 1)
    if ($i == "ignored;") ignored += $(i - 1)
  }
} END { printf "passed=%d failed=%d ignored=%d", passed, failed, ignored }' "$log_file")

echo "| ${suite_name} | exit ${cargo_status} | ${totals} | ${elapsed}s |" >> "$GITHUB_STEP_SUMMARY"
exit "$cargo_status"
