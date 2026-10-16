# Creevek Flutter Project Core

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=Flat-square&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=Flat-square&logo=dart&logoColor=white)

A Mason brick for a production-ready Flutter app foundation aligned with Flutter `3.47.7` and Dart `3.13.5`.

## Features

- **Flutter 3.47.7 baseline** - SDK constraints and package versions are aligned with Dart `3.13.5`.
- **State management** - `flutter_bloc`, `hydrated_bloc`, and `bloc_concurrency`.
- **Persistence** - Hive CE via `hive_ce` and `hive_ce_flutter`; the old `hive_flutter` package is no longer used.
- **Routing** - AutoRoute 11 named route definitions without a routing generator.
- **Dependency injection** - GetIt and Injectable modules.
- **Networking** - Dio module, Retrofit client foundation, and Dio exception mapping to app exception types.
- **OpenAPI/Swagger generation** - `openapi_retrofit_generator` config and starter `api/openapi.yaml` for generated Dio/Retrofit clients.
- **Localization** - Flutter gen-l10n with ARB files.
- **Linting** - `flutter_lints`, Dart 3.13 constructor rules, stricter async checks, targeted Flutter rules, strict inference, and a post-generation import sorter.
- **Testing foundation** - `bloc_test`, `mocktail`, and Alchemist golden test setup with starter Bloc, golden, and network mapper tests.
- **Asset tooling** - Flutter Gen for type-safe generated assets and `SvgGenImageExtension` helpers.
- **Modern Dart** - Dart 3.13 primary constructors, concise constructors, dot shorthand, guarded patterns, and null-aware map values throughout the starter.
- **Adaptive layout** - View-scoped `MediaQuery` selectors and percentage helpers, plus display-based orientation decisions for Android large screens.
- **Build metadata** - Flutter's `appBuildName` and `appBuildNumber` constants with a PackageInfo fallback.

## Requirements

| Tool | Version |
|------|---------|
| Flutter SDK | `3.47.7` or newer |
| Dart SDK | `3.13.5` or newer |
| Mason CLI | `0.1.4` or newer |

Flutter `3.47.7` ships with Dart `3.13.5`.

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
| `auto_route` | `^11.2.0` |
| `dio` | `^5.11.1` |
| `flutter_bloc` | `^9.1.1` |
| `get_it` | `^9.3.0` |
| `hive_ce` | `^2.22.0` |
| `hive_ce_flutter` | `^2.5.0` |
| `hydrated_bloc` | `^11.0.0` |
| `injectable` | `^3.0.0` |
| `retrofit` | `^4.10.0` |

### Code Generation And Testing

Generators are configured separately in `tool/codegen.yaml`; test packages stay
in the app pubspec.

| Package | Version |
|---------|---------|
| `alchemist` | `^0.14.1` |
| `bloc_test` | `^10.0.0` |
| `build_runner` | `^2.16.1` |
| `flutter_gen_runner` | `^5.15.0` |
| `freezed` | `^4.0.2` |
| `hive_ce_generator` | `^1.12.0` |
| `injectable_generator` | `^3.1.3` |
| `json_serializable` | `^6.14.1` |
| `mocktail` | `^1.0.5` |
| `openapi_retrofit_generator` | `^2.0.4` |
| `retrofit_generator` | `^10.2.12` |

> The package named `swagger_generator` is intentionally not included because its latest published version still declares a Dart SDK constraint below Dart 3. The brick uses `openapi_retrofit_generator`, which supports Swagger/OpenAPI specs and generates Retrofit/Dio clients for current Flutter.

## Getting Started

Install Mason if needed:

```bash
dart pub global activate mason_cli 0.1.4
```

For a new app, create the Flutter platform shell first:

```bash
flutter create my_app --project-name my_app --org com.example --platforms android,ios
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

The generated `.fvmrc` pins Flutter `3.47.7`. With FVM, run `fvm install`,
then prefix Flutter and Dart commands below with `fvm`. Keep Mason and its hooks
on the same Dart SDK (for example, add `.fvm/flutter_sdk/bin` to `PATH`).

Android requires compile SDK 37 for `permission_handler` 13. Flutter `3.47.7`
currently creates an Android shell using compile SDK 36 and Android Gradle
Plugin (AGP) `9.1.0`. After creating the shell:

1. Install the Android platform and build tools:

   ```bash
   sdkmanager 'platforms;android-37.0' 'build-tools;37.0.0'
   ```

2. Set the Android application plugin in `android/settings.gradle.kts`:

   ```kotlin
   id("com.android.application") version "9.1.1" apply false
   ```

3. Set `compileSdk = 37` inside the `android` block of
   `android/app/build.gradle.kts`. The shell's Gradle `9.3.1` wrapper can stay.

API 37.0 requires [AGP 9.1.1 or newer](https://developer.android.com/build/releases/about-agp#api-level-support);
AGP 9.1.0 cannot resolve the renamed `android-37.0` SDK package. The
[AGP 9.1 release requirements](https://developer.android.com/build/releases/agp-9-1-0-release-notes#compatibility)
specify Gradle `9.3.1`.

iOS camera, photo library, and other permission usage descriptions must be
configured when those features are added.

Install dependencies:

```bash
flutter pub get
```

When applying the upgrade over an existing app or a Flutter-created shell, run
`flutter pub upgrade` once to refresh compatible transitive packages in its lockfile.

Generate OpenAPI, Retrofit, DI, Freezed, JSON, Hive and assets:

```bash
dart run tool/generate.dart
```

Run tests:

```bash
flutter analyze
flutter test

