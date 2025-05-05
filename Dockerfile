# syntax=docker/dockerfile:1.4

# =======================================
# ETAP 1: Builder - zoptymalizowany
# =======================================
FROM python:3.9-alpine AS builder

LABEL org.opencontainers.image.authors="Jacek Kozłowski <s99592@pollub.edu.pl>" \
      org.opencontainers.image.title="Aplikacja Pogodowa" \
      org.opencontainers.image.description="Aplikacja webowa pokazująca aktualną pogodę" \
      org.opencontainers.image.version="1.0.0"

# Optymalizacja pip
ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on

WORKDIR /build

# Minimalne zależności buildowe
RUN apk add --no-cache gcc musl-dev

COPY requirements.txt .

# Instalacja z konkretnymi wersjami (ważne dla kompatybilności)
RUN pip install --prefix=/install --no-cache-dir \
    Flask==2.0.3 \
    Werkzeug==2.0.3 \
    requests==2.26.0 \
    gunicorn==20.1.0

# =======================================
# ETAP 2: Obraz finalny
# =======================================
FROM python:3.9-alpine

# Kopiowanie środowiska Python
COPY --from=builder /install /usr/local

# Runtime dependencies
RUN apk add --no-cache libstdc++

# Konfiguracja użytkownika
RUN addgroup -S app && \
    adduser -S app -G app && \
    mkdir -p /app/templates && \
    chown -R app:app /app

WORKDIR /app

# Kopiowanie aplikacji
COPY --chown=app:app app.py .
COPY --chown=app:app templates/index.html ./templates/

# Zmienne środowiskowe
ENV PORT=5000 \
    FLASK_APP=app.py \
    WEATHER_API_KEY=""

# Healthcheck
HEALTHCHECK --interval=30s --timeout=3s \
    CMD wget -q --spider http://localhost:$PORT/ || exit 1

EXPOSE $PORT
USER app

# Użycie Gunicorn (dodaj do requirements.txt)
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "1", "app:app"]