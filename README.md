# Creevek Flutter Project Core

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=Flat-square&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=Flat-square&logo=dart&logoColor=white)

A Flutter project template brick that creates an application with a standard architecture, state management, routing, dependency injection, and localization features.

## 🚀 Features

This brick generates a Flutter project with the following features:

- **🔄 State Management** - BLoC pattern with `flutter_bloc` and `hydrated_bloc` for persistence
- **🛣️ Routing** - Auto route for type-safe navigation
- **💉 Dependency Injection** - Injectable with GetIt for service locator pattern
- **🌍 Localization** - Multi-language support with ARB files
- **📱 Useful helper widgets** - UI helpers such as `MultiValueListenableBuilder`, `Unfocuser` and more
- **💾 Data** - Hive and Hydrated BLoC for local storage and Freezed for immutable data classes
- **📦 Asset Management** - Flutter Gen for type-safe asset access

## 🧰 Requirements

| Tool | Minimum Version |
|------|-----------------|
| Flutter SDK | 3.35.0 |
| Dart SDK | 3.9.0 |
| Mason CLI | 0.1.3 |

> Validated against Flutter 3.41.4 / Dart 3.11.1.

## 📦 Included Packages

### Core Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `auto_route` | ^11.1.0 | Type-safe routing and navigation |
| `bloc_concurrency` | ^0.3.0 | BLoC concurrency utilities |
| `collection` | ^1.19.1 | Collection utilities |
| `flutter_bloc` | ^9.1.1 | Flutter widgets for BLoC |
| `hydrated_bloc` | ^11.0.0 | Persistent state management |
| `get_it` | ^9.2.1 | Dependency injection service locator |
| `injectable` | ^3.0.0 | Dependency injection annotations |
| `freezed_annotation` | ^3.1.0 | Immutable data classes |
| `json_annotation` | ^4.12.0 | JSON serialization annotations |

### UI & Design

| Package | Version | Purpose |
|---------|---------|---------|
| `google_fonts` | ^8.1.0 | Google Fonts integration |
| `flutter_svg` | ^2.3.0 | SVG rendering support |
| `cached_network_image` | ^3.4.1 | Network image caching |
| `flutter_launcher_icons` | ^0.14.4 | App icon generation |
| `flutter_localizations` | SDK | Flutter localization support |
| `flutter_web_plugins` | SDK | Flutter web plugin support |

### Data & Storage

| Package | Version | Purpose |
|---------|---------|---------|
| `hive_flutter` | ^1.1.0 | Local database storage |
| `path_provider` | ^2.1.5 | File system access |

### Utilities & Services

| Package | Version | Purpose |
|---------|---------|---------|
| `package_info_plus` | ^10.1.0 | App package information |
| `connectivity_plus` | ^7.1.1 | Network connectivity monitoring |
| `image_picker` | ^1.2.2 | Image selection from gallery/camera |
| `permission_handler` | ^12.0.1 | Permission management |
| `uuid` | ^4.5.3 | Unique identifier generation |
| `logging` | ^1.3.0 | Structured logging |
| `intl` | ^0.20.2 | Internationalization |

### Development Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `auto_route_generator` | ^10.5.0 | Auto route code generation |
| `build_runner` | ^2.15.0 | Code generation runner |
| `freezed` | ^3.2.5 | Freezed code generation |
| `injectable_generator` | ^3.0.2 | Injectable code generation |
| `json_serializable` | ^6.14.0 | JSON serialization code generation |
| `flutter_gen_runner` | ^5.14.1 | Asset code generation |
| `arb_utils` | ^0.11.0 | ARB file utilities |
| `auto_translator` | ^2.3.5 | Automatic translation |
| `flutter_lints` | ^6.0.0 | Flutter linting rules |

### Dependency Overrides

The brick pins `win32: ^6.0.1` so the latest `package_info_plus` (which depends on
`win32` 6.x) can coexist with `arb_utils` (whose transitive `dart_console`
dependency caps `win32` below 6.0.0). The override only affects the dev-time
`arb_utils` CLI tooling and has no impact on app runtime.

## 🚀 Getting Started

### Prerequisites

- Flutter SDK >= 3.35.0
- Dart SDK >= 3.9.0
- Mason CLI

### Installation

You can set up the project in two ways, depending on whether you already have Mason initialized in your project.

---

#### **A. If you have NOT set up Mason in your project yet**

1. **Install Mason CLI** (if not already installed):
   ```bash
   dart pub global activate mason_cli
   ```

2. **Initialize Mason in your project** (creates a `mason.yaml` file):
   ```bash
   mason init
   ```

3. **Add the brick from GitHub**:
   ```bash
   mason add creevek_flutter_project_core --git-url https://github.com/CreevekCZ/creevek_flutter_project_core
   ```

4. **Generate a new Flutter project**:
   ```bash
   mason make creevek_flutter_project_core
   ```

---

#### **B. If you ALREADY have Mason set up in your project**

1. **Add the brick from GitHub**:
   ```bash
   mason add creevek_flutter_project_core --git-url https://github.com/CreevekCZ/creevek_flutter_project_core
   ```

2. **Generate a new Flutter project**:
   ```bash
   mason make creevek_flutter_project_core
   ```

### Post-Generation Setup

1. **Install dependencies**:
   ```bash
   flutter pub get
   ```

2. **Generate code**:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test the brick with a new project
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
