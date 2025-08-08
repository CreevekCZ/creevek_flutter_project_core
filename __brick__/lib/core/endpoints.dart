// ignore_for_file: library_private_types_in_public_api

abstract class Endpoints {
  static const EndpointsV1 v1 = EndpointsV1._();
}

class EndpointsV1 {
  const EndpointsV1._();

  String get _basePath => '/api/v1';

  String _path(String endpoint) => '$_basePath$endpoint';

  String get auth => _path('/auth');
}
