import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_application_1/screens/tasks_screan.dart';
import 'package:test_application_1/screens/weather_screen.dart';
import 'package:test_application_1/text_constants.dart';
import 'package:test_application_1/widgets/divider.dart';

class HomeScrean extends StatelessWidget {
  const HomeScrean({super.key});

  static String path = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  context.push(TasksListScreen.path);
                },
                child: Text(TextConstants.tasks),
              ),
              const CustomDivider(),
              TextButton(
                onPressed: () {
                  context.push(WeatherScreen.path);
                },
                child: Text(TextConstants.weather),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
