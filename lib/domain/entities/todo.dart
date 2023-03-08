import 'dart:convert';

import 'package:todo_riverpod/core/base_classes/base_entity.dart';

class Todo extends BaseEntity<int> {
  String title;
  String? description;
  bool isCompleted;

  Todo({
    super.id,
    required this.title,
    this.description,
    this.isCompleted = false,
    super.createdAt,
    super.updatedAt,
  });

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
