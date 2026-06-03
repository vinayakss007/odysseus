#!/bin/sh
set -e

DATA_DIR="${DATA_DIR:-/data}"
mkdir -p "$DATA_DIR" /app/logs /app/services/cache/search

if [ ! -f "$DATA_DIR/app.db" ]; then
    python /app/setup.py 2>&1 | tail -5
fi

exec uvicorn app:app --host 0.0.0.0 --port "${APP_PORT:-7860}"
