import 'package:bloc/bloc.dart';
import 'package:test_application_1/data/model/task_model.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<Task> {
  TaskCubit() : super(InitialTaskState());

  void changeName(String name) {
    emit(state.copyWith(name: name));
  }

  void changeDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void changeCategory(Categories category) {
    emit(state.copyWith(category: category));
  }

  void changeStatus(Statuses status) {
    emit(state.copyWith(status: status));
  }
}
