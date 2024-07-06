.PHONY: help install-dependencies start-local test coverage lint lint-fix format pre-commit-install pre-commit terraform-init terraform-fmt terraform-apply

default: help

help: # Show help for each of the Makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

install-dependencies: # Install dependencies
	poetry export --without-hashes --format=requirements.txt > requirements.txt
	python -m pip install --upgrade pip
	python -m pip install -r requirements.txt

start-local: # Start local server
ifdef port	
	uvicorn app.main:app --port $(port) --reload
else
	uvicorn app.main:app --reload
endif

test: # Run tests
ifdef filter
	poetry run pytest $(filter) -vv
else
	poetry run pytest -vv
endif

coverage: test # Run tests with coverage
	python -m pytest --cov-report term-missing --cov=app

lint: # Run linter
	python -m ruff check .

lint-fix: # Run linter with fix
	python -m ruff check --fix .

format: # Run formatter
	python -m ruff format .

pre-commit-install: # Install pre-commit hooks
	pre-commit install

pre-commit: # Run pre-commit hooks
	pre-commit
