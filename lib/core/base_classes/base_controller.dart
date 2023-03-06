import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../failures/failures.dart';

abstract class BaseController<T> extends AsyncNotifier<T> {
  Future<void> handleFailure(Failure failure) async {
    switch (failure.runtimeType) {
      case Failure:
        state = AsyncValue.error(failure.message, StackTrace.current);
        break;
      case ApiFailure:
        state = AsyncValue.error(failure.message, StackTrace.current);
        break;
      case DatabaseFailure:
        state = AsyncValue.error(failure.message, StackTrace.current);
        break;
      case UnknownFailure:
        state = AsyncValue.error(failure.message, StackTrace.current);
        break;
      default:
        state = AsyncValue.error(failure.message, StackTrace.current);
        break;
    }
  }
}
