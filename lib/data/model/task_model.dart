import 'package:test_application_1/bloc/task_cubit/task_cubit.dart';

class Task {
  final String taskId;
  final String name;
  final Statuses status;
  final Categories category;
  final String description;

  const Task({
    required this.taskId,
    required this.status,
    required this.name,
    required this.category,
    required this.description,
  });

  Task copyWith({
    String? taskId,
    Statuses? status,
    String? name,
    Categories? category,
    String? description,
  }) {
    return Task(
      taskId: taskId ?? this.taskId,
      status: status ?? this.status,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() => {
        'taskId': taskId,
        'status': status.toString(),
        'name': name,
        'category': category.toString(),
        'description': description,
      };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        taskId: json['taskId'],
        status:
            Statuses.values.firstWhere((e) => e.toString() == json['status']),
        name: json['name'],
        category: Categories.values
            .firstWhere((e) => e.toString() == json['category']),
        description: json['description'],
      );
}
