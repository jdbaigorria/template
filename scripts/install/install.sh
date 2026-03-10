#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"$SCRIPT_DIR/python-tooling.sh"
"$SCRIPT_DIR/pre-commit.sh"
"$SCRIPT_DIR/serverless.sh"

echo
echo "Instalación base completada."