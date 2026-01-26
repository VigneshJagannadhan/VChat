import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String appCacheBox = 'app_cache';
  static const String chatListBox = 'chat_list';
  static const String chatDetailBox = 'chat_detail';
  static const String userListBox = 'user_list';
  static const String profileBox = 'profile';

  Future<void> initialize() async {
    await Hive.initFlutter();

    await Hive.openBox(appCacheBox);
    await Hive.openBox(chatListBox);
    await Hive.openBox(chatDetailBox);
    await Hive.openBox(userListBox);
    await Hive.openBox(profileBox);
  }

  T? get<T>({required String route, required String box}) {
    final result = Hive.box(box).get(route);
    if (result == null) return null;
    if (result is Map) {
      return _recursiveCast(result) as T;
    }
    return result as T;
  }

  dynamic _recursiveCast(Map map) {
    return map.map((key, value) {
      final castedKey = key.toString();
      if (value is Map) {
        return MapEntry(castedKey, _recursiveCast(value));
      } else if (value is List) {
        return MapEntry(
          castedKey,
          value.map((e) => e is Map ? _recursiveCast(e) : e).toList(),
        );
      }
      return MapEntry(castedKey, value);
    });
  }

  Future<void> save<T>({
    required String route,
    required String box,
    required Map<String, dynamic> value,
  }) async {
    await Hive.box(box).put(route, value);
  }

  Future<void> clearAll() async {
    await Hive.box(appCacheBox).clear();
    await Hive.box(chatListBox).clear();
    await Hive.box(chatDetailBox).clear();
    await Hive.box(userListBox).clear();
    await Hive.box(profileBox).clear();
  }
}
