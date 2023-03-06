abstract class ApiException implements Exception {
  final int code;
  final String message;

  const ApiException({required this.code, required this.message});
}

class BadRequestException extends ApiException {
  const BadRequestException({String? message})
      : super(code: 400, message: message ?? 'Your request is invalid');
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException({String? message})
      : super(
            code: 401,
            message:
                message ?? "You are not authorized to access this resource");
}

class ForbiddenException extends ApiException {
  const ForbiddenException({String? message})
      : super(
            code: 403,
            message: message ?? "You are not allowed to perform this action");
}

class NotFoundException extends ApiException {
  const NotFoundException({String? message})
      : super(
            code: 404,
            message: message ?? "The requested resource was not found");
}

class ServerException extends ApiException {
  const ServerException({String? message})
      : super(code: 500, message: message ?? "An error occurred on the server");
}

class ApiDataException extends ApiException {
  const ApiDataException({int? code, String? message})
      : super(
            code: code ?? 501,
            message: message ?? "Something went wrong with the data");
}

class UnknownException extends ApiException {
  const UnknownException({String message = "Something went wrong"})
      : super(code: -1, message: message);
}
