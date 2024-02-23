abstract class WeatherEvent {}

class FetchWeather extends WeatherEvent {
  final double longitude;
  final double latitude;

  FetchWeather({this.longitude = 0, this.latitude = 0});
}
