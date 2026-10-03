#!/usr/bin/env bash
set -uo pipefail

echo "::group::Headroom ${1}"
df -h /
free -m
echo "::endgroup::"
{
  echo "### Headroom ${1}"
  echo '```'
  df -h /
  free -m
  echo '```'
} >> "$GITHUB_STEP_SUMMARY"
