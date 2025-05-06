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

## Screenshoty
<img width="1192" alt="Screenshot 2025-05-06 at 09 01 55" src="https://github.com/user-attachments/assets/3c5b984b-0b24-4fd5-8deb-7853cbd0aea5" />

<img width="997" alt="Screenshot 2025-05-06 at 09 11 45" src="https://github.com/user-attachments/assets/32eab4bb-44ac-4dee-8c1b-63129e88e556" />


