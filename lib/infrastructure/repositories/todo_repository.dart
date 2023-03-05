import 'package:todo_riverpod/domain/entities/todo.dart';
import 'package:todo_riverpod/domain/repositories/todo_repository.dart';

import '../data_sources/local_todo_source.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl(this.localDataSource);

  @override
  Future<Todo> addNewTodo(Todo todo) {
    return localDataSource.addNewTodo(todo);
  }

  @override
  Future<void> deleteTodo(int id) {
    return localDataSource.deleteTodo(id);
  }

  @override
  Future<List<Todo>> getTodos() {
    return localDataSource.getTodos();
  }

  @override
  Future<void> updateTodo(Todo todo) {
    return localDataSource.updateTodo(todo);
  }
}
