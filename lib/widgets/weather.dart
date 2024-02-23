import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_application_1/data/model/weather_model.dart';
import 'package:test_application_1/text_constants.dart';
import 'package:test_application_1/utils/weather_icons.dart';
import 'package:test_application_1/widgets/divider.dart';
import 'package:test_application_1/widgets/temperature.dart';
import 'package:test_application_1/widgets/weathet_item.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;

  const WeatherWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            DateFormat('EEEE, d MMMM').format(DateTime.now()),
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            weather.cityName.toUpperCase(),
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            weather.description.toUpperCase(),
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          Temperature(weather: weather),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WeatherItem(
                label: TextConstants.sunrise,
                value: DateFormat('h:m a').format(
                  DateTime.fromMillisecondsSinceEpoch(weather.sunrise * 1000),
                ),
                icon: const Icon(Icons.sunny),
              ),
              const CustomDivider(isHorizontal: true),
              WeatherItem(
                label: TextConstants.sunset,
                value: DateFormat('h:m a').format(
                  DateTime.fromMillisecondsSinceEpoch(weather.sunset * 1000),
                ),
                icon: const Icon(WeatherIcons.clearNight),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WeatherItem(
                label: TextConstants.windSpeed,
                value: '${weather.windSpeed} m/s',
                icon: const Icon(Icons.wind_power_outlined),
              ),
              const CustomDivider(isHorizontal: true),
              WeatherItem(
                label: TextConstants.humidity,
                value: '${weather.humidity}%',
                icon: const Icon(Icons.water_drop_rounded),
              ),
            ],
          ),
          const CustomDivider(),
        ],
      ),
    );
  }
}
