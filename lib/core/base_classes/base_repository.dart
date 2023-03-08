import 'package:dartz/dartz.dart';
import 'package:todo_riverpod/core/failures/failures.dart';

abstract class BaseRepository<TEntity, TId> {
  Future<Either<Failure, List<TEntity>>> getAll();

  Future<Either<Failure, TEntity>> get(TId id);

  Future<Either<Failure, TEntity>> add(TEntity entity);

  Future<Either<Failure, Unit>> update(TEntity entity);

  Future<Either<Failure, Unit>> delete(TId id);
}
