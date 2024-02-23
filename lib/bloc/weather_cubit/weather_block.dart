import 'package:bloc/bloc.dart';
import 'package:test_application_1/bloc/weather_cubit/wather_state.dart';
import 'package:test_application_1/bloc/weather_cubit/weather_event.dart';
import 'package:test_application_1/data/api/weather_api.dart';

import 'package:test_application_1/data/model/weather_model.dart';
import 'package:test_application_1/data/repository/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository}) : super(WeatherEmpty()) {
    on<FetchWeather>((event, emit) async {
      try {
        final Weather weather = await weatherRepository.getWeather(
            latitude: event.latitude, longitude: event.longitude);
        emit(WeatherLoaded(weather: weather));
      } catch (exception) {
        if (exception is HTTPException) {
          emit(WeatherError(errorCode: exception.code));
        } else {
          emit(WeatherError(errorCode: 500));
        }
      }
    });
  }
}
