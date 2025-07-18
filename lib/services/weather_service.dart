import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../models/weather.dart';

class WeatherService {
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  
  // IMPORTANT: Replace with your actual OpenWeatherMap API key
  // Get your free API key at: https://openweathermap.org/api
  // 1. Sign up at https://home.openweathermap.org/users/sign_up
  // 2. Verify your email
  // 3. Go to https://home.openweathermap.org/api_keys
  // 4. Copy your API key and replace the placeholder below
  static const String _apiKey = 'your_api_key_here'; // Replace with your actual API key
  
  // Get current location
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }

  // Get city name from coordinates
  Future<String> getCityName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        return placemarks[0].locality ?? 'Unknown City';
      }
    } catch (e) {
      print('Error getting city name: $e');
    }
    return 'Unknown City';
  }

  // Get weather data for coordinates
  Future<Weather> getWeatherByCoordinates(double latitude, double longitude) async {
    // Check if API key is set
    if (_apiKey == 'your_api_key_here') {
      throw Exception(
        'API key not configured. Please:\n'
        '1. Get a free API key at https://openweathermap.org/api\n'
        '2. Replace "your_api_key_here" in lib/services/weather_service.dart\n'
        '3. Restart the app'
      );
    }

    try {
      // Get current weather
      final currentResponse = await http.get(
        Uri.parse('$_baseUrl/weather?lat=$latitude&lon=$longitude&appid=$_apiKey&units=metric'),
      );

      if (currentResponse.statusCode != 200) {
        throw Exception('Failed to load current weather: ${currentResponse.statusCode}');
      }

      final currentData = json.decode(currentResponse.body);

      // Get forecast data
      final forecastResponse = await http.get(
        Uri.parse('$_baseUrl/forecast?lat=$latitude&lon=$longitude&appid=$_apiKey&units=metric'),
      );

      if (forecastResponse.statusCode != 200) {
        throw Exception('Failed to load forecast: ${forecastResponse.statusCode}');
      }

      final forecastData = json.decode(forecastResponse.body);

      // Get city name
      final cityName = await getCityName(latitude, longitude);

      // Parse current weather
      final main = currentData['main'];
      final weather = currentData['weather'][0];
      final wind = currentData['wind'];

      // Parse hourly forecast (from 5-day forecast with 3-hour intervals)
      final List<HourlyForecast> hourlyForecast = [];
      final forecastList = forecastData['list'] as List;
      
      for (int i = 0; i < (forecastList.length < 8 ? forecastList.length : 8); i++) {
        final item = forecastList[i];
        hourlyForecast.add(HourlyForecast(
          time: DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000),
          temperature: item['main']['temp'].toDouble(),
          icon: item['weather'][0]['icon'],
          humidity: item['main']['humidity'],
          windSpeed: item['wind']['speed'].toDouble(),
        ));
      }

      // Parse daily forecast (group by day)
      final List<DailyForecast> dailyForecast = [];
      final Map<String, List<dynamic>> groupedByDay = {};
      
      for (final item in forecastList) {
        final date = DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000);
        final dayKey = '${date.year}-${date.month}-${date.day}';
        
        if (!groupedByDay.containsKey(dayKey)) {
          groupedByDay[dayKey] = [];
        }
        groupedByDay[dayKey]!.add(item);
      }

      for (final entry in groupedByDay.entries) {
        if (dailyForecast.length >= 5) break; // Limit to 5 days
        
        final dayData = entry.value;
        final firstItem = dayData[0];
        
        // Calculate min/max temperatures for the day
        double minTemp = dayData[0]['main']['temp'].toDouble();
        double maxTemp = dayData[0]['main']['temp'].toDouble();
        
        for (final item in dayData) {
          final temp = item['main']['temp'].toDouble();
          if (temp < minTemp) minTemp = temp;
          if (temp > maxTemp) maxTemp = temp;
        }

        dailyForecast.add(DailyForecast(
          date: DateTime.fromMillisecondsSinceEpoch(firstItem['dt'] * 1000),
          minTemperature: minTemp,
          maxTemperature: maxTemp,
          icon: firstItem['weather'][0]['icon'],
          description: firstItem['weather'][0]['description'],
        ));
      }

      return Weather(
        cityName: cityName,
        temperature: main['temp'].toDouble(),
        description: weather['description'],
        icon: weather['icon'],
        feelsLike: main['feels_like'].toDouble(),
        humidity: main['humidity'],
        windSpeed: wind['speed'].toDouble(),
        pressure: main['pressure'],
        visibility: (currentData['visibility'] / 1000).toDouble(), // Convert to km
        uvIndex: 0, // UV index not available in free plan
        hourlyForecast: hourlyForecast,
        dailyForecast: dailyForecast,
      );
    } catch (e) {
      throw Exception('Error fetching weather data: $e');
    }
  }

  // Get weather data by city name
  Future<Weather> getWeatherByCity(String cityName) async {
    try {
      List<Location> locations = await locationFromAddress(cityName);
      if (locations.isNotEmpty) {
        final location = locations[0];
        return await getWeatherByCoordinates(location.latitude, location.longitude);
      } else {
        throw Exception('City not found');
      }
    } catch (e) {
      throw Exception('Error fetching weather for city: $e');
    }
  }
}