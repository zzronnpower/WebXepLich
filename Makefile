.PHONY: help install run docker-up docker-down docker-logs db-reset port-8000

help:
	@echo "Targets: install, run, docker-up, docker-down, docker-logs, db-reset, port-8000"

install:
	pip install -r requirements.txt

run:
	uvicorn backend.app.main:ung_dung --host 0.0.0.0 --port 8000 --reload

docker-up:
	docker compose up -d --build

docker-down:
	docker compose down

docker-logs:
	docker compose logs -f web

db-reset:
	docker compose down -v
	docker compose up -d --build

port-8000:
	@echo "Check port 8000 usage:"
	@echo "sudo lsof -iTCP:8000 -sTCP:LISTEN"
