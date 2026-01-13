import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  /// Generic handler for requesting permission safely.
  static Future<bool> _handlePermission(Permission permission) async {
    final status = await permission.request();

    if (status.isGranted) return true;

    // If permanently denied → open settings
    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }

    return false;
  }

  /// Camera Permission
  static Future<bool> requestCameraPermission() async {
    return _handlePermission(Permission.camera);
  }

  /// Location Permission (fine location)
  static Future<bool> requestLocationPermission() async {
    return _handlePermission(Permission.locationWhenInUse);
  }

  /// Gallery Permission (IMAGES ONLY)
  /// Uses `Permission.photos` which is correct for Android 13+ and iOS.
  static Future<bool> requestGalleryPermission() async {
    return _handlePermission(Permission.photos);
  }

  /// Direct call to open settings if needed
  static Future<bool> openAppSettingsPage() async {
    return await openAppSettings();
  }
}
