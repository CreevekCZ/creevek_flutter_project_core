enum AppEnvironment(final String value) {
  dev('dev'),
  prod('prod');

  factory fromString(String value) => switch (value) {
    'dev' => .dev,
    'prod' => .prod,
    _ => .dev,
  };

  String get baseUrl => switch (this) {
    .dev => '',
    .prod => '',
  };
}
