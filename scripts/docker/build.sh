#!/usr/bin/env bash
set -euo pipefail

: "${IMAGE_NAME:?Missing IMAGE_NAME}"

echo "Construyendo imagen: ${IMAGE_NAME}"

DOCKER_BUILDKIT=1 docker build \
  --provenance=false \
  --output type=docker \
  -t "${IMAGE_NAME}" .

echo "Listo: ${IMAGE_NAME}"
