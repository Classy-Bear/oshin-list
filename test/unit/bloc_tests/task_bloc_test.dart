import 'package:oshin_list/modules/task/bloc/bloc.dart';
import 'package:task_repository/task_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../test_util/mocks.mocks.dart';

void main() {
  group(' Test $TaskBloc functionalities.', () {
    test('Initial state should be ${const TaskState()}', () async {
      final taskDataProvider = MockTaskDataProvider();
      final taskBlock = TaskBloc(taskDataProvider);
      const initialState = TaskState(
        isLoading: false,
        errorMessage: null,
        tasks: [],
      );
      expect(taskBlock.state, initialState);
    });

    blocTest<TaskBloc, TaskState>(
      'Check loadTask functions fetch all the task',
      build: () {
        final taskDataProvider = MockTaskDataProvider();
        when(taskDataProvider.getAll()).thenAnswer((_) async => [Task.empty]);

        return TaskBloc(taskDataProvider);
      },
      act: (bloc) => bloc.loadTasks(),
      expect: () => <TaskState>[
        const TaskState(
          tasks: [],
          isLoading: true,
        ),
        TaskState(
          tasks: [Task.empty],
          isLoading: false,
        )
      ],
    );

    blocTest<TaskBloc, TaskState>(
      'Create new task',
      build: () {
        final taskDataProvider = MockTaskDataProvider();
        when(taskDataProvider.create(Task.empty))
            .thenAnswer((_) async => Task.empty);

        return TaskBloc(taskDataProvider);
      },
      act: (bloc) => bloc.createTask(Task.empty),
      expect: () => <TaskState>[
        const TaskState(
          tasks: [],
          isLoading: true,
        ),
        TaskState(
          tasks: [Task.empty],
          isLoading: false,
        ),
      ],
    );

    blocTest<TaskBloc, TaskState>(
      'delete new task',
      build: () {
        final taskDataProvider = MockTaskDataProvider();
        when(taskDataProvider.create(Task.empty))
            .thenAnswer((_) async => Task.empty);
        when(taskDataProvider.delete('1')).thenAnswer((_) async => []);
        final bloc = TaskBloc(taskDataProvider);
        bloc.createTask(Task.empty);
        return bloc;
      },
      act: (bloc) => bloc.deleteTask('1'),
      expect: () => <TaskState>[
        TaskState(isLoading: false, tasks: [Task.empty]),
        const TaskState(isLoading: false, tasks: []),
      ],
    );
  });
}
