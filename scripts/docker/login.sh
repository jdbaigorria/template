#!/usr/bin/env bash
set -euo pipefail

: "${REGISTRY_PROVIDER:?Missing REGISTRY_PROVIDER}"

case "$REGISTRY_PROVIDER" in
  ecr)
    : "${AWS_REGION:?Missing AWS_REGION}"
    : "${ECR_REGISTRY:?Missing ECR_REGISTRY}"

    AWS_PROFILE_OPT=()
    if [[ -n "${AWS_PROFILE:-}" ]]; then
      AWS_PROFILE_OPT=(--profile "$AWS_PROFILE")
    fi

    aws ecr get-login-password \
      --region "$AWS_REGION" \
      "${AWS_PROFILE_OPT[@]}" \
    | docker login \
      --username AWS \
      --password-stdin "$ECR_REGISTRY"

    echo "Login en ECR correcto: $ECR_REGISTRY"
    ;;

  dockerhub)
    : "${DOCKERHUB_USERNAME:?Missing DOCKERHUB_USERNAME}"
    : "${DOCKERHUB_TOKEN:?Missing DOCKERHUB_TOKEN}"

    echo "$DOCKERHUB_TOKEN" | docker login \
      --username "$DOCKERHUB_USERNAME" \
      --password-stdin

    echo "Login en Docker Hub correcto: $DOCKERHUB_USERNAME"
    ;;

  *)
    echo "Unsupported REGISTRY_PROVIDER: $REGISTRY_PROVIDER" >&2
    exit 1
    ;;
esac
