part of 'task_cubit.dart';

class InitialTaskState extends Task {
  InitialTaskState()
      : super(
          taskId: '',
          name: '',
          description: '',
          status: Statuses.inProcess,
          category: Categories.personal,
        );
}

enum Statuses { completed, inProcess }

enum Categories { work, personal, health }
