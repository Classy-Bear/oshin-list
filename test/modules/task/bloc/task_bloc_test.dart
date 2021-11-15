import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oshin_list/core/network/network.dart';
import 'package:oshin_list/modules/task/bloc/bloc.dart';
import 'package:task_repository/task_repository.dart';

import 'mocks.mocks.dart';

/// Generate files with this command:
/// flutter packages pub run build_runner build --delete-conflicting-outputs
@GenerateMocks([
  TaskDataProvider
])
void main() {
  group(' Test $TaskBloc functionalities.', () {
    final taskDataProvider = MockTaskDataProvider();

    test('initial state is correct', () {
      final taskBloc = TaskBloc(taskDataProvider);
      expect(taskBloc.state, const TaskState());
    });

    group('getAll', () {
      blocTest<TaskBloc, TaskState>(
        '"getAll" fetchs all the task',
        build: () => TaskBloc(taskDataProvider),
        setUp: () {
          when(taskDataProvider.getAll()).thenAnswer((_) async => TaskList.one);
        },
        act: (bloc) => bloc.getAll(),
        expect: () => <TaskState>[
          const TaskState(
            tasks: TaskList.empty,
            status: FetchStatus.loading,
          ),
          TaskState(
            tasks: TaskList.one,
            status: FetchStatus.success,
          )
        ],
      );
    });

    group('create', () {
      blocTest<TaskBloc, TaskState>(
        '"create" creates a new task',
        build: () => TaskBloc(taskDataProvider),
        setUp: () {
          when(taskDataProvider.create(Task.empty))
              .thenAnswer((_) async => Task.empty);
        },
        act: (bloc) => bloc.create(Task.empty),
        expect: () => <TaskState>[
          const TaskState(
            tasks: TaskList.empty,
            status: FetchStatus.loading,
          ),
          TaskState(
            tasks: TaskList.one,
            status: FetchStatus.success,
          ),
        ],
      );
    });

    group('delete', () {
      blocTest<TaskBloc, TaskState>(
        '"delete" deletes a new task',
        setUp: () {
          when(taskDataProvider.create(Task.empty))
              .thenAnswer((_) async => Task.empty);
          when(taskDataProvider.delete('1')).thenAnswer((_) async => {});
        },
        build: () => TaskBloc(taskDataProvider),
        act: (bloc) => bloc
          ..create(Task.empty)
          ..delete('1'),
        expect: () => <TaskState>[
          const TaskState(
            tasks: TaskList.empty,
            status: FetchStatus.loading,
          ),
          const TaskState(
            tasks: TaskList.empty,
            status: FetchStatus.success,
          )
        ],
      );
    });
  });
}
