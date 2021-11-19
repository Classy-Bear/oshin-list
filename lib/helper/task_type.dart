import 'package:task_repository/task_repository.dart';

const typeAsMap = [
  {'value': 'Work'},
  {'value': 'Study'},
  {'value': 'Family'},
];

TaskType strAsTaskType(String type) {
  switch (type.toLowerCase()) {
    case "study":
      return TaskType.study;
    case "family":
      return TaskType.study;
    default:
      return TaskType.work;
  }
}
