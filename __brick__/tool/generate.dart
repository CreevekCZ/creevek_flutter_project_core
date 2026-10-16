import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

/// Keeps modern generators independent of Flutter's pinned test analyzer.
Future<void> main() async {
  final root = File.fromUri(Platform.script).parent.parent;
  final cache = Directory.fromUri(root.uri.resolve('.dart_tool/'))
    ..createSync();
  final lock = File.fromUri(cache.uri.resolve('codegen.lock')).openSync(
    mode: FileMode.append,
  );
  try {
    lock.lockSync();
    await generate(root, Directory.fromUri(cache.uri.resolve('codegen/')));
  } finally {
    lock.closeSync();
  }
}

Future<void> generate(Directory root, Directory workspace) async {
  final pubspec = readYaml(File.fromUri(root.uri.resolve('pubspec.yaml')));
  final tooling = readYaml(File.fromUri(root.uri.resolve('tool/codegen.yaml')));
  final openapi = readYaml(
    File.fromUri(root.uri.resolve('openapi_generator.yaml')),
  );
  final openapiOptions = openapi['openapi_generator']! as Map<String, dynamic>;
  final apiOutput = openapiOptions['output_directory']! as String;
  if (!apiOutput.startsWith('lib/') || apiOutput.split('/').contains('..')) {
    throw StateError('OpenAPI output_directory must be inside lib/.');
  }

  workspace.createSync(recursive: true);
  // Keep builder-owned outputs for incremental builds. Track only copied inputs.
  final sourceLedger = File.fromUri(
    workspace.uri.resolve('.dart_tool/codegen_inputs.json'),
  );
  final previousInputs = sourceLedger.existsSync()
      ? (jsonDecode(sourceLedger.readAsStringSync()) as List<dynamic>)
            .cast<String>()
      : <String>[];
  final apiDirectory = Directory.fromUri(workspace.uri.resolve('$apiOutput/'));
  if (apiDirectory.existsSync()) {
    apiDirectory.deleteSync(recursive: true);
  }

  final inputs = <String, List<int>>{};
  for (final folder in ['lib', 'assets', 'api']) {
    final directory = Directory.fromUri(root.uri.resolve('$folder/'));
    if (!directory.existsSync()) {
      continue;
    }
    for (final file in directory.listSync(recursive: true).whereType<File>()) {
      final relative = p
          .relative(file.path, from: root.path)
          .replaceAll(p.separator, '/');
      if (isGenerated(relative, apiOutput)) {
        continue;
      }
      final bytes = file.readAsBytesSync();
      inputs[relative] = bytes;
      writeBytes(File(p.join(workspace.path, relative)), bytes);
    }
  }
  for (final name in [
    'analysis_options.yaml',
    'build.yaml',
    'l10n.yaml',
    'openapi_generator.yaml',
  ]) {
    final file = File.fromUri(root.uri.resolve(name));
    if (file.existsSync()) {
      final bytes = file.readAsBytesSync();
      inputs[name] = bytes;
      writeBytes(File(p.join(workspace.path, name)), bytes);
    }
  }
  for (final path in previousInputs) {
    validateRelativePath(path);
    if (!inputs.containsKey(path)) {
      final file = File(p.join(workspace.path, path));
      if (file.existsSync()) {
        file.deleteSync();
      }
    }
  }
  for (final name in ['pubspec.yaml', 'tool/codegen.yaml']) {
    inputs[name] = File.fromUri(root.uri.resolve(name)).readAsBytesSync();
  }

  final manifest = <String, dynamic>{
    for (final key in [
      'name',
      'description',
      'version',
      'environment',
      'dependencies',
      'dependency_overrides',
      'flutter',
      'flutter_gen',
    ])
      if (pubspec.containsKey(key)) key: pubspec[key],
    'publish_to': 'none',
    'dev_dependencies': tooling['dependencies'],
  };
  // Local path dependencies must still resolve relative to the real app.
  for (final section in ['dependencies', 'dependency_overrides']) {
    final dependencies = manifest[section] as Map<String, dynamic>?;
    for (final value in dependencies?.values ?? <dynamic>[]) {
      if (value is Map<String, dynamic>) {
        if (value['path'] case final String path) {
          value['path'] = p.isAbsolute(path)
              ? path
              : p.normalize(p.join(root.path, path));
        }
      }
    }
  }
  // JSON is valid YAML and preserves all nested pubspec structures.
  final manifestFile = File.fromUri(workspace.uri.resolve('pubspec.yaml'));
  final manifestText =
      '${const JsonEncoder.withIndent('  ').convert(manifest)}\n';
  if (!manifestFile.existsSync() ||
      manifestFile.readAsStringSync() != manifestText) {
    manifestFile.writeAsStringSync(manifestText);
  }

  // Record attempted inputs before a builder can fail, so retry can remove them.
  sourceLedger.parent.createSync(recursive: true);
  sourceLedger.writeAsStringSync(jsonEncode(inputs.keys.toList()));

  final flutter = flutterExecutable();
  await run(flutter, ['pub', 'get'], workspace);
  final dart = Platform.resolvedExecutable;
  await run(dart, ['run', 'openapi_retrofit_generator'], workspace);
  await run(dart, ['run', 'build_runner', 'build'], workspace);

  // Do not publish outputs if source files changed during generation.
  for (final entry in inputs.entries) {
    final file = File(p.join(root.path, entry.key));
    if (!file.existsSync() || !sameBytes(file.readAsBytesSync(), entry.value)) {
      throw StateError('${entry.key} changed during generation. Run again.');
    }
  }
  final outputs = <String>{};
  for (final file in Directory.fromUri(
    workspace.uri.resolve('lib/'),
  ).listSync(recursive: true).whereType<File>()) {
    final relative = p
        .relative(file.path, from: workspace.path)
        .replaceAll(p.separator, '/');
    if (!inputs.containsKey(relative)) {
      outputs.add(relative);
    }
  }
  final ledger = File.fromUri(
    root.uri.resolve('.dart_tool/codegen_outputs.json'),
  );
  final oldOutputs = ledger.existsSync()
      ? (jsonDecode(ledger.readAsStringSync()) as List<dynamic>).cast<String>()
      : <String>[];
  for (final path in oldOutputs) {
    validateRelativePath(path);
    if (!path.startsWith('lib/')) {
      throw StateError('Invalid generated output path: $path');
    }
    if (!outputs.contains(path)) {
      final file = File(p.join(root.path, path));
      if (file.existsSync()) {
        file.deleteSync();
      }
    }
  }
  for (final path in outputs) {
    writeBytes(
      File(p.join(root.path, path)),
      File(p.join(workspace.path, path)).readAsBytesSync(),
    );
  }
  ledger.writeAsStringSync(jsonEncode(outputs.toList()..sort()));
  stdout.writeln(
    'Generated ${outputs.length} files. App pubspec and lockfile unchanged.',
  );
}

