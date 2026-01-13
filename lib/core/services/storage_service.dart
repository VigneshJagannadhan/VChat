import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vignesh_project_01/core/constants/app_constants.dart';

class StorageService {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  static SharedPreferences? _sharedPreferences;

  /// INITIALIZE STORAGE SERVICE
  Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> clearAll() async {
    await _sharedPreferences?.clear();
    await _secureStorage.deleteAll();
  }

  /// -------------------------- ACCESS TOKEN ----------------------------- ///
  Future<void> saveAccessToken({required String token}) async {
    await _secureStorage.write(key: AppConstants.spAccessToken, value: token);
  }

  Future<String?> fetchAccessToken() async {
    return await _secureStorage.read(key: AppConstants.spAccessToken);
  }

  Future<void> clearAccessToken() async {
    await _secureStorage.delete(key: AppConstants.spAccessToken);
  }

  /// -------------------------- REFRESH TOKEN ----------------------------- ///
  Future<void> saveRefreshToken({required String token}) async {
    await _secureStorage.write(key: AppConstants.spRefreshToken, value: token);
  }

  Future<String?> fetchRefreshToken() async {
    return await _secureStorage.read(key: AppConstants.spRefreshToken);
  }

  Future<void> clearRefreshToken() async {
    await _secureStorage.delete(key: AppConstants.spRefreshToken);
  }

  /// -------------------------- USER ID ----------------------------- ///
  Future<void> saveUserId({required String id}) async {
    await _sharedPreferences?.setString(AppConstants.spUserId, id);
  }

  String? fetchUserId() {
    return _sharedPreferences?.getString(AppConstants.spUserId);
  }

  Future<void> clearUserId() async {
    await _sharedPreferences?.remove(AppConstants.spUserId);
  }

  /// -------------------------- USER EMAIL ----------------------------- ///
  Future<void> saveUserEmail({required String email}) async {
    await _sharedPreferences?.setString(AppConstants.spUserEmail, email);
  }

  Future<String?>? fetchUserEmail() async {
    return _sharedPreferences?.getString(AppConstants.spUserEmail);
  }

  Future<void> clearUserEmail() async {
    await _sharedPreferences?.remove(AppConstants.spUserEmail);
  }

  /// -------------------------- THEME MODE ----------------------------- ///
  Future<void> setDarkMode({required bool value}) async {
    await _sharedPreferences?.setBool(AppConstants.spDarkMode, value);
  }

  bool? getDarkMode() {
    return _sharedPreferences?.getBool(AppConstants.spDarkMode);
  }

  Future<void> clearDarkMode() async {
    await _sharedPreferences?.remove(AppConstants.spDarkMode);
  }

  /// -------------------------- ACCESS TOKEN ----------------------------- ///
  Future saveAccessId({required String value}) async {
    await _secureStorage.write(key: AppConstants.spAccessId, value: value);
  }

  Future<String?> fetchAccessId() async {
    return await _secureStorage.read(key: AppConstants.spAccessId);
  }

  Future<void> clearAccessId() async {
    await _secureStorage.delete(key: AppConstants.spAccessId);
  }
}
