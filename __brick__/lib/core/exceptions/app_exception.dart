import 'app_exception_type.dart';

class const AppException<T extends AppExceptionType>({
  required final T type,
  final String? message,
  final Exception? exception,
  final StackTrace? stackTrace,
}) implements Exception {
  @override
  String toString() {
    final buffer = StringBuffer();

    if (message != null) {
      buffer.write(message);
    } else {
      buffer.write(type.toString());
    }

    if (exception != null) {
      buffer.write('\nCaused by: ${exception.toString()}');
    }

    if (stackTrace != null) {
      buffer.write('\nStack trace:\n$stackTrace');
    }

    return buffer.toString();
  }
}
