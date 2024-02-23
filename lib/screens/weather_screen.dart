import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_application_1/bloc/weather_cubit/wather_state.dart';
import 'package:test_application_1/bloc/weather_cubit/weather_block.dart';
import 'package:test_application_1/bloc/weather_cubit/weather_event.dart';
import 'package:test_application_1/text_constants.dart';
import 'package:test_application_1/widgets/weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  static String path = '/weather';
  static String route = 'weather';

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>
    with TickerProviderStateMixin {
  late WeatherBloc _weatherBloc;

  @override
  void initState() {
    super.initState();

    _weatherBloc = BlocProvider.of<WeatherBloc>(context);

    _fetchWeatherWithLocation().catchError((error) {
      _weatherBloc.add(FetchWeather());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TextConstants.weather),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Material(
        child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (_, WeatherState weatherState) {
          if (weatherState is WeatherLoaded) {
            return Column(
              children: [
                WeatherWidget(
                  weather: weatherState.weather,
                ),
              ],
            );
          } else {
            return Center(child: Text(TextConstants.loading));
          }
        }),
      ),
    );
  }

  _fetchWeatherWithLocation() async {
    var permissionResult = await Permission.locationWhenInUse.status;

    switch (permissionResult) {
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        _showLocationDeniedDialog();
        break;

      case PermissionStatus.denied:
        await Permission.locationWhenInUse.request();
        _fetchWeatherWithLocation();
        break;

      case PermissionStatus.limited:
      case PermissionStatus.granted:
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low,
            timeLimit: const Duration(seconds: 2));

        _weatherBloc.add(FetchWeather(
          longitude: position.longitude,
          latitude: position.latitude,
        ));
        break;
      case PermissionStatus.provisional:
    }
  }

  void _showLocationDeniedDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(TextConstants.locationDisabled),
            actions: <Widget>[
              TextButton(
                child: Text(TextConstants.enable),
                onPressed: () {
                  openAppSettings();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
