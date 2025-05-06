# syntax=docker/dockerfile:1.4

# =======================================
# ETAP 1: Builder - optymalizacja zależności
# =======================================
FROM python:3.9-alpine AS builder

# Metadane zgodne ze standardem OCI
LABEL org.opencontainers.image.authors="Jacek Kozłowski" \
      org.opencontainers.image.title="Aplikacja Pogodowa" \
      org.opencontainers.image.description="Aplikacja webowa pokazująca aktualną pogodę" \
      org.opencontainers.image.version="1.0.0"

# Optymalizacja pip
ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on

WORKDIR /build

# Kopiowanie tylko requirements.txt najpierw dla optymalizacji cache
COPY requirements.txt .

# Instalacja zależności systemowych potrzebnych dla niektórych pakietów Python
RUN apk add --no-cache --virtual .build-deps gcc musl-dev && \
    pip install --prefix=/install --no-cache-dir -r requirements.txt && \
    apk del .build-deps

# =======================================
# ETAP 2: Obraz finalny
# =======================================
FROM python:3.9-alpine

# Kopiowanie zainstalowanych pakietów Python z buildera
COPY --from=builder /install /usr/local

# Konfiguracja użytkownika nie-root dla bezpieczeństwa
RUN addgroup -S app && \
    adduser -S app -G app && \
    mkdir -p /app/templates && \
    chown -R app:app /app

WORKDIR /app

# Kopiowanie aplikacji z odpowiednimi uprawnieniami
COPY --chown=app:app app.py .
COPY --chown=app:app templates/index.html ./templates/

# Ustawienie zmiennych środowiskowych
ENV PORT=5000 \
    FLASK_APP=app.py \
    WEATHER_API_KEY=""

# Healthcheck
HEALTHCHECK --interval=30s --timeout=3s \
    CMD wget -q --spider http://localhost:$PORT/ || exit 1

EXPOSE $PORT

USER app

# Uruchomienie aplikacji Flask
CMD ["python", "app.py"]