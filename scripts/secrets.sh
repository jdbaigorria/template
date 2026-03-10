#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

cd "$REPO_ROOT"

if ! command -v detect-secrets >/dev/null 2>&1; then
  echo "Error: detect-secrets no está instalado." >&2
  exit 1
fi

ACTION="${1:-scan}"

case "$ACTION" in
  init)
    detect-secrets scan > .secrets.baseline
    echo "Baseline creado: .secrets.baseline"
    ;;
  audit)
    if [[ ! -f .secrets.baseline ]]; then
      echo "Error: no existe .secrets.baseline" >&2
      exit 1
    fi
    detect-secrets audit .secrets.baseline
    ;;
  update)
    if [[ ! -f .secrets.baseline ]]; then
      echo "Error: no existe .secrets.baseline" >&2
      exit 1
    fi
    detect-secrets scan --update .secrets.baseline
    echo "Baseline actualizado."
    ;;
  scan)
    if [[ ! -f .secrets.baseline ]]; then
      echo "Error: no existe .secrets.baseline. Usa: $0 init" >&2
      exit 1
    fi
    detect-secrets scan --update .secrets.baseline
    detect-secrets audit .secrets.baseline
    ;;
  *)
    echo "Uso: $0 {init|update|audit|scan}" >&2
    exit 1
    ;;
esac