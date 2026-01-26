import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppUrls {
  static String getBaseUrl() => (dotenv.env['BASE_URL'] ?? '');

  static String baseUrl = '${getBaseUrl()}/api/';
  static String socketUrl = getBaseUrl();
  static const String signup = 'auth/register';
  static const String signin = 'auth/login';
  static const String fcmToken = 'user/fcm-token';
  static const String users = 'users';
  static const String chats = 'chats';
  static const String profile = 'profile';
  static const String sendMessage = 'chats/send';
  static const String checkForUpdate = 'app/version';
}
