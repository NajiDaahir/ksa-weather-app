from flask import Flask
import requests
import boto3

app = Flask(__name__)

def get_api_key():
    # Create an SSM client to retrieve the API key from Parameter Store
    ssm = boto3.client('ssm', region_name='eu-west-1')  # Replace with your AWS region
    response = ssm.get_parameter(Name='/weather/api_key', WithDecryption=True)
    return response['Parameter']['Value']

@app.route('/')
def home():
    cities = ["Riyadh", "Jeddah", "Madinah", "Makkah"]
    weather_info = []
    
    api_key = get_api_key()  # Retrieve the API key securely
    
    for city in cities:
        url = f"http://api.weatherapi.com/v1/current.json?key={api_key}&q={city}"
        response = requests.get(url)
        data = response.json()
        weather_info.append(f"{city}: {data['current']['temp_c']}°C")
    
    return "<br>".join(weather_info)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
