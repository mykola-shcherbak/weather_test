import 'package:flutter/material.dart';
import 'package:test_application_1/data/model/weather_model.dart';
import 'package:test_application_1/widgets/divider.dart';
import 'package:test_application_1/widgets/weathet_item.dart';

class Temperature extends StatelessWidget {
  final Weather weather;
  const Temperature({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    String currentTemperature = weather.temperature.celsius.round().toString();
    String maxTemperature = weather.maxTemperature.celsius.round().toString();
    String minTemperature = weather.minTemperature.celsius.round().toString();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          weather.getIconData(),
          size: 70,
        ),
        const CustomDivider(),
        Text(
          currentTemperature.toString(),
          style: const TextStyle(
            fontSize: 100,
            fontWeight: FontWeight.w100,
          ),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              WeatherItem(label: "max", value: maxTemperature),
              WeatherItem(label: "min", value: minTemperature),
            ]),
      ],
    );
  }
}
