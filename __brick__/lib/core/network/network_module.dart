import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../environment/app_environment_provider.dart';
import 'app_api_client.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio(AppEnvironmentProvider environmentProvider) {
    final dio = Dio(
      BaseOptions(
        baseUrl: environmentProvider.environment.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: const {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );
    }

    return dio;
  }

  @lazySingleton
  AppApiClient appApiClient(
    Dio dio,
    AppEnvironmentProvider environmentProvider,
  ) {
    return AppApiClient(
      dio,
      baseUrl: environmentProvider.environment.baseUrl,
    );
  }
}
