// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      cityName: json['cityName'] as String,
      temperature: (json['temperature'] as num).toDouble(),
      description: json['description'] as String,
      icon: json['icon'] as String,
      feelsLike: (json['feelsLike'] as num).toDouble(),
      humidity: json['humidity'] as int,
      windSpeed: (json['windSpeed'] as num).toDouble(),
      pressure: json['pressure'] as int,
      visibility: (json['visibility'] as num).toDouble(),
      uvIndex: json['uvIndex'] as int,
      hourlyForecast: (json['hourlyForecast'] as List<dynamic>)
          .map((e) => HourlyForecast.fromJson(e as Map<String, dynamic>))
          .toList(),
      dailyForecast: (json['dailyForecast'] as List<dynamic>)
          .map((e) => DailyForecast.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'cityName': instance.cityName,
      'temperature': instance.temperature,
      'description': instance.description,
      'icon': instance.icon,
      'feelsLike': instance.feelsLike,
      'humidity': instance.humidity,
      'windSpeed': instance.windSpeed,
      'pressure': instance.pressure,
      'visibility': instance.visibility,
      'uvIndex': instance.uvIndex,
      'hourlyForecast': instance.hourlyForecast,
      'dailyForecast': instance.dailyForecast,
    };

HourlyForecast _$HourlyForecastFromJson(Map<String, dynamic> json) =>
    HourlyForecast(
      time: DateTime.parse(json['time'] as String),
      temperature: (json['temperature'] as num).toDouble(),
      icon: json['icon'] as String,
      humidity: json['humidity'] as int,
      windSpeed: (json['windSpeed'] as num).toDouble(),
    );

Map<String, dynamic> _$HourlyForecastToJson(HourlyForecast instance) =>
    <String, dynamic>{
      'time': instance.time.toIso8601String(),
      'temperature': instance.temperature,
      'icon': instance.icon,
      'humidity': instance.humidity,
      'windSpeed': instance.windSpeed,
    };

DailyForecast _$DailyForecastFromJson(Map<String, dynamic> json) =>
    DailyForecast(
      date: DateTime.parse(json['date'] as String),
      maxTemp: (json['maxTemp'] as num).toDouble(),
      minTemp: (json['minTemp'] as num).toDouble(),
      description: json['description'] as String,
      icon: json['icon'] as String,
      humidity: json['humidity'] as int,
      windSpeed: (json['windSpeed'] as num).toDouble(),
    );

Map<String, dynamic> _$DailyForecastToJson(DailyForecast instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'maxTemp': instance.maxTemp,
      'minTemp': instance.minTemp,
      'description': instance.description,
      'icon': instance.icon,
      'humidity': instance.humidity,
      'windSpeed': instance.windSpeed,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      country: json['country'] as String,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'country': instance.country,
      'state': instance.state,
    };