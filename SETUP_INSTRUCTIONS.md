# Weather App Setup Instructions

## Prerequisites

1. **Flutter SDK**: Install Flutter from [flutter.dev](https://flutter.dev/docs/get-started/install)
2. **Android Studio** or **VS Code** with Flutter extensions
3. **OpenWeatherMap API Key**: Sign up at [openweathermap.org](https://openweathermap.org/api)

## Quick Setup

### Option 1: Using the Setup Script (Recommended)

1. Run the setup script:
   ```bash
   ./setup.sh
   ```

2. Get your API key from OpenWeatherMap and replace it in `lib/services/weather_service.dart`:
   ```dart
   static const String _apiKey = 'your_actual_api_key_here';
   ```

3. Run the app:
   ```bash
   flutter run
   ```

### Option 2: Manual Setup

1. **Install Flutter** (if not already installed):
   ```bash
   # Download Flutter
   git clone https://github.com/flutter/flutter.git -b stable
   
   # Add to PATH
   export PATH="$PATH:`pwd`/flutter/bin"
   
   # Verify installation
   flutter doctor
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Generate JSON serialization code**:
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Configure API Key**:
   - Sign up at [OpenWeatherMap](https://openweathermap.org/api)
   - Get your free API key
   - Open `lib/services/weather_service.dart`
   - Replace `your_api_key_here` with your actual API key

5. **Run the app**:
   ```bash
   flutter run
   ```

## Features

✅ **Current Weather**: Real-time weather data for your location  
✅ **City Search**: Search for weather in any city worldwide  
✅ **Hourly Forecast**: 24-hour weather predictions  
✅ **5-Day Forecast**: Extended weather outlook  
✅ **Beautiful UI**: Time-based gradient backgrounds  
✅ **Smooth Animations**: Engaging user experience  
✅ **Weather Details**: Comprehensive weather information  

## App Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   ├── weather.dart         # Weather data models
│   └── weather.g.dart       # Generated JSON serialization
├── services/
│   └── weather_service.dart # API calls and location services
├── screens/
│   ├── home_screen.dart     # Main weather screen
│   └── search_screen.dart   # City search screen
└── widgets/
    ├── weather_card.dart    # Current weather display
    ├── hourly_forecast.dart # Hourly forecast widget
    ├── daily_forecast.dart  # Daily forecast widget
    └── weather_details.dart # Additional weather info
```

## API Integration

The app uses the OpenWeatherMap API for weather data:

- **Current Weather**: `https://api.openweathermap.org/data/2.5/weather`
- **5-Day Forecast**: `https://api.openweathermap.org/data/2.5/forecast`
- **Geocoding**: `https://api.openweathermap.org/geo/1.0/direct`

## Permissions

The app requires location permissions to get weather data for your current location:

### Android
Permissions are automatically added to `android/app/src/main/AndroidManifest.xml`:
- `ACCESS_FINE_LOCATION`
- `ACCESS_COARSE_LOCATION`
- `INTERNET`

### iOS
Permission description is added to `ios/Runner/Info.plist`:
- `NSLocationWhenInUseUsageDescription`

## Troubleshooting

### Common Issues

1. **"Flutter command not found"**
   - Make sure Flutter is installed and added to your PATH
   - Run `flutter doctor` to check installation

2. **"API key not working"**
   - Verify your API key is correct
   - Make sure you've activated your API key (may take a few minutes)
   - Check that you're using the correct API endpoints

3. **"Location permissions denied"**
   - Grant location permissions when prompted
   - Check device location settings
   - For Android: Go to Settings > Apps > Weather App > Permissions

4. **"Build errors"**
   - Run `flutter clean` and `flutter pub get`
   - Regenerate code with `flutter packages pub run build_runner build --delete-conflicting-outputs`

### Debug Mode

To run in debug mode with verbose output:
```bash
flutter run --verbose
```

To check for issues:
```bash
flutter doctor -v
```

## Customization

### Changing Colors
Edit the gradient colors in `lib/screens/home_screen.dart` in the `_buildGradientBackground()` method.

### Adding New Weather Data
1. Update the `Weather` model in `lib/models/weather.dart`
2. Regenerate JSON serialization: `flutter packages pub run build_runner build`
3. Update the API parsing in `lib/services/weather_service.dart`
4. Add UI components to display the new data

### Changing API Provider
1. Update the API endpoints in `lib/services/weather_service.dart`
2. Modify the data parsing logic to match the new API response format
3. Update the API key configuration

## Performance Tips

- The app caches location data to reduce API calls
- Weather data is refreshed when the user pulls down or taps refresh
- Images and icons are cached automatically by Flutter

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is open source and available under the MIT License.