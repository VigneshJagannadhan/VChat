import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String appCacheBox = 'app_cache';

  Future<void> initialize() async {
    await Hive.initFlutter();

    await Hive.openBox(appCacheBox);
  }

  T get<T>({required String route}) {
    return Hive.box(appCacheBox).get(route);
  }

  Future<void> save<T>({
    required String route,
    required Map<String, dynamic> value,
  }) async {
    await Hive.box(appCacheBox).put(route, value);
  }

  Future<void> clearAll() async {
    await Hive.box(appCacheBox).clear();
  }
}
