# Weather App

A beautiful and modern weather application built with Flutter that provides real-time weather information, hourly forecasts, and 5-day weather predictions.

## 🌟 Features

- **Current Weather**: Get real-time weather data for your current location
- **Location Search**: Search for weather in any city worldwide
- **Hourly Forecast**: View weather predictions for the next 24 hours
- **5-Day Forecast**: See weather outlook for the next 5 days
- **Beautiful UI**: Modern gradient backgrounds that change based on time of day
- **Smooth Animations**: Engaging animations powered by flutter_animate
- **Weather Details**: Comprehensive weather information including pressure, visibility, humidity, and wind speed

## 🚀 Quick Start

### Prerequisites

- Flutter SDK (3.0.0 or later)
- Android Studio / VS Code
- An OpenWeatherMap API key (free)

### 1. Get Your API Key

1. **Sign up for a free account** at [OpenWeatherMap](https://openweathermap.org/api)
2. **Verify your email** address
3. **Go to your API keys page**: https://home.openweathermap.org/api_keys
4. **Copy your API key** (it looks like: `3f95891ff71055555e76ebadf93bfr22c15r`)

### 2. Configure the App

1. **Open** `lib/services/weather_service.dart`
2. **Find this line**:
   ```dart
   static const String _apiKey = 'your_api_key_here';
   ```
3. **Replace** `your_api_key_here` with your actual API key:
   ```dart
   static const String _apiKey = '3f95891ff71055555e76ebadf93bfr22c15r';
   ```

### 3. Install and Run

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run
```

## 🛠️ Setup Instructions

### For Web Development

If you want to run the app on the web, install Chrome or add the Chrome executable path:

```bash
# Install Chrome (Ubuntu/Debian)
sudo apt-get install google-chrome-stable

# Or set Chrome path
export CHROME_EXECUTABLE=/usr/bin/google-chrome
```

### For Linux Desktop

Install required dependencies:

```bash
# Ubuntu/Debian
sudo apt install ninja-build libgtk-3-dev

# Run the app
flutter run -d linux
```

### For Android

Make sure you have Android Studio installed with the Android SDK, or install the Android SDK separately.

## 📱 Permissions

The app requires location permissions to get weather data for your current location.

### Android Permissions

These permissions are already added to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.INTERNET" />
```

### iOS Permissions

These permissions are already added to `ios/Runner/Info.plist`:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access to show weather for your current location.</string>
```

## 🏗️ Architecture

The app follows a clean architecture pattern:

- **Models**: Data models with JSON serialization (`lib/models/`)
- **Services**: API calls and business logic (`lib/services/`)
- **Screens**: Main app screens (`lib/screens/`)
- **Widgets**: Reusable UI components (`lib/widgets/`)

## 🌤️ Weather Data

Weather data is provided by [OpenWeatherMap API](https://openweathermap.org/api), which offers:

- **Current weather conditions**
- **5-day/3-hour forecast** (free plan)
- **Hourly forecast for 48 hours** (with One Call API 3.0)
- **Geocoding for city search**
- **Weather icons and descriptions**

### API Plans

- **Free Plan**: 1,000 API calls/day, 5-day forecast with 3-hour intervals
- **One Call API 3.0**: 1,000 free calls/day, then pay-per-call, includes hourly forecasts

## 🎨 Customization

### Adding New Weather Parameters

1. Update the `Weather` model in `lib/models/weather.dart`
2. Modify the API parsing in `lib/services/weather_service.dart`
3. Update the UI components in `lib/widgets/`

### Changing the Theme

Modify the theme in `lib/main.dart`:

```dart
theme: ThemeData(
  primarySwatch: Colors.blue,
  fontFamily: 'Montserrat',
  // Add your custom theme here
),
```

## 🐛 Troubleshooting

### Common Issues

1. **"API key not configured" error**
   - Make sure you've replaced `your_api_key_here` with your actual API key
   - Restart the app after changing the API key

2. **"Location permissions denied"**
   - Grant location permissions when prompted
   - Check device location settings

3. **"Failed to load weather data"**
   - Check your internet connection
   - Verify your API key is correct and active
   - Make sure you haven't exceeded the API call limit

4. **App not running on web**
   - Install Chrome browser
   - Set the CHROME_EXECUTABLE environment variable

### Getting Help

If you encounter issues:

1. Check the [Flutter documentation](https://flutter.dev/docs)
2. Review the [OpenWeatherMap API documentation](https://openweathermap.org/api)
3. Look at the app logs for error messages

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📞 Support

If you have any questions or need help, please:

1. Check the troubleshooting section above
2. Review the existing issues on GitHub
3. Create a new issue if needed

---

**Enjoy your beautiful weather app! 🌈**
