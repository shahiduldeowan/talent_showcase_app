import 'package:talent_showcase_app/core/utils/type_defs.dart'
    show FutureResult;

/// An abstract class representing a use case in the application.
///
/// [T] is the return type of the use case.
/// [P] is the type of the parameter passed to the use case.
abstract class UseCase<T, P> {
  /// Executes the use case with the given [param].
  ///
  /// [param] is optional and can be null for use cases that do not require parameters.
  FutureResult<T> call({P? param});
}
