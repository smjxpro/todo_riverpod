import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/core/extensions/date_time_extension.dart';
import 'package:todo_riverpod/presentation/providers/todo_provider.dart';

class TodoListPage extends ConsumerWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(
      deleteTodoControllerProvider,
      (pre, state) => state.whenOrNull(
        data: (_) {
          if (pre?.hasValue == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Todo deleted'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
              backgroundColor: Colors.red,
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
                                    .read(deleteTodoControllerProvider.notifier)
                                    .deleteTodoById(todo.id!);
                              },
                            ),
                          ],
                        ),
                        secondary: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(todo.updatedAt?.formattedDateTime ?? ''),
                          ],
                        ),
                        value: todo.isCompleted,
                        onChanged: (value) async {
                          todo.isCompleted = value!;
                          await ref
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
