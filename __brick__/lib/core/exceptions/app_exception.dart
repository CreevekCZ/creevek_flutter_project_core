import 'package:{{packageName}}/core/exceptions/app_exception_type.dart';

class AppException<T extends AppExceptionType> implements Exception {
  const AppException({
    required this.type,
    this.message,
    this.exception,
    this.stackTrace,
  });

  final T type;
  final String? message;
  final Exception? exception;
  final StackTrace? stackTrace;

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
