import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:test_application_1/data/model/weather_model.dart';

class WeatherApiClient {
  static const baseUrl = 'http://api.openweathermap.org';
  final String apiKey;
  final http.Client httpClient;

  WeatherApiClient({required this.httpClient, required this.apiKey});

  Uri _buildUri(String endpoint, Map<String, String> queryParameters) {
    var query = {'appid': apiKey};
    query = query..addAll(queryParameters);

    var uri = Uri(
      scheme: 'http',
      host: 'api.openweathermap.org',
      path: 'data/2.5/$endpoint',
      queryParameters: query,
    );

    return uri;
  }

  Future<String> getCityNameFromLocation(
      {required double latitude, required double longitude}) async {
    final uri = _buildUri('weather', {
      'lat': latitude.toString(),
      'lon': longitude.toString(),
    });

    final res = await httpClient.get(uri);

    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }

    final weatherJson = json.decode(res.body);
    return weatherJson['name'];
  }

  Future<Weather> getWeatherData(String cityName) async {
    final Uri uri = _buildUri('weather', {'q': cityName});

    final Response res = await httpClient.get(uri);

    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }

    final weatherJson = json.decode(res.body);
    return Weather.fromJson(weatherJson);
  }
}

class HTTPException implements Exception {
  final int code;
  final String message;

  HTTPException(this.code, this.message);

  @override
  String toString() {
    return 'HTTPException{code: $code, message: $message}';
  }
}
