#!/bin/sh
set -e

python /app/setup.py 2>&1

exec uvicorn app:app --host 0.0.0.0 --port "${APP_PORT:-7860}"

