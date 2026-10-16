#!/usr/bin/env bash
set -euo pipefail

# Generate a real consumer rather than analyzing uninterpolated Mustache files.
brick_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
flutter_bin="$(command -v "${FLUTTER_BIN:-flutter}")"
sdk_bin="$(cd "$(dirname "$flutter_bin")" && pwd)"
flutter_bin="$sdk_bin/$(basename "$flutter_bin")"
export PATH="$sdk_bin:$PATH"
expected_flutter="$(sed -n 's/.*"flutter": "\([^"]*\)".*/\1/p' "$brick_root/.fvmrc")"
actual_flutter="$("$flutter_bin" --version)"
case "$actual_flutter" in
  "Flutter $expected_flutter "*) ;;
  *) echo "Set FLUTTER_BIN to Flutter $expected_flutter/bin/flutter." >&2; exit 1 ;;
esac
command -v mason >/dev/null

consumer="$(mktemp -d "${TMPDIR:-/tmp}/creevek-brick-check.XXXXXX")"
echo "Validation project (retained for inspection): $consumer"
"$flutter_bin" create --empty --platforms=web --project-name=brick_smoke "$consumer"
cd "$consumer"
cat > mason.yaml <<YAML
bricks:
  creevek_flutter_project_core:
    path: "$brick_root"
YAML
mason get
mason make creevek_flutter_project_core --packageName brick_smoke --on-conflict overwrite
"$flutter_bin" pub upgrade

# Exercise generators which have no annotated model in the minimal starter.
mkdir -p lib/validation
cat > lib/validation/generator_smoke.dart <<'DART'
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

part 'generator_smoke.freezed.dart';
part 'generator_smoke.g.dart';

@freezed
@JsonSerializable()
class const GeneratorSmoke({required final String value}) with _$GeneratorSmoke {
  factory fromJson(Map<String, dynamic> json) =>
      _$GeneratorSmokeFromJson(json);

  Map<String, dynamic> toJson() => _$GeneratorSmokeToJson(this);
}

@HiveType(typeId: 0)
class HiveSmoke(@HiveField(0) final String value);
DART
cat > lib/validation/stale_model.dart <<'DART'
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stale_model.freezed.dart';

@freezed
class const StaleModel(final String value) with _$StaleModel;
DART
cat > test/generator_smoke_test.dart <<'DART'
import 'package:brick_smoke/validation/generator_smoke.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Freezed, JSON and Hive generation work together', () {
    const model = GeneratorSmoke(value: 'ok');
    expect(GeneratorSmoke.fromJson(model.toJson()), model);
    expect(model.copyWith(value: 'changed').value, 'changed');
    expect(HiveSmokeAdapter().typeId, 0);
  });
}
DART

cp pubspec.yaml pubspec.before-codegen.yaml
cp pubspec.lock pubspec.before-codegen.lock
"$sdk_bin/dart" run tool/generate.dart
# Incremental generation must retain assets and remove obsolete owned outputs.
test -s lib/validation/stale_model.freezed.dart
rm lib/validation/stale_model.dart
"$sdk_bin/dart" run tool/generate.dart
test -s lib/gen/assets.gen.dart
test ! -e lib/validation/stale_model.freezed.dart
# A failed builder must preserve published outputs and recover after its input is removed.
cp .dart_tool/codegen_outputs.json codegen-outputs.before.json
cp lib/validation/generator_smoke.g.dart generated.before.dart
cat > lib/validation/failed_model.dart <<'DART'
import 'package:hive_ce/hive.dart';
part 'failed_model.g.dart';

@HiveType(typeId: 1)
class FailedModel(@HiveField(0) final String a, @HiveField(0) final String b);
DART
if "$sdk_bin/dart" run tool/generate.dart > codegen-expected-failure.log 2>&1; then
  echo "Expected duplicate Hive field IDs to fail generation." >&2
  exit 1
fi
grep -q 'Duplicate field number' codegen-expected-failure.log
cmp .dart_tool/codegen_outputs.json codegen-outputs.before.json
cmp lib/validation/generator_smoke.g.dart generated.before.dart
rm lib/validation/failed_model.dart
"$sdk_bin/dart" run tool/generate.dart
test ! -e .dart_tool/codegen/lib/validation/failed_model.dart
rm codegen-outputs.before.json generated.before.dart
cmp pubspec.yaml pubspec.before-codegen.yaml
cmp pubspec.lock pubspec.before-codegen.lock
rm pubspec.before-codegen.yaml pubspec.before-codegen.lock
"$sdk_bin/dart" format lib/validation test/generator_smoke_test.dart
"$sdk_bin/dart" format --output=none --set-exit-if-changed lib test tool
"$flutter_bin" analyze
cp pubspec.yaml pubspec.validation.yaml
sed 's/^version: .*/version: 1.2.3+45/' pubspec.validation.yaml > pubspec.yaml
"$flutter_bin" test
mv pubspec.validation.yaml pubspec.yaml
"$flutter_bin" test test/ui/helpers/app_version_test.dart
"$flutter_bin" build web --wasm
echo "Brick validation passed: $consumer"
