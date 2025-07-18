import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../models/weather.dart';

class WeatherService {
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String _apiKey = 'your_api_key_here'; // Replace with your OpenWeatherMap API key
  
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
    try {
      final cityName = await getCityName(latitude, longitude);
      
      // Get current weather
      final currentWeatherUrl = '$_baseUrl/weather?lat=$latitude&lon=$longitude&appid=$_apiKey&units=metric';
      final currentResponse = await http.get(Uri.parse(currentWeatherUrl));
      
      if (currentResponse.statusCode != 200) {
        throw Exception('Failed to load current weather data');
      }
      
      final currentData = json.decode(currentResponse.body);
      
      // Get forecast data
      final forecastUrl = '$_baseUrl/forecast?lat=$latitude&lon=$longitude&appid=$_apiKey&units=metric';
      final forecastResponse = await http.get(Uri.parse(forecastUrl));
      
      if (forecastResponse.statusCode != 200) {
        throw Exception('Failed to load forecast data');
      }
      
      final forecastData = json.decode(forecastResponse.body);
      
      // Parse hourly forecast (next 24 hours)
      final hourlyForecast = <HourlyForecast>[];
      for (int i = 0; i < 8 && i < forecastData['list'].length; i++) {
        final item = forecastData['list'][i];
        hourlyForecast.add(HourlyForecast(
          time: DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000),
          temperature: item['main']['temp'].toDouble(),
          icon: item['weather'][0]['icon'],
          humidity: item['main']['humidity'],
          windSpeed: item['wind']['speed'].toDouble(),
        ));
      }
      
      // Parse daily forecast (next 5 days)
      final dailyForecast = <DailyForecast>[];
      final Map<String, List<dynamic>> dailyData = {};
      
      for (final item in forecastData['list']) {
        final date = DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000);
        final dateKey = '${date.year}-${date.month}-${date.day}';
        
        if (!dailyData.containsKey(dateKey)) {
          dailyData[dateKey] = [];
        }
        dailyData[dateKey]!.add(item);
      }
      
      dailyData.forEach((dateKey, items) {
        if (dailyForecast.length < 5) {
          final temps = items.map((item) => item['main']['temp'].toDouble()).toList();
          final maxTemp = temps.reduce((a, b) => a > b ? a : b);
          final minTemp = temps.reduce((a, b) => a < b ? a : b);
          
          // Use the middle item for other data
          final middleItem = items[items.length ~/ 2];
          
          dailyForecast.add(DailyForecast(
            date: DateTime.fromMillisecondsSinceEpoch(middleItem['dt'] * 1000),
            maxTemp: maxTemp,
            minTemp: minTemp,
            description: middleItem['weather'][0]['description'],
            icon: middleItem['weather'][0]['icon'],
            humidity: middleItem['main']['humidity'],
            windSpeed: middleItem['wind']['speed'].toDouble(),
          ));
        }
      });
      
      return Weather(
        cityName: cityName,
        temperature: currentData['main']['temp'].toDouble(),
        description: currentData['weather'][0]['description'],
        icon: currentData['weather'][0]['icon'],
        feelsLike: currentData['main']['feels_like'].toDouble(),
        humidity: currentData['main']['humidity'],
        windSpeed: currentData['wind']['speed'].toDouble(),
        pressure: currentData['main']['pressure'],
        visibility: currentData['visibility'].toDouble() / 1000, // Convert to km
        uvIndex: 0, // UV index not available in free tier
        hourlyForecast: hourlyForecast,
        dailyForecast: dailyForecast,
      );
    } catch (e) {
      print('Error fetching weather data: $e');
      throw Exception('Failed to fetch weather data: $e');
    }
  }

  // Get weather data for a city name
  Future<Weather> getWeatherByCity(String cityName) async {
    try {
      final geocodingUrl = 'http://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=1&appid=$_apiKey';
      final geocodingResponse = await http.get(Uri.parse(geocodingUrl));
      
      if (geocodingResponse.statusCode != 200) {
        throw Exception('Failed to get city coordinates');
      }
      
      final geocodingData = json.decode(geocodingResponse.body);
      if (geocodingData.isEmpty) {
        throw Exception('City not found');
      }
      
      final latitude = geocodingData[0]['lat'].toDouble();
      final longitude = geocodingData[0]['lon'].toDouble();
      
      return await getWeatherByCoordinates(latitude, longitude);
    } catch (e) {
      print('Error fetching weather by city: $e');
      throw Exception('Failed to fetch weather data: $e');
    }
  }

  // Search for cities
  Future<List<Location>> searchCities(String query) async {
    try {
      final geocodingUrl = 'http://api.openweathermap.org/geo/1.0/direct?q=$query&limit=5&appid=$_apiKey';
      final response = await http.get(Uri.parse(geocodingUrl));
      
      if (response.statusCode != 200) {
        throw Exception('Failed to search cities');
      }
      
      final data = json.decode(response.body);
      return data.map<Location>((item) => Location(
        name: item['name'],
        latitude: item['lat'].toDouble(),
        longitude: item['lon'].toDouble(),
        country: item['country'],
        state: item['state'],
      )).toList();
    } catch (e) {
      print('Error searching cities: $e');
      return [];
    }
  }
}