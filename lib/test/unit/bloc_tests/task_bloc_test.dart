import 'dart:ffi';

import 'package:oshin_list/modules/task/task_bloc/task_bloc.dart';
import 'package:oshin_list/modules/task/task_bloc/task_state.dart';
import 'package:task_repository/task_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:oshin_list/test/test_util/mocks.mocks.dart';
// Run test with the command: lutter test

void main() {
  // Test [TaskBloc] check bloc behaviour.
  group(' Test $TaskBloc functionalities.', () {
    test('Initial state should be ${TaskState.initialState()}', () async {
      final taskDataProvider = MockTaskDataProvider();
      final taskBlock = TaskBloc(taskDataProvider);

      expect(taskBlock.state, TaskState.initialState());
    });

    blocTest<TaskBloc, TaskState>(
      'Check loadTask Functions fetch all the task',
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

    // blocTest<TaskBloc, TaskState>(
    //   'delete new task',
    //   build: () {
    //     final taskDataProvider = MockTaskDataProvider();
    //     when(taskDataProvider.delete(1)).thenAnswer((_) async => []);

    //     var taskBloc = TaskBloc(taskDataProvider)..createTask(Task.empty);

    //     return taskBloc;
    //   },
    //   act: (bloc) => bloc.deleteTask(1),
    //   expect: () => <TaskState>[
    //     TaskState(isLoading: true, tasks: [Task.empty]),
    //     const TaskState(isLoading: false, tasks: []),
    //   ],
    // );
  });
}
