import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_application_1/bloc/task_cubit/task_cubit.dart';
import 'package:test_application_1/bloc/tasks_list_cubit/tasks_list_cubit.dart';
import 'package:test_application_1/data/model/task_model.dart';
import 'package:test_application_1/screens/tasks_screan.dart';
import 'package:test_application_1/text_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_application_1/widgets/divider.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  static String path = '/create_task';
  static String route = 'create_task';

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  bool isNameError = true;
  bool isDescriptionError = true;
  Categories currentCategory = categories[0];

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double nameFieldHeight = height * 0.15;
    final double descriptionFieldHeight = height * 0.35;

    return Scaffold(
      appBar: AppBar(
        title: Text(TextConstants.createTask),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: BlocBuilder<TaskCubit, Task>(builder: (context, state) {
        final newTask = state;
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: nameFieldHeight,
                child: TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      hintText: TextConstants.name,
                      errorText: isNameError ? TextConstants.nameError : null,
                    ),
                    onChanged: (value) {
                      context.read<TaskCubit>().changeName(value);
                      setState(
                        () {
                          isNameError = value.isEmpty;
                        },
                      );
                    }),
              ),
              const CustomDivider(),
              SizedBox(
                height: descriptionFieldHeight,
                child: TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintText: TextConstants.description,
                      errorText: isDescriptionError
                          ? TextConstants.descriptionError
                          : null,
                    ),
                    onChanged: (value) {
                      context.read<TaskCubit>().changeDescription(value);
                      setState(
                        () {
                          isDescriptionError = value.isEmpty;
                        },
                      );
                    }),
              ),
              const CustomDivider(),
              ListTile(
                title: Text(TextConstants.personal),
                leading: Radio(
                  groupValue: currentCategory,
                  value: categories[0],
                  onChanged: (value) {
                    context.read<TaskCubit>().changeCategory(value);
                    setState(() {
                      currentCategory = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text(TextConstants.work),
                leading: Radio(
                  groupValue: currentCategory,
                  value: categories[1],
                  onChanged: (value) {
                    context.read<TaskCubit>().changeCategory(value);
                    setState(() {
                      currentCategory = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text(TextConstants.health),
                leading: Radio(
                  groupValue: currentCategory,
                  value: categories[2],
                  onChanged: (value) {
                    context.read<TaskCubit>().changeCategory(value);
                    setState(() {
                      currentCategory = value;
                    });
                  },
                ),
              ),
              const CustomDivider(),
              BlocBuilder<TasksListCubit, TasksListState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      if (!isNameError && !isDescriptionError) {
                        final task = newTask.copyWith(
                            taskId: DateTime.now().millisecond.toString());
                        context.read<TasksListCubit>().createTask(task);
                        context.go(TasksListScreen.path);
                      }
                    },
                    child: Text(TextConstants.create),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}

List categories = [Categories.personal, Categories.work, Categories.health];
