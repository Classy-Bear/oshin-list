part of 'bloc.dart';

/// [TaskBloc]'s bloc in responsable for control the state of a [TaskList],
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
  /// Provides all the functionality required to access and manipulate [Task]'s
  /// data.
  final TaskDataProvider _taskRepository;

  TaskBloc({
    TaskDataProvider? taskRepository,
  })  : _taskRepository = taskRepository ?? TaskRepository(),
        super(const TaskState());

  /// Fetch a list of type [Task] to the to the list.
  Future<void> getAll() async {
    emit(state.copyWith(status: FetchStatus.loading));
    try {
      TaskList tasks = await _taskRepository.getAll();
      emit(state.copyWith(tasks: tasks, status: FetchStatus.success));
    } on Exception {
      emit(state.copyWith(status: FetchStatus.failure));
    }
  }

  /// Adds a new [Task] to the list.
  Future<void> create(Task task) async {
    emit(state.copyWith(status: FetchStatus.loading));
    try {
      final newTask = await _taskRepository.create(task);
      final newTaskList = state.tasks.add(task: newTask);
      emit(state.copyWith(tasks: newTaskList, status: FetchStatus.success));
    } catch (error) {
      emit(state.copyWith(status: FetchStatus.failure));
    }
  }

  /// Updates a [Task] from the list.
  Future<void> update(Task task) async {
    emit(state.copyWith(status: FetchStatus.loading));
    try {
      final newTask = await _taskRepository.update(task);
      final newTaskList = state.tasks
          .replaceWhere(task: newTask, where: (task) => task.id == newTask.id);
      emit(state.copyWith(tasks: newTaskList, status: FetchStatus.success));
    } catch (error) {
      emit(state.copyWith(status: FetchStatus.failure));
    }
  }

  /// Deletes a [Task] from the list.
  Future<void> delete(String id) async {
    emit(state.copyWith(status: FetchStatus.loading));
    try {
      await _taskRepository.delete(id);
      final newTaskList = state.tasks.removeWhere(
        where: (task) => task.id == id,
      );
      emit(state.copyWith(tasks: newTaskList, status: FetchStatus.success));
    } catch (error) {
      emit(state.copyWith(status: FetchStatus.failure));
    }
  }
}
