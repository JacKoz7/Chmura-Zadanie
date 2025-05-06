# Aplikacja Pogodowa 

Aplikacja webowa napisana w Pythonie z użyciem frameworka Flask, która pokazuje aktualną pogodę dla wybranego miasta. Aplikacja jest skonteneryzowana przy użyciu Dockera zgodnie ze standardem OCI. Działa pod adresem localhost:5001

### a. Standardowe budowanie obrazu:

```bash
# Podstawowe polecenie do zbudowania obrazu
docker build -t aplikacja-pogodowa . 
```

### b. Uruchomienie kontenera na podstawie zbudowanego obrazu

```bash
# Podstawowe uruchomienie kontenera
docker run -d -p 5001:5000 --name pogoda --env-file .env aplikacja-pogodowa
```

### c. Uzyskanie informacji z logów aplikacji

```bash
# Wyświetlenie wszystkich logów kontenera
docker logs pogoda
```

### d. Sprawdzenie liczby warstw

```bash
# Sprawdzenie liczby warstw i szczegółów obrazu
docker history aplikacja-pogodowa
```