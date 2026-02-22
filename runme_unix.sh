#!/usr/bin/env bash
set -euo pipefail

# Unix/Linux run helper for qgeniehw_cli_standalone
#
# Usage:
#   chmod +x ./runme_unix.sh
#   ./runme_unix.sh
#
# Prereq:
#   export QGENIE_API_KEY="<your_key_here>"

cd "$(dirname "$0")"

if [[ -z "${QGENIE_API_KEY:-}" ]]; then
  echo "ERROR: QGENIE_API_KEY is not set."
  echo "Set it in your shell:"
  echo '  export QGENIE_API_KEY="<your_key_here>"'
  exit 1
fi

python3 ./qgeniehw_cli.py help
python3 ./qgeniehw_cli.py
