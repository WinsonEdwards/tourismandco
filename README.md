# Weather App

A beautiful and modern weather application built with Flutter that provides real-time weather information, hourly forecasts, and 5-day weather predictions.

## Features

- **Current Weather**: Get real-time weather data for your current location
- **Location Search**: Search for weather in any city worldwide
- **Hourly Forecast**: View weather predictions for the next 24 hours
- **5-Day Forecast**: See weather outlook for the next 5 days
- **Beautiful UI**: Modern gradient backgrounds that change based on time of day
- **Smooth Animations**: Engaging animations powered by flutter_animate
- **Weather Details**: Comprehensive weather information including pressure, visibility, humidity, and wind speed

## Setup

1. **Get an API Key**: Sign up for a free API key at [OpenWeatherMap](https://openweathermap.org/api)

2. **Configure API Key**: Open `lib/services/weather_service.dart` and replace `your_api_key_here` with your actual API key:
   ```dart
   static const String _apiKey = 'your_actual_api_key_here';
   ```

3. **Install Dependencies**: Run the following command to install all required packages:
   ```bash
   flutter pub get
   ```

4. **Generate Model Files**: Run the build runner to generate JSON serialization code:
   ```bash
   flutter packages pub run build_runner build
   ```

5. **Run the App**: Launch the app on your preferred device:
   ```bash
   flutter run
   ```

## Permissions

The app requires location permissions to get weather data for your current location. Make sure to grant location permissions when prompted.

### Android Permissions
Add these permissions to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.INTERNET" />
```

### iOS Permissions
Add these keys to `ios/Runner/Info.plist`:
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access to show weather for your current location.</string>
```

## Architecture

The app follows a clean architecture pattern:

- **Models**: Data models with JSON serialization (`lib/models/`)
- **Services**: API calls and business logic (`lib/services/`)
- **Screens**: Main app screens (`lib/screens/`)
- **Widgets**: Reusable UI components (`lib/widgets/`)

## Weather Data

Weather data is provided by [OpenWeatherMap API](https://openweathermap.org/api), which offers:
- Current weather conditions
- 5-day/3-hour forecast
- Geocoding for city search
- Weather icons and descriptions

## Contributing

Feel free to contribute to this project by:
1. Forking the repository
2. Creating a feature branch
3. Making your changes
4. Submitting a pull request

## License

This project is open source and available under the [MIT License](LICENSE).
