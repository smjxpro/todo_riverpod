import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:todo_riverpod/core/exceptions/api_exceptions.dart';

import '../../core/base_classes/base_source.dart';
import '../../domain/entities/todo.dart';

abstract class TodoLocalSource extends BaseLocalSource<Todo> {}

class TodoLocalSourceImpl implements TodoLocalSource {
  DatabaseFactory dbFactory = databaseFactoryIo;

  @override
  Future<Todo> add(Todo todo) async {
    Database db = await dbFactory.openDatabase(await _getDatabasePath());

    var store = StoreRef.main();

    var key = await store.add(db, todo.toMap());
    var record = await store.record(key).get(db) as Map<String, dynamic>;

    final newTodo = Todo.fromMap(record);

    newTodo.id = key as int;

    return newTodo;
  }

  @override
  Future<Unit> delete(int id) async {
    Database db = await dbFactory.openDatabase(await _getDatabasePath());

    var store = StoreRef.main();

    await store.record(id).delete(db);

    return unit;
  }

  @override
  Future<List<Todo>> getAll() async {
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
  Future<Unit> update(Todo todo) async {
    Database db = await dbFactory.openDatabase(await _getDatabasePath());

    var store = StoreRef.main();

    await store.record(todo.id).update(db, todo.toMap());

    return unit;
  }

  @override
  Future<Todo> get(int id) async {
    Database db = await dbFactory.openDatabase(await _getDatabasePath());

    var store = StoreRef.main();

    var record = await store.record(id).get(db) as Map<String, dynamic>;

    final newTodo = Todo.fromMap(record);

    newTodo.id = id;

    return newTodo;
  }

  Future<String> _getDatabasePath() async {
    String dbPath = 'todo.db';
    final dir = await getApplicationDocumentsDirectory();

    return dir.path + dbPath;
  }
}
