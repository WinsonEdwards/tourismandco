import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';
import '../widgets/weather_card.dart';
import '../widgets/hourly_forecast.dart';
import '../widgets/daily_forecast.dart';
import '../widgets/weather_details.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService _weatherService = WeatherService();
  Weather? _weather;
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _loadWeatherData();
  }

  Future<void> _loadWeatherData() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final position = await _weatherService.getCurrentLocation();
      final weather = await _weatherService.getWeatherByCoordinates(
        position.latitude,
        position.longitude,
      );
      
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Widget _buildGradientBackground() {
    final now = DateTime.now();
    final hour = now.hour;
    
    List<Color> colors;
    if (hour >= 6 && hour < 12) {
      // Morning
      colors = [Color(0xFF74b9ff), Color(0xFF0984e3)];
    } else if (hour >= 12 && hour < 18) {
      // Afternoon
      colors = [Color(0xFF00b894), Color(0xFF00a085)];
    } else if (hour >= 18 && hour < 21) {
      // Evening
      colors = [Color(0xFFfd79a8), Color(0xFFe84393)];
    } else {
      // Night
      colors = [Color(0xFF2d3436), Color(0xFF636e72)];
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Weather'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
              if (result != null) {
                setState(() {
                  _weather = result;
                });
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadWeatherData,
          ),
        ],
      ),
      body: Stack(
        children: [
          _buildGradientBackground(),
          SafeArea(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : _error.isNotEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Colors.white70,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Error loading weather data',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              _error,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: _loadWeatherData,
                              child: Text('Retry'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.blue,
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    : _weather == null
                        ? Center(
                            child: Text(
                              'No weather data available',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: _loadWeatherData,
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  WeatherCard(weather: _weather!)
                                      .animate()
                                      .fadeIn(duration: 600.ms)
                                      .slideY(begin: 0.3, end: 0),
                                  SizedBox(height: 24),
                                  Text(
                                    'Hourly Forecast',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ).animate().fadeIn(delay: 300.ms),
                                  SizedBox(height: 16),
                                  HourlyForecast(forecast: _weather!.hourlyForecast)
                                      .animate()
                                      .fadeIn(delay: 400.ms)
                                      .slideX(begin: 0.3, end: 0),
                                  SizedBox(height: 24),
                                  Text(
                                    'Daily Forecast',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ).animate().fadeIn(delay: 500.ms),
                                  SizedBox(height: 16),
                                  DailyForecast(forecast: _weather!.dailyForecast)
                                      .animate()
                                      .fadeIn(delay: 600.ms)
                                      .slideY(begin: 0.3, end: 0),
                                  SizedBox(height: 24),
                                  Text(
                                    'Weather Details',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ).animate().fadeIn(delay: 700.ms),
                                  SizedBox(height: 16),
                                  WeatherDetails(weather: _weather!)
                                      .animate()
                                      .fadeIn(delay: 800.ms)
                                      .slideY(begin: 0.3, end: 0),
                                  SizedBox(height: 40),
                                ],
                              ),
                            ),
                          ),
          ),
        ],
      ),
    );
  }
}