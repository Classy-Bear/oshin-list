part of 'models.dart';

class Task extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final int? type;
  final DateTime? date;
  final int? color;
  final bool? completed;

  bool get isPending => 
  (completed == false && DateTime.now().isBefore(date??DateTime.now()));

  bool get isOverdue => 
  (completed == false && DateTime.now().isAfter(date??DateTime.now()));

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
    required int type,
    required int color,
    required DateTime date,
    completed = false,
  }) {
    return Task._(
      id: null,
      title: title,
      description: description,
      type: type,
      date: date,
      color: color,
      completed: completed,
    );
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    int? type,
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
        type: json["type"],
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
    type: 1,
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
}
