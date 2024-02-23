import 'package:flutter/material.dart';
import 'package:test_application_1/widgets/divider.dart';

class WeatherItem extends StatelessWidget {
  final String label;
  final String value;
  final Icon? icon;

  const WeatherItem(
      {super.key, required this.label, required this.value, this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          label,
        ),
        const CustomDivider(),
        icon ?? Container(),
        const CustomDivider(),
        Text(
          value,
        ),
      ],
    );
  }
}
