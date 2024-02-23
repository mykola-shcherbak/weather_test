import 'package:test_application_1/data/model/weather_model.dart';

abstract class WeatherState {}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  WeatherLoaded({required this.weather});
}

class WeatherError extends WeatherState {
  final int errorCode;

  WeatherError({required this.errorCode});
}
