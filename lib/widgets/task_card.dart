import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_application_1/bloc/task_cubit/task_cubit.dart';
import 'package:test_application_1/bloc/tasks_list_cubit/tasks_list_cubit.dart';
import 'package:test_application_1/data/model/task_model.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Checkbox(
                value: task.status == Statuses.inProcess ? false : true,
                onChanged: (value) {
                  final Statuses status =
                      value == true ? Statuses.completed : Statuses.inProcess;
                  context
                      .read<TasksListCubit>()
                      .changeStatusById(status, task.taskId);
                },
              ),
              Icon(task.category == Categories.work
                  ? Icons.work_history
                  : task.category == Categories.personal
                      ? Icons.person
                      : Icons.health_and_safety),
            ],
          ),
          Column(
            children: [
              Text(
                task.name,
                style: const TextStyle(fontSize: 24),
              ),
              Text(task.description),
            ],
          ),
          IconButton(
            onPressed: () {
              context.read<TasksListCubit>().removeTaskById(task.taskId);
            },
            icon: const Icon(Icons.delete_sharp),
          ),
        ],
      ),
    );
  }
}
