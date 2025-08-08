enum AppEnvironment {
  dev,
  prod;

  factory AppEnvironment.fromString(String value) => switch (value) {
    'dev' => AppEnvironment.dev,
    'prod' => AppEnvironment.prod,
    _ => AppEnvironment.dev,
  };

  String get value => switch (this) {
    AppEnvironment.dev => 'dev',
    AppEnvironment.prod => 'prod',
  };

  String get baseUrl => switch (this) {
    AppEnvironment.dev => '',
    AppEnvironment.prod => '',
  };
}
