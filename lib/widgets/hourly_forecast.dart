import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/weather.dart';

class HourlyForecast extends StatelessWidget {
  final List<HourlyForecast> forecast;

  const HourlyForecast({Key? key, required this.forecast}) : super(key: key);

  String _getWeatherIcon(String iconCode) {
    switch (iconCode) {
      case '01d':
      case '01n':
        return '☀️';
      case '02d':
      case '02n':
        return '⛅';
      case '03d':
      case '03n':
        return '☁️';
      case '04d':
      case '04n':
        return '☁️';
      case '09d':
      case '09n':
        return '🌧️';
      case '10d':
      case '10n':
        return '🌦️';
      case '11d':
      case '11n':
        return '⛈️';
      case '13d':
      case '13n':
        return '🌨️';
      case '50d':
      case '50n':
        return '🌫️';
      default:
        return '☀️';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.length,
        itemBuilder: (context, index) {
          final hourlyWeather = forecast[index];
          final isNow = index == 0;
          
          return Container(
            width: 80,
            margin: EdgeInsets.only(right: 16),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isNow 
                  ? Colors.white.withOpacity(0.3)
                  : Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  isNow ? 'Now' : DateFormat('HH:mm').format(hourlyWeather.time),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  _getWeatherIcon(hourlyWeather.icon),
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  '${hourlyWeather.temperature.round()}°',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.water_drop,
                      color: Colors.white70,
                      size: 12,
                    ),
                    SizedBox(width: 2),
                    Text(
                      '${hourlyWeather.humidity}%',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}