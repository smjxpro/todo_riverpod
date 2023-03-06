import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/domain/repositories/todo_repository.dart';

import '../../domain/entities/todo.dart';
import '../../infrastructure/data_sources/local_todo_source.dart';
import '../../infrastructure/repositories/todo_repository.dart';

final todoLocalDataSourceProvider = Provider<TodoLocalDataSource>((ref) {
  return TodoLocalDataSourceImpl();
});

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  return TodoRepositoryImpl(ref.watch(todoLocalDataSourceProvider));
});

class TodoListController extends AsyncNotifier<List<Todo>?> {
  @override
  FutureOr<List<Todo>?> build() async {
    final repository = ref.read(todoRepositoryProvider);

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(repository.getTodos);

    return state.valueOrNull;
  }

  Future deleteTodoById(int i) async {
    final repository = ref.read(todoRepositoryProvider);

    state = const AsyncValue.loading();

    await AsyncValue.guard(() => repository.deleteTodo(i));

    state = await AsyncValue.guard(repository.getTodos);
  }

  Future updateTodo(Todo todo) async {
    final repository = ref.read(todoRepositoryProvider);

    state = const AsyncValue.loading();

    await AsyncValue.guard(() => repository.updateTodo(todo));

    state = await AsyncValue.guard(repository.getTodos);
  }

  Future addNewTodo(Todo todo) async {
    final repository = ref.read(todoRepositoryProvider);

    state = const AsyncValue.loading();

    await AsyncValue.guard(() => repository.addNewTodo(todo));

    state = await AsyncValue.guard(repository.getTodos);
  }
}

final todoListControllerProvider =
    AsyncNotifierProvider<TodoListController, List<Todo>?>(
        TodoListController.new);
