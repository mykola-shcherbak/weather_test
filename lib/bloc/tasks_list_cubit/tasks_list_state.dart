part of 'tasks_list_cubit.dart';

class TasksListState {
  final List<Task> tasksList;
  final List<Task> filteredTasks;
  final List<Categories> selecedCategories;
  final List<Statuses> selectedStatuses;

  const TasksListState({
    required this.tasksList,
    required this.filteredTasks,
    required this.selecedCategories,
    required this.selectedStatuses,
  });

  TasksListState copyWith({
    List<Task>? tasksList,
    List<Task>? filteredTasks,
    List<Categories>? selecedCategories,
    List<Statuses>? selectedStatuses,
  }) {
    return TasksListState(
      tasksList: tasksList ?? this.tasksList,
      filteredTasks: filteredTasks ?? this.filteredTasks,
      selecedCategories: selecedCategories ?? this.selecedCategories,
      selectedStatuses: selectedStatuses ?? this.selectedStatuses,
    );
  }
}

class TaskStateInitial extends TasksListState {
  TaskStateInitial()
      : super(
          tasksList: [],
          filteredTasks: [],
          selecedCategories: [],
          selectedStatuses: [],
        );
}
