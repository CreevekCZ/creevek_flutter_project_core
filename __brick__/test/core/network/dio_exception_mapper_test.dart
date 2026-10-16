import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/core/exceptions/app_exception_type.dart';
import 'package:{{packageName}}/core/network/dio_exception_mapper.dart';

void main() {
  group('DioExceptionMapper', () {
    for (final timeoutType in [
      DioExceptionType.connectionTimeout,
      DioExceptionType.sendTimeout,
      DioExceptionType.receiveTimeout,
      DioExceptionType.transformTimeout,
    ]) {
      test('maps $timeoutType and preserves exception details', () {
        final stackTrace = StackTrace.current;
        final exception = DioException(
          requestOptions: RequestOptions(path: '/'),
          type: timeoutType,
          message: 'Request timed out',
          stackTrace: stackTrace,
        );
        final mapped = exception.toAppException();

        expect(mapped.type, AppExceptionType.connectionTimeout);
        expect(mapped.message, exception.message);
        expect(mapped.exception, same(exception));
        expect(mapped.stackTrace, same(stackTrace));
      });
    }

    test('maps unauthorized responses', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/'),
        response: Response<void>(
          requestOptions: RequestOptions(path: '/'),
          statusCode: 401,
        ),
        type: DioExceptionType.badResponse,
      );

      expect(
        exception.toAppException().type,
        AppExceptionType.unauthorized,
      );
    });
  });
}
