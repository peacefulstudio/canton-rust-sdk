#!/usr/bin/env bash
set -euo pipefail

echo "$1 $(date +%s)" >> "${RUNNER_TEMP}/phases.log"
