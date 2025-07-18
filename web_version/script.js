// Weather App JavaScript
class WeatherApp {
    constructor() {
        this.apiKey = localStorage.getItem('weatherApiKey');
        this.baseUrl = 'https://api.openweathermap.org/data/2.5';
        this.currentWeatherData = null;
        
        this.initializeElements();
        this.attachEventListeners();
        this.checkApiKey();
    }

    initializeElements() {
        this.elements = {
            cityInput: document.getElementById('cityInput'),
            searchBtn: document.getElementById('searchBtn'),
            locationBtn: document.getElementById('locationBtn'),
            weatherContainer: document.getElementById('weatherContainer'),
            loading: document.getElementById('loading'),
            error: document.getElementById('error'),
            errorMessage: document.getElementById('errorMessage'),
            retryBtn: document.getElementById('retryBtn'),
            apiSetup: document.getElementById('apiSetup'),
            apiKeyInput: document.getElementById('apiKeyInput'),
            saveApiBtn: document.getElementById('saveApiBtn')
        };
    }

    attachEventListeners() {
        this.elements.searchBtn.addEventListener('click', () => this.searchWeather());
        this.elements.cityInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') this.searchWeather();
        });
        this.elements.locationBtn.addEventListener('click', () => this.getCurrentLocationWeather());
        this.elements.retryBtn.addEventListener('click', () => this.retryLastSearch());
        this.elements.saveApiBtn.addEventListener('click', () => this.saveApiKey());
    }

    checkApiKey() {
        if (!this.apiKey) {
            this.showApiSetup();
        } else {
            this.hideApiSetup();
            // Try to load weather for a default city
            this.loadWeatherByCity('London');
        }
    }

    showApiSetup() {
        this.elements.apiSetup.style.display = 'flex';
    }

    hideApiSetup() {
        this.elements.apiSetup.style.display = 'none';
    }

    saveApiKey() {
        const apiKey = this.elements.apiKeyInput.value.trim();
        if (!apiKey) {
            alert('Please enter a valid API key');
            return;
        }

        this.apiKey = apiKey;
        localStorage.setItem('weatherApiKey', apiKey);
        this.hideApiSetup();
        this.loadWeatherByCity('London');
    }

    showLoading() {
        this.elements.loading.style.display = 'block';
        this.elements.error.style.display = 'none';
        this.elements.weatherContainer.style.display = 'none';
    }

    hideLoading() {
        this.elements.loading.style.display = 'none';
    }

    showError(message) {
        this.elements.error.style.display = 'block';
        this.elements.errorMessage.textContent = message;
        this.elements.loading.style.display = 'none';
        this.elements.weatherContainer.style.display = 'none';
    }

    showWeather() {
        this.elements.weatherContainer.style.display = 'block';
        this.elements.loading.style.display = 'none';
        this.elements.error.style.display = 'none';
    }

    async searchWeather() {
        const city = this.elements.cityInput.value.trim();
        if (!city) {
            alert('Please enter a city name');
            return;
        }

        await this.loadWeatherByCity(city);
    }

    async loadWeatherByCity(city) {
        this.lastSearchType = 'city';
        this.lastSearchValue = city;
        
        this.showLoading();

        try {
            const weatherData = await this.fetchWeatherByCity(city);
            this.currentWeatherData = weatherData;
            this.renderWeather(weatherData);
            this.showWeather();
        } catch (error) {
            this.showError(error.message);
        }
    }

    async getCurrentLocationWeather() {
        if (!navigator.geolocation) {
            this.showError('Geolocation is not supported by this browser');
            return;
        }

        this.showLoading();

        navigator.geolocation.getCurrentPosition(
            async (position) => {
                try {
                    const { latitude, longitude } = position.coords;
                    this.lastSearchType = 'coords';
                    this.lastSearchValue = { lat: latitude, lon: longitude };
                    
                    const weatherData = await this.fetchWeatherByCoords(latitude, longitude);
                    this.currentWeatherData = weatherData;
                    this.renderWeather(weatherData);
                    this.showWeather();
                } catch (error) {
                    this.showError(error.message);
                }
            },
            (error) => {
                let message = 'Unable to get your location';
                switch (error.code) {
                    case error.PERMISSION_DENIED:
                        message = 'Location access denied by user';
                        break;
                    case error.POSITION_UNAVAILABLE:
                        message = 'Location information is unavailable';
                        break;
                    case error.TIMEOUT:
                        message = 'Location request timed out';
                        break;
                }
                this.showError(message);
            }
        );
    }

    async retryLastSearch() {
        if (this.lastSearchType === 'city') {
            await this.loadWeatherByCity(this.lastSearchValue);
        } else if (this.lastSearchType === 'coords') {
            this.showLoading();
            try {
                const weatherData = await this.fetchWeatherByCoords(
                    this.lastSearchValue.lat, 
                    this.lastSearchValue.lon
                );
                this.currentWeatherData = weatherData;
                this.renderWeather(weatherData);
                this.showWeather();
            } catch (error) {
                this.showError(error.message);
            }
        }
    }

    async fetchWeatherByCity(city) {
        const currentWeatherUrl = `${this.baseUrl}/weather?q=${encodeURIComponent(city)}&appid=${this.apiKey}&units=metric`;
        const forecastUrl = `${this.baseUrl}/forecast?q=${encodeURIComponent(city)}&appid=${this.apiKey}&units=metric`;

        const [currentResponse, forecastResponse] = await Promise.all([
            fetch(currentWeatherUrl),
            fetch(forecastUrl)
        ]);

        if (!currentResponse.ok) {
            if (currentResponse.status === 401) {
                throw new Error('Invalid API key. Please check your API key.');
            } else if (currentResponse.status === 404) {
                throw new Error('City not found. Please check the city name.');
            } else {
                throw new Error(`Failed to fetch weather data: ${currentResponse.status}`);
            }
        }

        if (!forecastResponse.ok) {
            throw new Error(`Failed to fetch forecast data: ${forecastResponse.status}`);
        }

        const currentData = await currentResponse.json();
        const forecastData = await forecastResponse.json();

        return this.processWeatherData(currentData, forecastData);
    }

    async fetchWeatherByCoords(lat, lon) {
        const currentWeatherUrl = `${this.baseUrl}/weather?lat=${lat}&lon=${lon}&appid=${this.apiKey}&units=metric`;
        const forecastUrl = `${this.baseUrl}/forecast?lat=${lat}&lon=${lon}&appid=${this.apiKey}&units=metric`;

        const [currentResponse, forecastResponse] = await Promise.all([
            fetch(currentWeatherUrl),
            fetch(forecastUrl)
        ]);

        if (!currentResponse.ok || !forecastResponse.ok) {
            throw new Error('Failed to fetch weather data');
        }

        const currentData = await currentResponse.json();
        const forecastData = await forecastResponse.json();

        return this.processWeatherData(currentData, forecastData);
    }

    processWeatherData(currentData, forecastData) {
        // Process current weather
        const current = {
            location: `${currentData.name}, ${currentData.sys.country}`,
            temperature: Math.round(currentData.main.temp),
            description: currentData.weather[0].description,
            icon: currentData.weather[0].icon,
            feelsLike: Math.round(currentData.main.feels_like),
            humidity: currentData.main.humidity,
            pressure: currentData.main.pressure,
            windSpeed: currentData.wind.speed,
            visibility: Math.round(currentData.visibility / 1000), // Convert to km
            sunrise: new Date(currentData.sys.sunrise * 1000),
            sunset: new Date(currentData.sys.sunset * 1000)
        };

        // Process forecast data (group by day)
        const forecast = this.processForecastData(forecastData.list);

        return { current, forecast };
    }

    processForecastData(forecastList) {
        const dailyForecast = {};
        const today = new Date().toDateString();

        forecastList.forEach(item => {
            const date = new Date(item.dt * 1000);
            const dateString = date.toDateString();
            
            // Skip today's forecast
            if (dateString === today) return;

            if (!dailyForecast[dateString]) {
                dailyForecast[dateString] = {
                    date: date,
                    temps: [],
                    weather: item.weather[0],
                    items: []
                };
            }

            dailyForecast[dateString].temps.push(item.main.temp);
            dailyForecast[dateString].items.push(item);
        });

        // Convert to array and calculate min/max temps
        return Object.values(dailyForecast).slice(0, 5).map(day => ({
            date: day.date,
            minTemp: Math.round(Math.min(...day.temps)),
            maxTemp: Math.round(Math.max(...day.temps)),
            description: day.weather.description,
            icon: day.weather.icon
        }));
    }

    renderWeather(weatherData) {
        const { current, forecast } = weatherData;
        
        this.elements.weatherContainer.innerHTML = `
            <div class="weather-card">
                <div class="current-weather">
                    <h2>Current Weather</h2>
                    <div class="location">${current.location}</div>
                    <div class="weather-main">
                        <div class="weather-icon">${this.getWeatherIcon(current.icon)}</div>
                        <div class="temperature">${current.temperature}°C</div>
                    </div>
                    <div class="description">${current.description}</div>
                    <div class="feels-like">Feels like ${current.feelsLike}°C</div>
                </div>

                <div class="weather-details">
                    <div class="detail-item">
                        <i class="fas fa-tint"></i>
                        <div class="label">Humidity</div>
                        <div class="value">${current.humidity}%</div>
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-thermometer-half"></i>
                        <div class="label">Pressure</div>
                        <div class="value">${current.pressure} hPa</div>
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-wind"></i>
                        <div class="label">Wind Speed</div>
                        <div class="value">${current.windSpeed} m/s</div>
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-eye"></i>
                        <div class="label">Visibility</div>
                        <div class="value">${current.visibility} km</div>
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-sun"></i>
                        <div class="label">Sunrise</div>
                        <div class="value">${current.sunrise.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'})}</div>
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-moon"></i>
                        <div class="label">Sunset</div>
                        <div class="value">${current.sunset.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'})}</div>
                    </div>
                </div>

                <div class="forecast">
                    <h3>5-Day Forecast</h3>
                    <div class="forecast-grid">
                        ${forecast.map(day => `
                            <div class="forecast-item">
                                <div class="day">${day.date.toLocaleDateString([], {weekday: 'short', month: 'short', day: 'numeric'})}</div>
                                <div class="forecast-icon">${this.getWeatherIcon(day.icon)}</div>
                                <div class="temps">
                                    <span class="high">${day.maxTemp}°</span>
                                    <span class="low">${day.minTemp}°</span>
                                </div>
                                <div class="forecast-desc">${day.description}</div>
                            </div>
                        `).join('')}
                    </div>
                </div>
            </div>
        `;
    }

    getWeatherIcon(iconCode) {
        const iconMap = {
            '01d': '☀️', '01n': '🌙',
            '02d': '⛅', '02n': '☁️',
            '03d': '☁️', '03n': '☁️',
            '04d': '☁️', '04n': '☁️',
            '09d': '🌧️', '09n': '🌧️',
            '10d': '🌦️', '10n': '🌧️',
            '11d': '⛈️', '11n': '⛈️',
            '13d': '❄️', '13n': '❄️',
            '50d': '🌫️', '50n': '🌫️'
        };

        return iconMap[iconCode] || '🌤️';
    }
}

// Initialize the app when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    new WeatherApp();
});