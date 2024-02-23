import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_application_1/bloc/task_cubit/task_cubit.dart';
import 'package:test_application_1/bloc/tasks_list_cubit/tasks_list_cubit.dart';
import 'package:test_application_1/data/model/task_model.dart';
import 'package:test_application_1/screens/create_task.dart';
import 'package:test_application_1/text_constants.dart';
import 'package:test_application_1/widgets/divider.dart';
import 'package:test_application_1/widgets/task_card.dart';

class TasksListScreen extends StatelessWidget {
  const TasksListScreen({super.key});

  static String path = '/tasks_list';
  static String route = 'tasks_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TextConstants.tasks),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: BlocBuilder<TasksListCubit, TasksListState>(
          builder: (context, state) {
            final List<Task> taskList = state.filteredTasks;
            final List<Categories> selecedCategories = state.selecedCategories;
            final List<Statuses> selectedStatuses = state.selectedStatuses;
            return Column(
              children: [
                Text(TextConstants.chooseCategories),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: categoriesFilters
                      .map(
                        (filter) => FilterChip(
                          label: filter.icon,
                          selected: selecedCategories.contains(filter.category),
                          onSelected: (selected) {
                            context
                                .read<TasksListCubit>()
                                .editCategoriesFilters(filter.category);
                          },
                          avatar: const Text('  '),
                        ),
                      )
                      .toList(),
                ),
                Text(TextConstants.chooseStatus),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: statusesFilters
                      .map(
                        (filter) => FilterChip(
                          label: filter.icon,
                          selected: selectedStatuses.contains(filter.status),
                          onSelected: (selected) {
                            context
                                .read<TasksListCubit>()
                                .editStatusesFilters(filter.status);
                          },
                          avatar: const Text('  '),
                        ),
                      )
                      .toList(),
                ),
                const CustomDivider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: taskList.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return TaskCard(task: taskList[index]);
                    },
                  ),
                ),
                Center(
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                      size: 32,
                    ),
                    onPressed: () {
                      context.push(CreateTaskScreen.path);
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class CategoriesFilter {
  final Categories category;
  final Icon icon;

  CategoriesFilter({required this.icon, required this.category});
}

class StatusesFilter {
  final Statuses status;
  final Icon icon;

  StatusesFilter({required this.icon, required this.status});
}

List<CategoriesFilter> categoriesFilters = [
  CategoriesFilter(
      category: Categories.personal, icon: const Icon(Icons.person)),
  CategoriesFilter(category: Categories.work, icon: const Icon(Icons.work)),
  CategoriesFilter(
      category: Categories.health, icon: const Icon(Icons.health_and_safety)),
];

List<StatusesFilter> statusesFilters = [
  StatusesFilter(status: Statuses.completed, icon: const Icon(Icons.done_all)),
  StatusesFilter(
      status: Statuses.inProcess, icon: const Icon(Icons.date_range)),
];
