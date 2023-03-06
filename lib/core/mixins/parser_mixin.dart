import 'dart:ffi';

import 'package:dartz/dartz.dart';

import '../exceptions/api_exceptions.dart';
import '../exceptions/data_exceptions.dart';
import '../failures/failures.dart';

mixin ParserMixin {
  Future<Either<Failure, T>> parse<T>(Future<T> func) async {
    try {
      return Right(await func);
    } on ApiException catch (e) {
      return Left(Failure.api(e));
    } on DatabaseException catch (e) {
      return Left(Failure.database(e));
    } catch (e) {
      return Left(Failure.unknown());
    }
  }
}
