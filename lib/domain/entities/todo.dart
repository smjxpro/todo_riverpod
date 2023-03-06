import 'dart:convert';

class Todo {
  int? id;
  String title;
  String? description;
  bool isCompleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  Todo({
    this.id,
    required this.title,
    this.description,
    this.isCompleted = false,
    this.createdAt,
    this.updatedAt,
  }) {
    createdAt ??= DateTime.now();
    updatedAt ??= DateTime.now();
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'isCompleted': isCompleted,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String()
      };

  factory Todo.fromMap(Map<String, dynamic> map) => Todo(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        isCompleted: map['isCompleted'],
        createdAt: DateTime.parse(map['createdAt']),
        updatedAt: DateTime.parse(map['updatedAt']),
      );

  String toJson() => jsonEncode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(jsonDecode(source));
}
