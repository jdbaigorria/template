#!/usr/bin/env bash
set -euo pipefail

: "${IMAGE_NAME:?Missing IMAGE_NAME}"

docker push "${IMAGE_NAME}"
echo "Pushed: ${IMAGE_NAME}"