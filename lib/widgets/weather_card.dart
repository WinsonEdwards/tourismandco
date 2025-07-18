import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/weather.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({Key? key, required this.weather}) : super(key: key);

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
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            weather.cityName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            DateFormat('EEEE, MMMM d').format(DateTime.now()),
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _getWeatherIcon(weather.icon),
                style: TextStyle(fontSize: 80),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${weather.temperature.round()}°',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 64,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    weather.description.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildWeatherInfo(
                'Feels Like',
                '${weather.feelsLike.round()}°',
                Icons.thermostat,
              ),
              _buildWeatherInfo(
                'Humidity',
                '${weather.humidity}%',
                Icons.water_drop,
              ),
              _buildWeatherInfo(
                'Wind',
                '${weather.windSpeed.round()} m/s',
                Icons.air,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherInfo(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white70,
          size: 24,
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}