import 'package:flutter/foundation.dart';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../exceptions/api_exceptions.dart';

extension ParseJson on http.StreamedResponse {
  Future<T> parse<T>({T Function(String)? decoder}) async {
    var body = await stream.bytesToString();
    debugPrint("STATUS CODE: $statusCode");
    debugPrint("BODY: $body");
    if (decoder == null) {
      return unit as T;
    }
    switch (statusCode) {
      case 400:
        throw const BadRequestException();
      case 401:
        throw const UnauthorizedException();
      case 403:
        throw const ForbiddenException();
      case 404:
        throw const NotFoundException();
      case 500:
        throw const ServerException();
      case 509:
        throw const ApiDataException();
      default:
        return compute(decoder, body);
    }
  }
}
