#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

echo "Raíz del repo: $REPO_ROOT"
cd "$REPO_ROOT"

if ! command -v uv >/dev/null 2>&1; then
  echo "Error: uv no está instalado." >&2
  exit 1
fi

if [[ ! -f pyproject.toml ]]; then
  echo "Error: no se encontró pyproject.toml en la raíz del repo." >&2
  exit 1
fi

echo "Aplicando Ruff check --fix..."
uv run ruff check . --fix

echo "Aplicando Ruff format..."
uv run ruff format .

echo "Formato aplicado correctamente."