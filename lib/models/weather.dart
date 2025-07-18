import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final int pressure;
  final double visibility;
  final int uvIndex;
  final List<HourlyForecast> hourlyForecast;
  final List<DailyForecast> dailyForecast;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.visibility,
    required this.uvIndex,
    required this.hourlyForecast,
    required this.dailyForecast,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable()
class HourlyForecast {
  final DateTime time;
  final double temperature;
  final String icon;
  final int humidity;
  final double windSpeed;

  HourlyForecast({
    required this.time,
    required this.temperature,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) => _$HourlyForecastFromJson(json);
  Map<String, dynamic> toJson() => _$HourlyForecastToJson(this);
}

@JsonSerializable()
class DailyForecast {
  final DateTime date;
  final double maxTemp;
  final double minTemp;
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;

  DailyForecast({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) => _$DailyForecastFromJson(json);
  Map<String, dynamic> toJson() => _$DailyForecastToJson(this);
}

@JsonSerializable()
class Location {
  final String name;
  final double latitude;
  final double longitude;
  final String country;
  final String? state;

  Location({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.country,
    this.state,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}