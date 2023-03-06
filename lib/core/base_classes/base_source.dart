import 'package:dartz/dartz.dart';

abstract class BaseSource<T> {
  Future<List<T>> getAll();

  Future<T> get(int id);

  Future<T> add(T entity);

  Future<Unit> update(T entity);

  Future<Unit> delete(int id);
}

abstract class BaseRemoteSource<T> extends BaseSource<T> {}

abstract class BaseLocalSource<T> extends BaseSource<T> {}
