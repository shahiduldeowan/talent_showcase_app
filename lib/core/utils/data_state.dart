import 'package:talent_showcase_app/core/errors/failures.dart';

abstract class DataState<T> {
  const DataState();
}

class DataSuccess<T> extends DataState<T> {
  final T data;

  const DataSuccess(this.data);
}

class DataFailure<T> extends DataState<T> {
  final Failure failure;

  const DataFailure(this.failure);
}

class DataLoading<T> extends DataState<T> {
  const DataLoading();
}
