import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'app_api_client.g.dart';

@RestApi()
// ignore: one_member_abstracts
abstract class AppApiClient {
  factory AppApiClient(
    Dio dio, {
    String? baseUrl,
  }) = _AppApiClient;

  @GET('/api/v1/health')
  Future<void> healthCheck();
}
