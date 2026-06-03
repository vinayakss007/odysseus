FROM python:3.12-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    curl \
    git \
    nodejs \
    npm \
    tmux \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# HF Spaces persistent storage at /data — symlink so the app's hardcoded
# paths (DATA_DIR = BASE_DIR + "data") resolve to persistent storage.
# Survives spin-down/up cycles, but not a Space rebuild.
RUN mkdir -p /data && ln -sfn /data /app/data && \
    mkdir -p /app/logs /app/services/cache/search

COPY spaces/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV DATABASE_URL=sqlite:////data/app.db
ENV APP_BIND=0.0.0.0
ENV APP_PORT=7860
ENV AUTH_ENABLED=false
ENV LOCALHOST_BYPASS=false

EXPOSE 7860

ENTRYPOINT ["/entrypoint.sh"]
