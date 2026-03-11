#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"$SCRIPT_DIR/python.sh"
"$SCRIPT_DIR/pre-commit.sh"
"$SCRIPT_DIR/sls.sh"

echo
echo "Instalación base completada."
