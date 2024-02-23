import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_application_1/bloc/task_cubit/task_cubit.dart';
import 'package:test_application_1/screens/create_task.dart';
import 'package:test_application_1/screens/home_screen.dart';
import 'package:test_application_1/screens/tasks_screan.dart';
import 'package:test_application_1/screens/weather_screen.dart';

final GoRouter router =
    GoRouter(initialLocation: HomeScrean.path, routes: <RouteBase>[
  GoRoute(
      path: HomeScrean.path,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScrean();
      },
      routes: <RouteBase>[
        GoRoute(
          path: TasksListScreen.route,
          builder: (BuildContext context, GoRouterState state) {
            return const TasksListScreen();
          },
        ),
        GoRoute(
          path: CreateTaskScreen.route,
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider(
              create: (_) => TaskCubit(),
              child: const CreateTaskScreen(),
            );
          },
        ),
        GoRoute(
          path: WeatherScreen.route,
          builder: (BuildContext context, GoRouterState state) {
            return const WeatherScreen();
          },
        ),
      ]),
]);
