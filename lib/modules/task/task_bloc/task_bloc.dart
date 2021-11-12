import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oshin_list/modules/task/task_bloc/task_state.dart';
import 'package:task_repository/task_repository.dart';

/// [TaskBloc]'s bloc in responsable for control the state of a list of type [Task],
/// you can get add, update and delete using its functions.
///
/// functions of this object:
/// ```
///   Future<void> loadTasks():
///   Future<void> createTask():
///   Future<void> updateTask();
///   Future<void> deleteTask():
/// ```
class TaskBloc extends Cubit<TaskState> {
  /// Provides all the function required to access and manipulate data[TaskBloc]
  final TaskDataProvider _taskRepository;

  TaskBloc(this._taskRepository) : super(TaskState.initialState());

  /// Fetch a list of type [Task] to the to the list.
  Future<void> loadTasks() async {
    emit(state.copyWith(isLoading: true));

    try {
      List<Task> tasks = await _taskRepository.getAll();

      emit(
        state.copyWith(
          tasks: tasks,
          isLoading: false,
          clearMessageError: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(errorMessage: 'unexpected error loading all task.'),
      );
    }
  }

  /// Adds a new [Task] to the list.
  Future<void> createTask(Task task) async {
    emit(state.copyWith(isLoading: true));

    try {
      var newTask = await _taskRepository.create(task);

      emit(
        state.copyWith(
          isLoading: false,
          tasks: [newTask, ...state.tasks],
          clearMessageError: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: "Unexpected error creating.",
        ),
      );
    }
  }

  // Updates a [Task] from the list.
  Future<void> updateTask(int id) async {
    emit(state.copyWith(isLoading: true));

    try {
      // TODO: use the update function from the repository to update a task.
      // var updateTask =_taskRepository.update(id);

      emit(
        state.copyWith(
          isLoading: false,
          tasks: state.tasks.map<Task>((e) => e.id == id ? e : e).toList(),
          clearMessageError: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'unexpected error updating.',
        ),
      );
    }
  }
  // TODO:. finish this test
  // Future<void> deleteTask(int id) async {
  //   emit(state.copyWith(isLoading: true));

  //   try {
  //     await _taskRepository.delete(id);

  //     emit(
  //       state.copyWith(
  //         isLoading: false,
  //         clearMessageError: true,
  //         tasks: state.tasks.toList()..removeWhere((e) => e.id == id),
  //       ),
  //     );
  //   } catch (error) {
  //     emit(
  //       state.copyWith(
  //         isLoading: false,
  //         errorMessage: 'unexpected error deleting.',
  //       ),
  //     );
  //   }
  // }
}
