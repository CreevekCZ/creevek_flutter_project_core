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

## 📦 Included Packages

### Core Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `auto_route` | ^10.1.0+1 | Type-safe routing and navigation |
| `bloc` | ^9.0.0 | State management core |
| `bloc_concurrency` | ^0.3.0 | BLoC concurrency utilities |
| `flutter_bloc` | ^9.1.1 | Flutter widgets for BLoC |
| `hydrated_bloc` | ^10.1.1 | Persistent state management |
| `get_it` | ^8.0.3 | Dependency injection service locator |
| `injectable` | ^2.5.0 | Dependency injection annotations |
| `freezed_annotation` | ^2.4.4 | Immutable data classes |
| `json_annotation` | ^4.9.0 | JSON serialization annotations |

### UI & Design

| Package | Version | Purpose |
|---------|---------|---------|
| `google_fonts` | ^6.2.1 | Google Fonts integration |
| `flutter_svg` | ^2.1.0 | SVG rendering support |
| `cached_network_image` | ^3.4.1 | Network image caching |
| `flutter_launcher_icons` | ^0.14.3 | App icon generation |

### Data & Storage

| Package | Version | Purpose |
|---------|---------|---------|
| `hive_flutter` | ^1.1.0 | Local database storage |
| `path_provider` | ^2.1.5 | File system access |
| `sqflite` | ^2.4.2 | SQLite database |

### Utilities & Services

| Package | Version | Purpose |
|---------|---------|---------|
| `package_info_plus` | ^8.3.0 | App package information |
| `connectivity_plus` | ^6.1.4 | Network connectivity monitoring |
| `image_picker` | ^1.1.2 | Image selection from gallery/camera |
| `permission_handler` | ^12.0.0+1 | Permission management |
| `uuid` | ^4.5.1 | Unique identifier generation |
| `logging` | ^1.2.0 | Structured logging |
| `intl` | ^0.20.2 | Internationalization |

### Development Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `auto_route_generator` | ^10.1.0 | Auto route code generation |
| `build_runner` | ^2.4.15 | Code generation runner |
| `freezed` | ^2.5.7 | Freezed code generation |
| `injectable_generator` | ^2.7.0 | Injectable code generation |
| `json_serializable` | ^6.8.0 | JSON serialization code generation |
| `flutter_gen_runner` | ^5.10.0 | Asset code generation |
| `arb_utils` | ^0.1.0+1 | ARB file utilities |
| `auto_translator` | ^2.3.5 | Automatic translation |
| `flutter_lints` | ^6.0.0 | Flutter linting rules |

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
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
   flutter packages pub run build_runner build --delete-conflicting-outputs
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