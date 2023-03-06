import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/domain/entities/todo.dart';
import 'package:todo_riverpod/presentation/providers/todo_provider.dart';

class TodoListPage extends ConsumerWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<List<Todo>?>>(
      todoListControllerProvider,
      (_, state) => state.whenOrNull(
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
            ),
          );
        },
      ),
    );

    final todoList = ref.watch(todoListControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Center(
          child: todoList.when(
              data: (data) => ListView.builder(
                    itemCount: data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final todo = data![index];

                      return CheckboxListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(todo.title ?? ''),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                ref
                                    .read(todoListControllerProvider.notifier)
                                    .deleteTodoById(todo.id!);
                              },
                            ),
                          ],
                        ),
                        value: todo.isCompleted,
                        onChanged: (value) {
                          todo.isCompleted = value!;
                          ref
                              .read(todoListControllerProvider.notifier)
                              .updateTodo(todo);
                        },
                      );
                    },
                  ),
              error: (Object error, StackTrace stackTrace) {
                return Text(error.toString());
              },
              loading: () {
                return const CircularProgressIndicator();
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-todo');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
