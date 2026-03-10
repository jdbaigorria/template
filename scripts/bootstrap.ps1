$ErrorActionPreference = "Stop"

uv sync --all-groups
uv run pre-commit install
uv run pre-commit install --hook-type commit-msg