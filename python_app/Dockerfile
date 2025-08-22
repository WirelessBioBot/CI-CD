FROM python:3.10.17-alpine3.21 AS builder
WORKDIR /app

COPY pyproject.toml ./
RUN pip install --upgrade pip setuptools wheel
RUN pip install ".[test]"

COPY src ./src
COPY tests ./tests
RUN pip wheel . -w /wheels

FROM python:3.10.17-alpine3.21 AS final
WORKDIR /app

COPY --from=builder /wheels/*.whl ./
RUN pip install *.whl && pip install pytest pytest-asyncio httpx

COPY --from=builder /app/src ./src
COPY --from=builder /app/tests ./tests

CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8115"]
