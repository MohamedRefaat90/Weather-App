import '../errors/failures.dart';

/// Generic result type for operations that can succeed or fail
sealed class Result<T> {
  const Result();
}

/// Represents a successful operation with data
class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

/// Represents a failed operation with a failure
class Error<T> extends Result<T> {
  final Failure failure;
  const Error(this.failure);
}

/// Extension methods for Result type
extension ResultExtension<T> on Result<T> {
  /// Check if result is success
  bool get isSuccess => this is Success<T>;

  /// Check if result is error
  bool get isError => this is Error<T>;

  /// Get data or null
  T? get dataOrNull => this is Success<T> ? (this as Success<T>).data : null;

  /// Get failure or null
  Failure? get failureOrNull =>
      this is Error<T> ? (this as Error<T>).failure : null;

  /// Execute callback when success
  Result<T> onSuccess(void Function(T data) callback) {
    if (this is Success<T>) {
      callback((this as Success<T>).data);
    }
    return this;
  }

  /// Execute callback when error
  Result<T> onError(void Function(Failure failure) callback) {
    if (this is Error<T>) {
      callback((this as Error<T>).failure);
    }
    return this;
  }

  /// Fold result into a single value
  R fold<R>({
    required R Function(Failure failure) onError,
    required R Function(T data) onSuccess,
  }) {
    if (this is Success<T>) {
      return onSuccess((this as Success<T>).data);
    } else {
      return onError((this as Error<T>).failure);
    }
  }
}
