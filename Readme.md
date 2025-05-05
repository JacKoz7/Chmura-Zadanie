# Aplikacja Pogodowa 

Aplikacja webowa napisana w Pythonie z użyciem frameworka Flask, która pokazuje aktualną pogodę dla wybranego miasta. Aplikacja jest skonteneryzowana przy użyciu Dockera zgodnie ze standardem OCI.

## Wymagania

- Docker
- Docker Buildx (dla budowania obrazów wieloplatformowych)
- Klucz API do OpenWeatherMap (można uzyskać za darmo na stronie


#### Standardowe budowanie obrazu:

```bash
# Podstawowe polecenie do zbudowania obrazu
docker build -t aplikacja-pogodowa .
```

#### Budowanie obrazu wieloplatformowego (linux/amd64 i linux/arm64):

```bash
# Utworzenie i konfiguracja buildx buildera
docker buildx create --name mybuilder --driver docker-container --use

# Budowanie i publikowanie obrazu wieloplatformowego
docker buildx build --platform linux/amd64,linux/arm64 -t username/aplikacja-pogodowa:latest --push .

# Alternatywnie, jeśli nie chcesz publikować obrazu w repozytorium, a zapisać lokalnie
docker buildx build --platform linux/amd64,linux/arm64 -t aplikacja-pogodowa:latest --load .
```

#### Sprawdzenie manifestu obrazu wieloplatformowego:

```bash
# Inspekcja manifestu obrazu
docker buildx imagetools inspect username/aplikacja-pogodowa:latest
```

### b. Uruchomienie kontenera na podstawie zbudowanego obrazu

```bash
# Podstawowe uruchomienie kontenera
docker run -p 5001:5000 --env-file .env --name pogoda-app aplikacja-pogodowa 
```

### c. Uzyskanie informacji z logów aplikacji

```bash
# Wyświetlenie wszystkich logów kontenera
docker logs pogoda-app
```

### d. Sprawdzenie liczby warstw i rozmiaru obrazu

```bash
# Sprawdzenie rozmiaru obrazu
docker images aplikacja-pogodowa

# Sprawdzenie liczby warstw i szczegółów obrazu
docker history aplikacja-pogodowa
```