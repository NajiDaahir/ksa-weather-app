from flask import Flask
import requests
import os

app = Flask(__name__)

@app.route('/health')
def health_check():
    return "Healthy", 200

@app.route('/')
def home():
    cities = ["Riyadh", "Jeddah", "Madinah", "Makkah"]
    weather_info = []
    
    # Retrieve the API key from the environment variable
    api_key = os.getenv("WEATHER_API_KEY")
    print(f"API Key Retrieved: {api_key}")  # Log the API key for debugging
    
    if not api_key:
        return "API key not found!", 500
    
    for city in cities:
        url = f"http://api.weatherapi.com/v1/current.json?key={api_key}&q={city}"
        response = requests.get(url)
        data = response.json()
        weather_info.append(f"{city}: {data['current']['temp_c']}°C")
    
    return "<br>".join(weather_info)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
