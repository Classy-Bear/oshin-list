import 'package:flutter/material.dart';
import 'package:oshin_list/core/widgets/statistics_graphics/statistics_graphics.dart';
import 'package:task_repository/task_repository.dart';

class StatisticScreen extends StatefulWidget {
  StatisticScreen({Key? key}) : super(key: key);

  @override
  __StatisticScreenState createState() => __StatisticScreenState();
}

class __StatisticScreenState extends State<StatisticScreen> {
  @override
  Widget build(BuildContext context) {
    return TasksGraphics(
      tasks: tasks,
    );
  }

  List<Task> tasks = [
    Task.create(
      title: 'task 1',
      description: '1',
      type: 1,
      color: 1,
      date: DateTime.now(),
      completed: true,
    ),
    Task.create(
      title: 'task 1',
      description: '1',
      type: 1,
      color: 1,
      date: DateTime.now(),
      completed: true,
    ),
    Task.create(
      title: 'task 1',
      description: '1',
      type: 1,
      color: 1,
      date: DateTime.now(),
      completed: true,
    ),
    Task.create(
      title: 'task 1',
      description: '1',
      type: 1,
      color: 1,
      date: DateTime.now(),
      completed: true,
    ),
    Task.create(
      title: 'task 1',
      description: '1',
      type: 1,
      color: 1,
      date: DateTime.now(),
      completed: true,
    ),
    Task.create(
      title: 'task 1',
      description: '1',
      type: 1,
      color: 1,
      date: DateTime.now(),
      completed: true,
    ),
    Task.create(
      title: 'task 1',
      description: '1',
      type: 1,
      color: 1,
      date: DateTime.now(),
      completed: true,
    ),
    Task.create(
      title: 'task 1',
      description: '1',
      type: 1,
      color: 1,
      date: DateTime.now().add(Duration(days: 1)),
    ),
    Task.create(
      title: 'task 1',
      description: '1',
      type: 1,
      color: 1,
      date: DateTime.now().add(Duration(days: 1)),
    ),
    Task.create(
      title: 'task 1',
      description: '1',
      type: 1,
      color: 1,
      date: DateTime.now().add(Duration(days: 1)),
    ),
    Task.create(
      title: 'task 1',
      description: '1',
      type: 1,
      color: 1,
      date: DateTime.now().add(Duration(days: 1)),
    ),
    Task.create(
      title: 'task 1',
      description: '1',
      type: 1,
      color: 1,
      date: DateTime.now().add(Duration(days: 1)),
    ),
    Task.create(
      title: 'task 1',
      description: '1',
      type: 1,
      color: 1,
      date: DateTime.now().add(Duration(days: 1)),
    ),
    Task.create(
      title: 'task 1',
      description: '1',
      type: 1,
      color: 1,
      date: DateTime.now().add(Duration(days: 1)),
    ),
    Task.create(
      title: 'task 1',
      description: '1',
      type: 1,
      color: 1,
      date: DateTime.now().add(Duration(days: 1)),
    ),
    Task.create(
      title: 'task 1',
      description: '1',
      type: 1,
      color: 1,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Task.create(
      title: 'task 1',
      description: '1',
      type: 1,
      color: 1,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Task.create(
      title: 'task 1',
      description: '1',
      type: 1,
      color: 1,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Task.create(
      title: 'task 1',
      description: '1',
      type: 1,
      color: 1,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Task.create(
      title: 'task 1',
      description: '1',
      type: 1,
      color: 1,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
  ];
}
