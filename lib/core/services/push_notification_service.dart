import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm;
  final FlutterLocalNotificationsPlugin _localNotifications;

  PushNotificationService({
    required FirebaseMessaging fcm,
    required FlutterLocalNotificationsPlugin localNotifications,
  }) : _fcm = fcm,
       _localNotifications = localNotifications;

  /* -------------------------------------------------------------------------- */
  /*                                 PUBLIC API                                 */
  /* -------------------------------------------------------------------------- */

  Future<void> initialize() async {
    await _requestPermission();
    await _initializeLocalNotifications();
    _configureFcmListeners();
  }

  Future<String?> getFcmToken() async {
    if (foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS) {
      // APNS token is required for FCM on iOS physical devices.
      // Retrying for up to 10 seconds.
      for (int i = 0; i < 10; i++) {
        String? apnsToken = await _fcm.getAPNSToken();
        if (apnsToken != null) break;
        log('APNS token is not available yet. Retry $i...');
        await Future.delayed(const Duration(seconds: 1));
      }

      // If still null, getToken() might fail with apns-token-not-set on physical devices
      // but succeed on simulators if configured correctly (though usually not recommended).
    }

    try {
      final token = await _fcm.getToken();
      log('FCM Token: $token');
      return token;
    } catch (e) {
      log('Error getting FCM token: $e');
      return null;
    }
  }

  Stream<String> onTokenRefresh() => _fcm.onTokenRefresh;

  /* -------------------------------------------------------------------------- */
  /*                                   SETUP                                    */
  /* -------------------------------------------------------------------------- */

  Future<void> _requestPermission() async {
    final settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    log('Notification permission: ${settings.authorizationStatus}');
  }

  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const iosSettings = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onLocalNotificationTap,
    );
  }

  void _configureFcmListeners() {
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onNotificationTap);

    _fcm.getInitialMessage().then((message) {
      if (message != null) {
        _onNotificationTap(message);
      }
    });
  }

  /* -------------------------------------------------------------------------- */
  /*                              MESSAGE HANDLING                               */
  /* -------------------------------------------------------------------------- */

  void _onForegroundMessage(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;

    _showLocalNotification(
      title: notification.title,
      body: notification.body,
      payload: message.data,
    );
  }

  void _onNotificationTap(RemoteMessage message) {
    log('Notification tapped (FCM): ${message.data}');

    /// Emit event / call NavigationService
  }

  void _onLocalNotificationTap(NotificationResponse response) {
    log('Notification tapped (Local): ${response.payload}');
  }

  /* -------------------------------------------------------------------------- */
  /*                           LOCAL NOTIFICATION                                */
  /* -------------------------------------------------------------------------- */

  Future<void> _showLocalNotification({
    required String? title,
    required String? body,
    Map<String, dynamic>? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      notificationDetails,
      payload: payload?.toString(),
    );
  }
}
