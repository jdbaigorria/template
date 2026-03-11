#!/usr/bin/env bash
set -euo pipefail

uv sync --all-groups
uv run pre-commit install
uv run pre-commit install --hook-type commit-msg
