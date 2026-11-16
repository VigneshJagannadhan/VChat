import 'package:flutter/foundation.dart';

/// Optional test account that prefills the login form in debug builds.
///
/// Supply it at run time, never in source:
/// `flutter run --dart-define-from-file=config/dev.json`
/// (copy `config/dev.example.json` to `config/dev.json`, which is gitignored).
///
/// The [kDebugMode] guard makes every value compile to `''` in profile and
/// release builds, so these can't ship even if the file is passed by mistake.
abstract final class DevCredentials {
  static const String name = kDebugMode
      ? String.fromEnvironment('DEV_NAME')
      : '';
  static const String email = kDebugMode
      ? String.fromEnvironment('DEV_EMAIL')
      : '';
  static const String password = kDebugMode
      ? String.fromEnvironment('DEV_PASSWORD')
      : '';
}
