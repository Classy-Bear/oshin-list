part of 'models.dart';

class Task extends Equatable{
    Task({
        this.id,
        this.title,
        this.description,
        this.type,
        this.date,
        this.color,
    });

    final int? id;
    final String? title;
    final String? description;
    final int? type;
    final String? date;
    final int? color;

    const Task._({
      required this.id,
      required this.title,
      required this.description,
      required this.type,
      required this.date,
      required this.color
    });

    Task copyWith({
        int? id,
        String? title,
        String? description,
        int? type,
        String? date,
        int ?color,
    }) => 
        Task._(
            id: id ?? this.id,
            title: title ?? this.title,
            description: description ?? this.description,
            type: type ?? this.type,
            date: date ?? this.date,
            color: color ?? this.color,
        );

    factory Task.fromJson(String str) => Task.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Task.fromMap(Map<String, dynamic> json) => Task._(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        type: json["type"] == null ? null : json["type"],
        date: json["date"] == null ? null : json["date"],
        color: json["color"] == null ? null : json["color"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "type": type == null ? null : type,
        "date": date == null ? null : date,
        "color": color == null ? null : color,
    };

  static const empty = Task._(
    id: 1,
    title: "Do the dishes",
    description: "Before go to maria's house.",
    type: 1,
    date:'',
    color:0
  );
  @override
  List<Object?> get props => [id,title,description,type,date,color];
}
