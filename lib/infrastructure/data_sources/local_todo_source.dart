import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../../domain/entities/todo.dart';

abstract class TodoLocalDataSource {
  Future<List<Todo>> getTodos();

  Future<Todo> addNewTodo(Todo todo);

  Future<void> updateTodo(Todo todo);

  Future<void> deleteTodo(int id);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  String dbPath = 'todo.db';
  DatabaseFactory dbFactory = databaseFactoryIo;

  @override
  Future<Todo> addNewTodo(Todo todo) async {
    Database db = await dbFactory.openDatabase(await _getDatabasePath());

    var store = StoreRef.main();

    var key = await store.add(db, todo.toMap());
    var record = await store.record(key).get(db)
        as RecordSnapshot<int, Map<String, dynamic>>;

    return Todo.fromMap(record.value);
  }

  @override
  Future<void> deleteTodo(int id) async {
    Database db = await dbFactory.openDatabase(await _getDatabasePath());

    var store = StoreRef.main();

    await store.record(id).delete(db);
  }

  @override
  Future<List<Todo>> getTodos() async {
    Database db = await dbFactory.openDatabase(await _getDatabasePath());

    var store = StoreRef.main();

    var records = await store.find(db);

    return records.map((record) {
      var todo = Todo.fromMap(record.value as Map<String, dynamic>);
      todo.id = record.key as int;

      return todo;
    }).toList();
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    Database db = await dbFactory.openDatabase(await _getDatabasePath());

    var store = StoreRef.main();

    await store.record(todo.id).update(db, todo.toMap());
  }

  Future<String> _getDatabasePath() async {
    final dir = await getApplicationDocumentsDirectory();

    return dir.path + dbPath;
  }
}
