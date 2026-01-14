import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Initialize Firebase in the background isolate. Native config (google-services/Plist)
  // will be used so no options are required here.
  try {
    await Firebase.initializeApp();
  } catch (_) {
    // Already initialized or initialization not required.
  }

  // Handle background message if needed. Keep lightweight.
}
