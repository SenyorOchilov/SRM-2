#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

echo "[deploy] fetching latest from origin/main"
git fetch --all --prune
git reset --hard origin/main

echo "[deploy] rebuilding and restarting containers"
docker compose pull || true
docker compose up -d --build --remove-orphans

echo "[deploy] pruning dangling images"
docker image prune -f

echo "[deploy] done"
docker compose ps
