# Aplikacja Pogodowa 

Aplikacja webowa napisana w Pythonie z użyciem frameworka Flask, która pokazuje aktualną pogodę dla wybranego miasta. Aplikacja jest skonteneryzowana przy użyciu Dockera zgodnie ze standardem OCI. Działa pod adresem localhost:5001

### a. Standardowe budowanie obrazu:

```bash
# Podstawowe polecenie do zbudowania obrazu
docker build -t aplikacja-pogodowa . 
```

<img width="1117" alt="Screenshot 2025-05-06 at 09 24 20" src="https://github.com/user-attachments/assets/189a4989-2320-42a1-8c25-210fe8eeb3a4" />


### b. Uruchomienie kontenera na podstawie zbudowanego obrazu

```bash
# Podstawowe uruchomienie kontenera
docker run -d -p 5001:5000 --name pogoda --env-file .env aplikacja-pogodowa
```

<img width="914" alt="Screenshot 2025-05-06 at 09 24 46" src="https://github.com/user-attachments/assets/6856bd47-c1a4-4c37-b7ee-dabea5fab2ae" />


### c. Uzyskanie informacji z logów aplikacji

```bash
# Wyświetlenie wszystkich logów kontenera
docker logs pogoda
```

<img width="973" alt="Screenshot 2025-05-06 at 09 25 11" src="https://github.com/user-attachments/assets/47be2b15-2dc0-43fd-9438-e9cf5430e123" />


### d. Sprawdzenie liczby warstw

```bash
# Sprawdzenie liczby warstw i szczegółów obrazu
docker history aplikacja-pogodowa
```
<img width="1064" alt="Screenshot 2025-05-06 at 09 25 42" src="https://github.com/user-attachments/assets/52c6f314-6056-46ef-8bb4-6ca11f05ff89" />

### Działanie aplikacji w przeglądarce

<img width="1190" alt="Screenshot 2025-05-06 at 09 57 49" src="https://github.com/user-attachments/assets/63d8f667-e791-4e18-8680-204411e96246" />







