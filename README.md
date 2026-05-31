# Creevek Flutter Project Core

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=Flat-square&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=Flat-square&logo=dart&logoColor=white)

A Mason brick for a production-ready Flutter app foundation aligned with Flutter `3.44.0` and Dart `3.12.0`.

## Features

- **Flutter 3.44.0 baseline** - SDK constraints and package versions are aligned with Dart `3.12.0`.
- **State management** - `flutter_bloc`, `hydrated_bloc`, and `bloc_concurrency`.
- **Persistence** - Hive CE via `hive_ce` and `hive_ce_flutter`; the old `hive_flutter` package is no longer used.
- **Routing** - AutoRoute with generated route definitions.
- **Dependency injection** - GetIt and Injectable modules.
- **Networking** - Dio module, Retrofit client foundation, and Dio exception mapping to app exception types.
- **OpenAPI/Swagger generation** - `openapi_retrofit_generator` config and starter `api/openapi.yaml` for generated Dio/Retrofit clients.
- **Localization** - Flutter gen-l10n with ARB files.
- **Linting** - `flutter_lints` plus the current official Dart recommended rules, `directives_ordering`, and a post-generation import sorter.
- **Testing foundation** - `bloc_test`, `mocktail`, and Alchemist golden test setup with starter Bloc, golden, and network mapper tests.
- **Asset tooling** - Flutter Gen for type-safe generated assets and `SvgGenImageExtension` helpers.

## Requirements

| Tool | Version |
|------|---------|
| Flutter SDK | `3.44.0` or newer |
| Dart SDK | `3.12.0` or newer |
| Mason CLI | `0.1.3` or newer |

Flutter `3.44.0` ships with Dart `3.12.0`.

## Generated Project

The brick creates a Flutter app with:

- `lib/core/app.dart` and `lib/core/app_setup.dart` for app bootstrap.
- `lib/core/network/` for Dio, Retrofit, and network exception handling.
- `lib/core/extensions/svg_gen_image_extension.dart` for generated SVG color helpers.
- `api/openapi.yaml` and `openapi_generator.yaml` for OpenAPI/Swagger client generation.
- `lib/features/home/` and `lib/features/language_settings/` as starter feature examples.
- `test/` helpers and examples for Bloc tests and Alchemist golden tests.
- A Mason `post_gen` hook that sorts Dart imports after `packageName` interpolation so `directives_ordering` works for generated apps.

## Package Highlights

### Runtime

| Package | Version |
|---------|---------|
| `auto_route` | `^11.1.0` |
| `dio` | `^5.9.2` |
| `flutter_bloc` | `^9.1.1` |
| `get_it` | `^9.2.1` |
| `hive_ce` | `^2.19.3` |
| `hive_ce_flutter` | `^2.3.4` |
| `hydrated_bloc` | `^11.0.0` |
| `injectable` | `^3.0.0` |
| `retrofit` | `^4.9.2` |

### Code Generation And Testing

| Package | Version |
|---------|---------|
| `alchemist` | `^0.14.0` |
| `auto_route_generator` | `^10.5.0` |
| `bloc_test` | `^10.0.0` |
| `build_runner` | `^2.15.0` |
| `flutter_gen_runner` | `^5.14.1` |
| `hive_ce_generator` | `^1.11.1` |
| `injectable_generator` | `^3.0.2` |
| `json_serializable` | `^6.14.0` |
| `mocktail` | `^1.0.5` |
| `openapi_retrofit_generator` | `^2.0.4` |
| `retrofit_generator` | `^10.2.6` |

> The package named `swagger_generator` is intentionally not included because its latest published version still declares a Dart SDK constraint below Dart 3. The brick uses `openapi_retrofit_generator`, which supports Swagger/OpenAPI specs and generates Retrofit/Dio clients for current Flutter.

## Getting Started

Install Mason if needed:

```bash
dart pub global activate mason_cli
```

For a new app, create the Flutter platform shell first:

```bash
flutter create my_app --project-name my_app
cd my_app
```

Initialize Mason and add the brick:

```bash
mason init
mason add creevek_flutter_project_core --git-url https://github.com/CreevekCZ/creevek_flutter_project_core
```

Generate the app foundation over the Flutter shell:

```bash
mason make creevek_flutter_project_core --on-conflict overwrite
```

Install dependencies:

```bash
flutter pub get
```

Generate OpenAPI and Dart code:

```bash
dart run openapi_retrofit_generator
dart run build_runner build
```

Run tests:

```bash
flutter test
flutter test --update-goldens
```

Run the app:

```bash
flutter run
```

If you generate the brick into an empty directory instead of a Flutter-created
project, `flutter test`, `flutter analyze`, and code generation still work after
`flutter pub get`, but `flutter run` needs platform folders from `flutter create`.

## Networking

The generated project includes a ready Injectable `NetworkModule` that registers:

- `Dio` with base URL, JSON headers, timeouts, and debug logging.
- `AppApiClient`, a starter Retrofit client.

For Swagger/OpenAPI-driven clients, edit `api/openapi.yaml`, then run:

```bash
dart run openapi_retrofit_generator
dart run build_runner build
```

Generated clients are written to `lib/api`.

## Testing

The generated app includes:

- `test/helpers/hydrated_bloc_storage.dart` for HydratedBloc storage stubbing with Mocktail.
- `test/flutter_test_config.dart` for global Alchemist config.
- A starter `LanguageCubit` Bloc test.
- A starter CI-only `HomeScreen` Alchemist golden test with an initial baseline.
- A starter Dio exception mapper unit test.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
