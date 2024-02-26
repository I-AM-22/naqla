

import 'package:dartz/dartz.dart';
import 'package:naqla/core/api/exceptions.dart';

typedef FutureResult<T> = Future<Either<AppException, T>>;
