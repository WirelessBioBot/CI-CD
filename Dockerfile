# Сборочный этап
FROM python:3.11-slim AS builder

WORKDIR /app

COPY pyproject.toml ./
RUN pip install --upgrade pip && pip install poetry && poetry config virtualenvs.create false
RUN poetry install --only main,test

COPY . .

# Финальный этап
FROM python:3.11-slim

RUN useradd -m appuser
WORKDIR /app

COPY --from=builder /app /app

USER appuser

CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]

