import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/weather.dart';

class DailyForecast extends StatelessWidget {
  final List<DailyForecast> forecast;

  const DailyForecast({Key? key, required this.forecast}) : super(key: key);

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
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: forecast.map((dailyWeather) {
          final isToday = DateFormat('yyyy-MM-dd').format(dailyWeather.date) ==
              DateFormat('yyyy-MM-dd').format(DateTime.now());
          
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    isToday ? 'Today' : DateFormat('EEEE').format(dailyWeather.date),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Text(
                        _getWeatherIcon(dailyWeather.icon),
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          dailyWeather.description,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${dailyWeather.minTemp.round()}°',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '${dailyWeather.maxTemp.round()}°',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}