import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/presentation/todo_provider.dart';

class TodoListPage extends ConsumerWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var todoList = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Center(
        child: todoList.when(
          data: (todos) {
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return CheckboxListTile(
                  title: Row(
                    children: [
                      Text(todo.title),
                      const SizedBox(width: 16),
                      IconButton(
                          onPressed: () async {
                            final data = ref.read(todoDeleteProvider(todo.id!));
                            data.whenData((value) {
                              ref.invalidate(todoListProvider);
                            });
                          },
                          icon: const Icon(Icons.delete))
                    ],
                  ),
                  value: todo.isCompleted,
                  onChanged: (bool? value) {
                    // ref.read(todoListProvider.notifier).updateTodo(
                    //       todo.copyWith(isCompleted: value ?? false),
                    //     );
                  },
                );
              },
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text(error.toString()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-todo');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
