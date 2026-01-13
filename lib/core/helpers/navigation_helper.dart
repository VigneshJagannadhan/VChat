import 'package:flutter/material.dart';

class NavigationHelper {
  static Future<void> pushNamed({
    required BuildContext context,
    required String route,
  }) {
    return Navigator.of(context).pushNamed(route);
  }

  static Future<void> push({
    required BuildContext context,
    required Widget route,
  }) {
    return Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => route));
  }

  static Future<void> pushReplacementNamed({
    required BuildContext context,
    required String route,
  }) {
    return Navigator.of(context).pushReplacementNamed(route);
  }

  static Future<void> pushReplacement({
    required BuildContext context,
    required Widget route,
  }) {
    return Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => route));
  }

  static void pop({required BuildContext context}) {
    return Navigator.of(context).pop();
  }
}
