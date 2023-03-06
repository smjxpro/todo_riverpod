import 'package:dartz/dartz.dart';
import 'package:todo_riverpod/core/failures/failures.dart';

abstract class BaseRepository<T> {
  Future<Either<Failure, List<T>>> getAll();

  Future<Either<Failure, T>> get(int id);

  Future<Either<Failure, T>> add(T entity);

  Future<Either<Failure, Unit>> update(T entity);

  Future<Either<Failure, Unit>> delete(int id);
}