# Only when intentionally reviewing a rendering change:
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
dart run tool/generate.dart
```

Generated clients are written to `lib/api`. Generator versions are configured in
`tool/codegen.yaml`; application and test dependencies remain in `pubspec.yaml`.

## Testing

The generated app includes:

- `test/helpers/hydrated_bloc_storage.dart` for HydratedBloc storage stubbing with Mocktail.
- `test/flutter_test_config.dart` for global Alchemist config.
- A starter `LanguageCubit` Bloc test.
- A starter CI-only `HomeScreen` Alchemist golden test with an initial baseline.
- A starter Dio exception mapper unit test.
- Regression tests for resize subscriptions, locale subtag persistence, dark mode, Cubit ownership, display-based orientation, and build metadata.

To validate this brick itself, install Mason and select the pinned SDK, then run:

```bash
FLUTTER_BIN="$HOME/fvm/versions/3.47.7/bin/flutter" ./tool/validate_brick.sh
```

The script creates a fresh web app in a temporary directory, runs Mason and its
hook, resolves packages, generates OpenAPI/Retrofit, DI and assets, and
exercises Freezed/JSON/Hive with primary-constructor model fixtures. It also
checks incremental generation, obsolete-output removal, recovery after a failed builder, and unchanged app manifests. It checks formatting,
runs analysis and tests (including goldens and embedded build metadata), and
builds JavaScript and WebAssembly release outputs with `flutter build web --wasm`.
It retains the generated project and prints its path for inspection.

## Upgrade notes

Package constraints were checked against stable pub.dev releases on 2026-10-17.
Runtime packages and the Freezed, Hive, Injectable, Retrofit, JSON and Flutter Gen
generators use their latest stable releases. Flutter remains pinned to `3.47.7`
with Dart `3.13.5`.

Dart 3.13 primary constructors are used for widgets, the Cubit, exceptions,
injectable classes, singleton constructors and the environment enum. Concise
factory declarations are used where redirecting or factory constructors are
needed. The validation fixtures exercise real primary constructors with Freezed
4, JSON serialization and Hive adapters.

### Generation and routing migration

Run `dart run tool/generate.dart` instead of invoking build_runner directly.
The command resolves `tool/codegen.yaml` in a private `.dart_tool/codegen/`
workspace and publishes generated files only after generation succeeds. It keeps
the app's pubspec, lockfile and normal package configuration intact. The cached
workspace supports repeat generation and tracks obsolete generated outputs.

This separation is necessary because Flutter 3.47.7's pinned `test_core` requires
analyzer below 14, while Freezed 4.0.2 and Hive's latest generator require analyzer
14. Both graphs resolve normally without dependency overrides, prereleases or
SDK edits. Do not add the generators back to the application's dev dependencies.

`build_runner` resolves to `2.16.1`, the newest compatible stable release:
`2.17.1` requires build 5 while the generators use build 4; `2.16.2` requires a
newer analyzer frontend than Injectable's current lean_builder supports.

AutoRoute remains at its latest stable release and uses the supported
`NamedRouteDef` API in `lib/routes.dart`. `auto_route_generator`, `@RoutePage`,
and `routes.gr.dart` are no longer needed. Navigate by name with
`router.push(NamedRoute('HomeRoute'))` or by path with `router.pushPath('/')`.
Existing apps migrating generated typed route arguments must update those call
sites to named routes and explicitly read parameters in each page builder.
See [AutoRoute's routing documentation](https://pub.dev/packages/auto_route#usage-without-code-generation).

### Lints

The template enables the six stable Dart 3.13 constructor rules:
`empty_container_bodies`, `initialize_in_field_declaration`,
`unnecessary_const_in_enum_constructor`, `unnecessary_primary_constructor_body`,
`unnecessary_type_name_in_constructor`, and `use_declaring_parameters`.
It also adds `async_return_with_no_await`, `unnecessary_async`,
`discarded_futures`, `parameter_assignments`, `avoid_slow_async_io`,
`matching_super_parameters`, `use_colored_box`, `use_decorated_box`,
`sized_box_shrink_expand`, and `use_named_constants`, with strict inference.
Deprecated analyzer settings and inactive legacy Dart Code Metrics configuration
were removed; generated Dart files are excluded from style checks.
See the official [Dart 3.13 changes](https://dart.dev/blog/announcing-dart-3-13).

`ResponsiveBuilder` now subscribes to its surrounding view's size instead of a
global first-view service. Prefer `context.rh(25)` and `context.rw(50)` from
`BuildContextX` in widgets; the numeric `.rh`/`.rw` helpers remain single-view
compatibility APIs. `ResponsiveSizeService.init(view: ...)` can explicitly select
a view for legacy callers. Orientation locks are released on displays at least
600 logical pixels wide, using `FlutterView.display` to avoid letterboxing errors.

HydratedBloc state now lives in application-support storage on native platforms.
Existing generated apps moving from the temporary-directory setup should migrate
their stored data before switching paths if they need to retain it. Locale
serialization preserves script/country subtags and still reads old language-only
state. The DI container owns and disposes the language Cubit; mounting or removing
`App` does not close the shared instance. The dark theme now uses a dark color
scheme. Launcher-icon tooling is a development dependency.
`cupertino_icons` supplies the font used by adaptive Cupertino controls and routes.

The starter Dio mapper handles
`DioExceptionType.transformTimeout` alongside the other timeout types.

Mason hooks are compiled locally from source. Compiled `.dill` files and hook
build caches are deliberately excluded because they depend on the Dart SDK.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
