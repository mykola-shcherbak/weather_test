import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_application_1/bloc/task_cubit/task_cubit.dart';
import 'package:test_application_1/data/model/task_model.dart';

part 'tasks_list_state.dart';

class TasksListCubit extends Cubit<TasksListState> {
  final SharedPreferences _preferences;
  TasksListCubit(this._preferences) : super(TaskStateInitial());

  Future<void> fetchTasks() async {
    List<Task> taskFromPreps = _preferences
        .getKeys()
        .map((key) => Task.fromJson(jsonDecode(_preferences.getString(key)!)))
        .toList();
    emit(state.copyWith(tasksList: taskFromPreps));
    emit(state.copyWith(filteredTasks: taskFromPreps));
  }

  Future<void> savetaskPrefs(Task task) async {
    Map<String, dynamic> jsontask = task.toJson();
    _preferences.setString(task.taskId, jsonEncode(jsontask));
  }

  Future<void> createTask(Task task) async {
    final List<Task> taskList = [...state.tasksList, task];
    emit(state.copyWith(tasksList: taskList));
    savetaskPrefs(task);
    filterTasks();
  }

  Future<void> filterTasks() async {
    List<Task> filteredTasksList = [...state.tasksList];
    final List<Categories> selecedCategories = [...state.selecedCategories];
    final List<Statuses> selectedStatuses = [...state.selectedStatuses];
    if (selecedCategories.isNotEmpty) {
      filteredTasksList
          .removeWhere((task) => !selecedCategories.contains(task.category));
    }
    if (selectedStatuses.isNotEmpty) {
      filteredTasksList
          .removeWhere((task) => !selectedStatuses.contains(task.status));
    }
    emit(state.copyWith(filteredTasks: filteredTasksList));
  }

  Future<void> editCategoriesFilters(Categories category) async {
    List<Categories> selecedCategories = [...state.selecedCategories];
    if (selecedCategories.contains(category)) {
      selecedCategories.remove(category);
    } else {
      selecedCategories.add(category);
    }
    emit(state.copyWith(selecedCategories: selecedCategories));
    filterTasks();
  }

  Future<void> editStatusesFilters(Statuses status) async {
    List<Statuses> selectedStatuses = [...state.selectedStatuses];
    if (selectedStatuses.contains(status)) {
      selectedStatuses.remove(status);
    } else {
      selectedStatuses.add(status);
    }
    emit(state.copyWith(selectedStatuses: selectedStatuses));
    filterTasks();
  }

  Future<void> removeTaskById(String taskId) async {
    final List<Task> tasksList = state.tasksList;
    tasksList.removeWhere((task) => task.taskId == taskId);
    emit(state.copyWith(tasksList: tasksList));
    filterTasks();
    _preferences.remove(taskId);
  }

  Future<void> changeStatusById(Statuses status, String taskId) async {
    final List<Task> tasksList = state.tasksList;
    final Task selectedTask =
        tasksList.firstWhere((task) => task.taskId == taskId);
    final int taskIndex = tasksList.indexOf(selectedTask);
    final Task editedTask = selectedTask.copyWith(status: status);
    tasksList[taskIndex] = editedTask;
    emit(state.copyWith(tasksList: tasksList));
    filterTasks();
    savetaskPrefs(editedTask);
  }
}
