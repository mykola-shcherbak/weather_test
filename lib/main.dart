import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_application_1/bloc/weather_cubit/weather_block.dart';
import 'package:test_application_1/data/api/api_key.dart';
import 'package:test_application_1/data/api/weather_api.dart';
import 'package:test_application_1/data/repository/weather_repository.dart';
import 'package:test_application_1/router.dart';
import 'package:http/http.dart' as http;

import 'bloc/tasks_list_cubit/tasks_list_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
      apiKey: ApiKey.openWeatherMap,
    ),
  );
  runApp(MyApp(prefs: prefs, weatherRepository: weatherRepository));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  SharedPreferences prefs;
  WeatherRepository weatherRepository;

  MyApp({super.key, required this.prefs, required this.weatherRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TasksListCubit(prefs)..fetchTasks(),
        ),
        BlocProvider(
          create: (context) =>
              WeatherBloc(weatherRepository: weatherRepository),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
