import 'package:dartz/dartz.dart';

import '../../core/failures/failures.dart';
import '../../core/mixins/parser_mixin.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../data_sources/local_todo_source.dart';

class TodoRepositoryImpl with ParserMixin implements TodoRepository {
  final TodoLocalSource localDataSource;

  TodoRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, Todo>> add(Todo entity) {
    return parse(localDataSource.add(entity));
  }

  @override
  Future<Either<Failure, Unit>> delete(int id) {
    return parse(localDataSource.delete(id));
  }

  @override
  Future<Either<Failure, Todo>> get(int id) {
    return parse(localDataSource.get(id));
  }

  @override
  Future<Either<Failure, List<Todo>>> getAll() {
    return parse(localDataSource.getAll());
  }

  @override
  Future<Either<Failure, Unit>> update(Todo entity) {
    return parse(localDataSource.update(entity));
  }
}
