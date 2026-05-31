import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) {
  final sortedFiles = _sortDartImports();

  if (sortedFiles > 0) {
    context.logger.detail('Sorted imports in $sortedFiles Dart files.');
  }
}

int _sortDartImports() {
  var sortedFiles = 0;

  for (final directoryName in const ['lib', 'test', 'integration_test']) {
    final directory = Directory(directoryName);

    if (!directory.existsSync()) {
      continue;
    }

    for (final entity in directory.listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) {
        continue;
      }

      if (_shouldSkipFile(entity.path)) {
        continue;
      }

      if (_sortFileImports(entity)) {
        sortedFiles++;
      }
    }
  }

  return sortedFiles;
}

bool _shouldSkipFile(String path) {
  final normalizedPath = path.replaceAll(Platform.pathSeparator, '/');

  return normalizedPath.contains('/gen/') ||
      normalizedPath.endsWith('.config.dart') ||
      normalizedPath.endsWith('.freezed.dart') ||
      normalizedPath.endsWith('.g.dart') ||
      normalizedPath.endsWith('.gr.dart');
}

bool _sortFileImports(File file) {
  final original = file.readAsStringSync();
  final lines = original.split('\n');
  final importIndexes = <int>[];

  for (var index = 0; index < lines.length; index++) {
    if (_isImportLine(lines[index])) {
      importIndexes.add(index);
    }
  }

  if (importIndexes.length < 2) {
    return false;
  }

  final start = importIndexes.first;
  final end = importIndexes.last;

  for (var index = start; index <= end; index++) {
    final line = lines[index].trim();

    if (line.isEmpty) {
      continue;
    }

    if (!_isImportLine(line)) {
      return false;
    }
  }

  final imports = importIndexes.map((index) => lines[index].trim()).toList();
  final replacement = _sortImportLines(imports);
  final updatedLines = <String>[
    ...lines.take(start),
    ...replacement,
    ...lines.skip(end + 1),
  ];
  final updated = updatedLines.join('\n');

  if (updated == original) {
    return false;
  }

  file.writeAsStringSync(updated);

  return true;
}

List<String> _sortImportLines(List<String> imports) {
  final dartImports = <String>[];
  final packageImports = <String>[];
  final relativeImports = <String>[];

  for (final import in imports) {
    final uri = _importUri(import);

    if (uri.startsWith('dart:')) {
      dartImports.add(import);
    } else if (uri.startsWith('package:')) {
      packageImports.add(import);
    } else {
      relativeImports.add(import);
    }
  }

  final sortedGroups = [
    dartImports..sort(),
    packageImports..sort(),
    relativeImports..sort(),
  ].where((group) => group.isNotEmpty);
  final sortedImports = <String>[];

  for (final group in sortedGroups) {
    if (sortedImports.isNotEmpty) {
      sortedImports.add('');
    }

    sortedImports.addAll(group);
  }

  return sortedImports;
}

bool _isImportLine(String line) {
  return _importPattern.hasMatch(line.trim());
}

String _importUri(String line) {
  return _importPattern.firstMatch(line.trim())!.group(1)!;
}

final _importPattern = RegExp(r'''^import\s+['"]([^'"]+)['"].*;\s*$''');
