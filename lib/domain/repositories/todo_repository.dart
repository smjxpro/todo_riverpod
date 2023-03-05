import 'package:todo_riverpod/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodos();

  Future<Todo> addNewTodo(Todo todo);

  Future<void> updateTodo(Todo todo);

  Future<void> deleteTodo(int id);
}
