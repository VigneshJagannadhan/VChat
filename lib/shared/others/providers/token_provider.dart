import 'package:vignesh_project_01/core/services/storage_service.dart';

abstract class TokenProvider {
  Future<String?> getAccessToken();
  void updateToken(String token);
  void clear();
}

class SecureTokenProvider implements TokenProvider {
  final StorageService storageService;

  String? _cachedToken;

  SecureTokenProvider(this.storageService);

  @override
  Future<String?> getAccessToken() async {
    if (_cachedToken != null) return _cachedToken;

    _cachedToken = await storageService.fetchAccessToken();
    return _cachedToken;
  }

  @override
  void updateToken(String token) {
    _cachedToken = token;
  }

  @override
  void clear() {
    _cachedToken = null;
  }
}
