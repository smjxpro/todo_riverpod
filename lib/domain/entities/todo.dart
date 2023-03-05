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
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'isCompleted': isCompleted,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  factory Todo.fromMap(Map<String, dynamic> map) => Todo(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        isCompleted: map['isCompleted'],
        createdAt: map['createdAt'],
        updatedAt: map['updatedAt'],
      );

  String toJson() => jsonEncode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(jsonDecode(source));
}
