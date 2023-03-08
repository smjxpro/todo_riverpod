import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/domain/entities/todo.dart';
import 'package:todo_riverpod/presentation/providers/todo_provider.dart';

class AddTodoPage extends ConsumerWidget {
  AddTodoPage({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Add Todo'),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Todo',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);

                await ref.read(todoListControllerProvider.notifier).addNewTodo(
                      Todo(
                        title: _nameController.text,
                        isCompleted: false,
                      ),
                    );
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