Map<String, dynamic> readYaml(File file) =>
    jsonDecode(jsonEncode(loadYaml(file.readAsStringSync())))
        as Map<String, dynamic>;

void validateRelativePath(String path) {
  if (p.posix.isAbsolute(path) ||
      p.windows.isAbsolute(path) ||
      path.split(RegExp(r'[/\\]')).contains('..')) {
    throw StateError('Invalid cached path: $path');
  }
}

bool isGenerated(String path, String apiOutput) =>
    path.startsWith('$apiOutput/') ||
    path.startsWith('lib/gen/') ||
    RegExp(r'\.(g|freezed|config|gr|gen)\.dart$').hasMatch(path) ||
    path.startsWith('lib/l10n/app_localizations');

void writeBytes(File file, List<int> bytes) {
  if (file.existsSync() && sameBytes(file.readAsBytesSync(), bytes)) {
    return;
  }
  file.parent.createSync(recursive: true);
  file.writeAsBytesSync(bytes);
}

bool sameBytes(List<int> left, List<int> right) {
  if (left.length != right.length) {
    return false;
  }
  for (var i = 0; i < left.length; i++) {
    if (left[i] != right[i]) {
      return false;
    }
  }
  return true;
}

String flutterExecutable() {
  var directory = File(Platform.resolvedExecutable).parent;
  while (directory.parent.path != directory.path) {
    final file = File.fromUri(
      directory.uri.resolve(
        Platform.isWindows ? 'bin/flutter.bat' : 'bin/flutter',
      ),
    );
    if (file.existsSync()) {
      return file.path;
    }
    directory = directory.parent;
  }
  throw StateError('Run this script with the Dart SDK bundled with Flutter.');
}

Future<void> run(
  String executable,
  List<String> arguments,
  Directory directory,
) async {
  final process = await Process.start(
    executable,
    arguments,
    workingDirectory: directory.path,
    mode: ProcessStartMode.inheritStdio,
  );
  final code = await process.exitCode;
  if (code != 0) {
    throw ProcessException(executable, arguments, 'Generation failed', code);
  }
}
