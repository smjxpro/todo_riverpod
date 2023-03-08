import 'package:dartz/dartz.dart';

abstract class BaseSource<TEntity, TId> {
  Future<List<TEntity>> getAll();

  Future<TEntity> get(TId id);

  Future<TEntity> add(TEntity entity);

  Future<Unit> update(TEntity entity);

  Future<Unit> delete(TId id);
}

abstract class BaseRemoteSource<TEntity, TId>
    extends BaseSource<TEntity, TId> {}

abstract class BaseLocalSource<TEntity, TId> extends BaseSource<TEntity, TId> {}
