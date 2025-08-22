.PHONY: install install-dev test run

install:
	pip install .

install-dev:
	pip install ".[test]"

test:
	pytest tests

run:
	uvicorn src.main:app --host 0.0.0.0 --reload
