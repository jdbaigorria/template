#!/usr/bin/env bash
# Instala Serverless Framework y los plugins usados por este proyecto.
# Ejecutar desde cualquier ubicación: el script resuelve la raíz del repo.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SERVERLESS_VERSION="3.39.0"

echo "Raíz del repo: $REPO_ROOT"
cd "$REPO_ROOT"

if ! command -v npm >/dev/null 2>&1; then
  echo "Error: npm no está instalado. Instala Node.js/npm y vuelve a ejecutar." >&2
  exit 1
fi

if [[ ! -f package.json ]]; then
  echo "Error: no se encontró package.json en la raíz del repo." >&2
  exit 1
fi

echo "Instalando Serverless Framework @$SERVERLESS_VERSION y plugins..."
npm install --save-dev \
  "serverless@$SERVERLESS_VERSION" \
  serverless-uv-requirements@^1.1.0 \
  serverless-python-requirements@^6.1.2

echo
echo "Listo. Comprueba con:"
echo "  npx serverless --version"
echo "  npx sls print"
echo "  npm ls --depth=0"