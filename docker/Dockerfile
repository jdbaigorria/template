FROM ghcr.io/astral-sh/uv:0.9.26 AS uv

# Build stage: instala deps dentro de ${LAMBDA_TASK_ROOT}
FROM public.ecr.aws/lambda/python:3.14 AS builder

# Bytecode para mejorar cold start
ENV UV_COMPILE_BYTECODE=1
# Layer determinística
ENV UV_NO_INSTALLER_METADATA=1
# Mejor para caching con bind mounts
ENV UV_LINK_MODE=copy

# Export lock -> requirements + pip install target ${LAMBDA_TASK_ROOT}
RUN --mount=from=uv,source=/uv,target=/bin/uv \
    --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv export --frozen --no-emit-workspace --no-dev --no-editable -o requirements.txt && \
    uv pip install -r requirements.txt --target "${LAMBDA_TASK_ROOT}"

# Runtime stage
FROM public.ecr.aws/lambda/python:3.14

# Copia deps ya instaladas
COPY --from=builder ${LAMBDA_TASK_ROOT} ${LAMBDA_TASK_ROOT}

# Copia app handler
COPY ./src/main.py ${LAMBDA_TASK_ROOT}/
COPY ./src/app ${LAMBDA_TASK_ROOT}/app

# Handler
CMD ["main.handler"]
