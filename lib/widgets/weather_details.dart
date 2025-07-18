import 'package:flutter/material.dart';
import '../models/weather.dart';

class WeatherDetails extends StatelessWidget {
  final Weather weather;

  const WeatherDetails({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  'Pressure',
                  '${weather.pressure} hPa',
                  Icons.speed,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildDetailItem(
                  'Visibility',
                  '${weather.visibility.toStringAsFixed(1)} km',
                  Icons.visibility,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  'Humidity',
                  '${weather.humidity}%',
                  Icons.water_drop,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildDetailItem(
                  'Wind Speed',
                  '${weather.windSpeed.toStringAsFixed(1)} m/s',
                  Icons.air,
                ),
              ),
            ],
          ),
          if (weather.uvIndex > 0) ...[
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    'UV Index',
                    '${weather.uvIndex}',
                    Icons.wb_sunny,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildDetailItem(
                    'Feels Like',
                    '${weather.feelsLike.round()}°',
                    Icons.thermostat,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
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
      ),
    );
  }
}