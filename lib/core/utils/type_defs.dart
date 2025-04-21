import 'package:dartz/dartz.dart';
import 'package:talent_showcase_app/core/errors/failures.dart';

/// A type alias for a Future that completes with an Either value,
/// where the left side is a Failure and the right side is a value of type T.
///
/// This type alias is useful for representing asynchronous computations
/// that may complete with either a success or a failure.
typedef FutureResult<T> = Future<Either<Failure, T>>;
