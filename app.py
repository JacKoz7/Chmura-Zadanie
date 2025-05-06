import os
import logging
import datetime
import requests
from flask import Flask, render_template, request

app = Flask(__name__)

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

# Dane autora
AUTHOR_NAME = "Jacek Kozłowski"  
PORT = int(os.environ.get("PORT", 5000))

# Klucz API do OpenWeatherMap 
WEATHER_API_KEY = os.environ.get("WEATHER_API_KEY")
WEATHER_API_URL = "https://api.openweathermap.org/data/2.5/weather"

# Predefiniowana lista krajów i miast
COUNTRIES_CITIES = {
    "Polska": ["Warszawa", "Kraków", "Gdańsk", "Wrocław", "Poznań"],
    "Niemcy": ["Berlin", "Monachium", "Hamburg", "Frankfurt", "Kolonia"],
    "Francja": ["Paryż", "Marsylia", "Lyon", "Tuluza", "Nicea"],
    "Włochy": ["Rzym", "Mediolan", "Neapol", "Turyn", "Florencja"],
    "Hiszpania": ["Madryt", "Barcelona", "Walencja", "Sewilla", "Malaga"]
}

@app.route('/', methods=['GET', 'POST'])
def index():
    weather_data = None
    selected_country = None
    cities = []
    
    if request.method == 'POST':
        selected_country = request.form.get('country')
        selected_city = request.form.get('city')
        
        if selected_country and selected_city:
            weather_data = get_weather_data(selected_city)
            cities = COUNTRIES_CITIES.get(selected_country, [])
    
    return render_template(
        'index.html',
        countries=COUNTRIES_CITIES.keys(),
        cities=cities,
        selected_country=selected_country,
        weather_data=weather_data
    )

@app.route('/api/cities', methods=['GET'])
def get_cities():
    country = request.args.get('country')
    if country in COUNTRIES_CITIES:
        return {"cities": COUNTRIES_CITIES[country]}
    return {"cities": []}

def get_weather_data(city):
    """Pobieranie danych pogodowych dla podanego miasta"""
    try:
        params = {
            'q': city,
            'appid': WEATHER_API_KEY,
            'units': 'metric',
            'lang': 'pl'
        }
        response = requests.get(WEATHER_API_URL, params=params)
        response.raise_for_status()
        data = response.json()
        
        return {
            'city': city,
            'temperature': data['main']['temp'],
            'description': data['weather'][0]['description'],
            'humidity': data['main']['humidity'],
            'pressure': data['main']['pressure'],
            'wind_speed': data['wind']['speed'],
            'icon': data['weather'][0]['icon']
        }
    except Exception as e:
        logger.error(f"Błąd podczas pobierania danych pogodowych: {e}")
        return None

if __name__ == '__main__':
    # Logowanie informacji startowych
    start_time = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    logger.info(f"Data uruchomienia: {start_time}")
    logger.info(f"Autor programu: {AUTHOR_NAME}")
    logger.info(f"Nasłuchiwanie na porcie TCP: {PORT}")
    
    # Uruchomienie aplikacji
    app.run(host='0.0.0.0', port=PORT, debug=False)