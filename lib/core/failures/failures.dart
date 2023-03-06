import '../exceptions/api_exceptions.dart';
import '../exceptions/data_exceptions.dart';

abstract class Failure {
  final String message;
  final int? code;

  const Failure({required this.message, this.code});

  factory Failure.api(ApiException e) => ApiFailure(e);

  factory Failure.database(DatabaseException e) =>
      DatabaseFailure(message: e.message);

  factory Failure.tokenExpired() => TokenExpiredFailure();

  factory Failure.unknown([Exception? e]) => UnknownFailure(e);

  factory Failure.notFound() => const NotFoundFailure();
}

class NotFoundFailure extends Failure {
  const NotFoundFailure() : super(message: 'Not found');
}

class ApiFailure extends Failure {
  final ApiException exception;

  ApiFailure(this.exception)
      : super(message: exception.message, code: exception.code);
}

class DatabaseFailure extends Failure {
  DatabaseFailure({required String message})
      : super(message: message, code: -1);
}

class TokenExpiredFailure extends Failure {
  TokenExpiredFailure({String message = "Token expired"})
      : super(message: message, code: -1);
}

class UnknownFailure extends Failure {
  UnknownFailure([Exception? e])
      : super(message: e?.toString() ?? "An error occurred", code: -1);
}
