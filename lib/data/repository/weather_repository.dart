import 'package:test_application_1/data/api/weather_api.dart';
import 'package:test_application_1/data/model/weather_model.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;
  WeatherRepository({required this.weatherApiClient});

  Future<Weather> getWeather(
      {required double latitude, required double longitude}) async {
    String cityName = await weatherApiClient.getCityNameFromLocation(
        latitude: latitude, longitude: longitude);
    var weather = await weatherApiClient.getWeatherData(cityName);
    return weather;
  }
}
