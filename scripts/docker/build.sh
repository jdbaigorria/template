#!/usr/bin/env bash
set -euo pipefail

: "${IMAGE_NAME:?Missing IMAGE_NAME}"

DOCKERFILE_PATH="${DOCKERFILE_PATH:-docker/Dockerfile.aws}"

if [[ ! -f "$DOCKERFILE_PATH" ]]; then
  echo "Error: no se encontró el Dockerfile en $DOCKERFILE_PATH" >&2
  exit 1
fi

echo "Construyendo imagen: ${IMAGE_NAME}"
echo "Usando Dockerfile: ${DOCKERFILE_PATH}"

DOCKER_BUILDKIT=1 docker build \
  --provenance=false \
  --output type=docker \
  -f "${DOCKERFILE_PATH}" \
  -t "${IMAGE_NAME}" .

echo "Listo: ${IMAGE_NAME}"
