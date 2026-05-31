import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/core/exceptions/app_exception_type.dart';
import 'package:{{packageName}}/core/network/dio_exception_mapper.dart';

void main() {
  group('DioExceptionMapper', () {
    test('maps connection timeout', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/'),
        type: DioExceptionType.connectionTimeout,
      );

      expect(
        exception.toAppException().type,
        AppExceptionType.connectionTimeout,
      );
    });

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
