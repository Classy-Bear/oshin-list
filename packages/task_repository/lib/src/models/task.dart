part of 'models.dart';

class Task extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final TaskType? type;
  final DateTime? date;
  final int? color;
  final bool? completed;

  bool get isPending =>
      (completed == false && DateTime.now().isBefore(date ?? DateTime.now()));

  bool get isOverdue =>
      (completed == false && DateTime.now().isAfter(date ?? DateTime.now()));

  bool get isPastelPink =>
      _colorValidate(color) > 0 && _colorValidate(color) < 20;

  bool get isPurple => _colorValidate(color) > 19 && _colorValidate(color) < 40;

  bool get islightBrown =>
      _colorValidate(color) > 39 && _colorValidate(color) < 60;

  bool get isGreen => _colorValidate(color) > 59;

  const Task._({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.date,
    required this.color,
    required this.completed,
  });

  factory Task.create({
    required String title,
    required String description,
    required TaskType type,
    required int color,
    required DateTime date,
  }) {
    return Task._(
      id: null,
      title: title,
      description: description,
      type: type,
      date: date,
      color: color,
      completed: false,
    );
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    TaskType? type,
    DateTime? date,
    int? color,
    bool? completed,
  }) =>
      Task._(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        type: type ?? this.type,
        date: date ?? this.date,
        color: color ?? this.color,
        completed: completed ?? this.completed,
      );

  factory Task.fromJson(String str) => Task.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Task.fromMap(Map<String, dynamic> json) => Task._(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        type: int.tryParse("${json["type"]}")?.toType,
        date: DateTime.tryParse(json["date"] ?? ''),
        color: json["color"],
        completed: json["completed"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "type": type,
        "date": date?.toIso8601String(),
        "color": color,
        "completed": completed
      };

  static final empty = Task._(
    id: '1',
    title: "Do the dishes",
    description: "Before going to Maria's house.",
    type: TaskType.work,
    date: DateTime(0),
    color: 0,
    completed: false,
  );

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        type,
        date,
        color,
        completed,
      ];

  int? get typeAsInt {
    switch (type) {
      case TaskType.work:
        return 0;
      case TaskType.study:
        return 36;
      case TaskType.family:
        return 71;
      default:
        return null;
    }
  }

  int get selectedColor {
    if (isPastelPink) {
      return pastelPink;
    } else if (isPurple) {
      return purple;
    } else if (islightBrown) {
      return lightBrown;
    } else {
      return green;
    }
  }

  int _colorValidate(int? color) => color ?? Task.empty.color ?? 0;
}

extension IntTypeMethods on int {
  TaskType? get toType {
    if (this > 0 && this < 35) {
      return TaskType.work;
    } else if (this > 35 && this < 70) {
      return TaskType.study;
    } else if (this > 70 && this < 100) {
      return TaskType.family;
    } else {
      return null;
    }
  }
}
