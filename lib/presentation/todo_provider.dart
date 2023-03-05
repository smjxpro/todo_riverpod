import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/domain/repositories/todo_repository.dart';

import '../domain/entities/todo.dart';
import '../infrastructure/data_sources/local_todo_source.dart';
import '../infrastructure/repositories/todo_repository.dart';

final todoLocalDataSourceProvider = Provider<TodoLocalDataSource>((ref) {
  return TodoLocalDataSourceImpl();
});

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  return TodoRepositoryImpl(ref.watch(todoLocalDataSourceProvider));
});

final todoListProvider = FutureProvider.autoDispose<List<Todo>>((ref) async {
  final repository = ref.watch(todoRepositoryProvider);
  await Future.delayed(const Duration(seconds: 5));
  return repository.getTodos();
});

final todoAddProvider = FutureProvider.family<Todo, Todo>((ref, todo) {
  final repository = ref.watch(todoRepositoryProvider);
  return repository.addNewTodo(todo);
});

final todoUpdateProvider = FutureProvider.family<void, Todo>((ref, todo) {
  final repository = ref.watch(todoRepositoryProvider);
  return repository.updateTodo(todo);
});

final todoDeleteProvider = FutureProvider.family<void, int>((ref, id) async {
  final repository = ref.watch(todoRepositoryProvider);
  return await repository.deleteTodo(id);
});
