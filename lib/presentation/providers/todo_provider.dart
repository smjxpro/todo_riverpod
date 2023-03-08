import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/base_classes/base_controller.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
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
  FutureOr<List<Todo>?> build() {
    return getTodoList();
  }

  Future updateTodo(Todo todo) async {
    final repository = ref.read(todoRepositoryProvider);

    todo.updatedAt = DateTime.now();

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

  Future<List<Todo>?> getTodoList() async {
    final repository = ref.read(todoRepositoryProvider);

    state = const AsyncValue.loading();

    final result = await repository.getAll();

    result.fold(handleFailure, (r) => state = AsyncValue.data(r));

    return state.valueOrNull;
  }

  Future deleteTodoById(int i) async {
    state = state.maybeWhen(
        data: (value) => AsyncValue.data(
            value?.where((element) => element.id != i).toList()),
        orElse: () => state);
    return state.valueOrNull;
  }
}

class DeleteTodoController extends BaseController<void> {
  Future deleteTodoById(int i) async {
    final repository = ref.read(todoRepositoryProvider);

    state = const AsyncValue.loading();

    final result = await repository.delete(i);

    result.fold(
        handleFailure, (r) => state = AsyncValue.data(state.valueOrNull));

    ref.read(todoListControllerProvider.notifier).deleteTodoById(i);

    return state.valueOrNull;
  }

  @override
  FutureOr<void> build() async {
    return;
  }
}

final todoListControllerProvider =
    AsyncNotifierProvider<TodoListController, List<Todo>?>(
        TodoListController.new);

final deleteTodoControllerProvider =
    AsyncNotifierProvider<DeleteTodoController, void>(DeleteTodoController.new);
