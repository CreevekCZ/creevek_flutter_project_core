import 'package:dio/dio.dart';

import '../exceptions/app_exception.dart';
import '../exceptions/app_exception_type.dart';

extension DioExceptionMapper on DioException {
  AppException<AppExceptionType> toAppException() {
    return AppException<AppExceptionType>(
      type: _appExceptionType,
      message: message,
      exception: this,
      stackTrace: stackTrace,
    );
  }

  AppExceptionType get _appExceptionType {
    return switch (type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => AppExceptionType.connectionTimeout,
      DioExceptionType.badCertificate => AppExceptionType.badCertificate,
      DioExceptionType.badResponse => _badResponseExceptionType,
      DioExceptionType.cancel => AppExceptionType.requestCancelled,
      DioExceptionType.connectionError => AppExceptionType.noInternetConnection,
      DioExceptionType.unknown => AppExceptionType.unknownError,
    };
  }

  AppExceptionType get _badResponseExceptionType {
    final statusCode = response?.statusCode;

    if (statusCode == null) {
      return AppExceptionType.unknownError;
    }

    if (statusCode >= 500 && statusCode < 600) {
      return AppExceptionType.serverError;
    }

    return switch (statusCode) {
      400 => AppExceptionType.validationError,
      401 => AppExceptionType.unauthorized,
      403 => AppExceptionType.forbidden,
      404 => AppExceptionType.notFound,
      409 => AppExceptionType.conflict,
      422 => AppExceptionType.validationError,
      429 => AppExceptionType.tooManyRequests,
      _ => AppExceptionType.unknownError,
    };
  }
}
