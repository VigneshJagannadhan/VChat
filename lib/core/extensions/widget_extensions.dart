import 'package:flutter/cupertino.dart';

extension WidgetExtensions on Widget {
  Widget withEmptyWidget({
    required bool isEmpty,
    bool isLoading = false,
    required String text,
  }) {
    return isEmpty
        // No explicit style: inherits the theme's default (bodyMedium).
        ? Expanded(child: Center(child: Text(text)))
        : isLoading
        ? const Expanded(child: Center(child: CupertinoActivityIndicator()))
        : this;
  }
}
