import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/core/base_classes/base_controller.dart';
import 'package:todo_riverpod/domain/repositories/todo_repository.dart';

import '../../domain/entities/todo.dart';
import '../../infrastructure/data_sources/local_todo_source.dart';
import '../../infrastructure/repositories/todo_repository.dart';

final todoLocalDataSourceProvider = Provider<TodoLocalSource>((ref) {
  return TodoLocalSourceImpl();
});

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  return TodoRepositoryImpl(ref.watch(todoLocalDataSourceProvider));
});

class TodoListController extends BaseController<List<Todo>?> {
  @override
  FutureOr<List<Todo>?> build() async {
    final repository = ref.read(todoRepositoryProvider);

    state = const AsyncValue.loading();

    final result = await repository.getAll();

    result.fold(handleFailure, (r) => state = AsyncValue.data(r));

    return state.valueOrNull;
  }

  Future deleteTodoById(int i) async {
    final repository = ref.read(todoRepositoryProvider);

    state = const AsyncValue.loading();

    final result = await repository.delete(i);

    result.fold(
        handleFailure,
        (r) => state = AsyncValue.data(
            state.valueOrNull?.where((element) => element.id != i).toList()));

    return state.valueOrNull;
  }

  Future updateTodo(Todo todo) async {
    final repository = ref.read(todoRepositoryProvider);

    state = const AsyncValue.loading();

    final result = await repository.update(todo);

    result.fold(
        handleFailure,
        (r) => state = AsyncValue.data(state.valueOrNull
            ?.map((e) => e.id == todo.id ? todo : e)
            .toList()));
  }

  Future addNewTodo(Todo todo) async {
    final repository = ref.read(todoRepositoryProvider);

    state = const AsyncValue.loading();

    final result = await repository.add(todo);

    result.fold(handleFailure, (r) {
      state.valueOrNull?.add(r);
      state = AsyncValue.data(state.valueOrNull);
    });
  }
}

final todoListControllerProvider =
    AsyncNotifierProvider<TodoListController, List<Todo>?>(
        TodoListController.new);
