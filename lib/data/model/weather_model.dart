import 'package:flutter/material.dart';
import 'package:test_application_1/utils/temperature_convertor.dart';
import 'package:test_application_1/utils/weather_icons.dart';

class Weather {
  int id;
  int time;
  int sunrise;
  int sunset;
  int humidity;
  String description;
  String iconCode;
  String main;
  String cityName;
  double windSpeed;
  Temperature temperature;
  Temperature maxTemperature;
  Temperature minTemperature;

  Weather({
    required this.id,
    required this.time,
    required this.sunrise,
    required this.sunset,
    required this.humidity,
    required this.description,
    required this.iconCode,
    required this.main,
    required this.cityName,
    required this.windSpeed,
    required this.temperature,
    required this.maxTemperature,
    required this.minTemperature,
  });

  static Weather fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    return Weather(
      id: weather['id'],
      time: json['dt'],
      description: weather['description'],
      iconCode: weather['icon'],
      main: weather['main'],
      cityName: json['name'],
      temperature: Temperature(intToDouble(json['main']['temp'])),
      maxTemperature: Temperature(intToDouble(json['main']['temp_max'])),
      minTemperature: Temperature(intToDouble(json['main']['temp_min'])),
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      humidity: json['main']['humidity'],
      windSpeed: intToDouble(json['wind']['speed']),
    );
  }

  IconData getIconData() {
    switch (iconCode) {
      case '01d':
        return WeatherIcons.clearDay;
      case '01n':
        return WeatherIcons.clearNight;
      case '02d':
        return WeatherIcons.fewCloudsDay;
      case '02n':
        return WeatherIcons.fewCloudsDay;
      case '03d':
      case '04d':
        return WeatherIcons.cloudsDay;
      case '03n':
      case '04n':
        return WeatherIcons.clearNight;
      case '09d':
        return WeatherIcons.showerRainDay;
      case '09n':
        return WeatherIcons.showerRainNight;
      case '10d':
        return WeatherIcons.rainDay;
      case '10n':
        return WeatherIcons.rainNight;
      case '11d':
        return WeatherIcons.thunderStormDay;
      case '11n':
        return WeatherIcons.thunderStormNight;
      case '13d':
        return WeatherIcons.snowDay;
      case '13n':
        return WeatherIcons.snowNight;
      case '50d':
        return WeatherIcons.mistDay;
      case '50n':
        return WeatherIcons.mistNight;
      default:
        return WeatherIcons.clearDay;
    }
  }
}
