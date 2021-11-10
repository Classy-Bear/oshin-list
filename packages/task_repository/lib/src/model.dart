import 'dart:convert';

class Task {
    Task({
        this.id,
        this.title,
        this.description,
        this.fecha,
        this.tipo,
        this.color,
    });

    final int? id;
    final String? title;
    final String? description;
    final String? fecha;
    final int? tipo;
    final int? color;

    Task copyWith({
        int? id,
        String? title,
        String? description,
        String? fecha,
        int? tipo,
        int? color,
    }) => 
        Task(
            id: id ?? this.id,
            title: title ?? this.title,
            description: description ?? this.description,
            fecha: fecha ?? this.fecha,
            tipo: tipo ?? this.tipo,
            color: color ?? this.color,
        );

    factory Task.fromJson(String str) => Task.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Task.fromMap(Map<String, dynamic> json) => Task(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        fecha: json["fecha"] == null ? null : json["fecha"],
        tipo: json["tipo"] == null ? null : json["tipo"],
        color: json["color"] == null ? null : json["color"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "fecha": fecha == null ? null : fecha,
        "tipo": tipo == null ? null : tipo,
        "color": color == null ? null : color,
    };
}
