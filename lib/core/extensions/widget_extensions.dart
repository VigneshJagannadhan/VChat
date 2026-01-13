import 'package:flutter/cupertino.dart';
import 'package:vignesh_project_01/core/themes/app_styles.dart';

extension WidgetExtensions on Widget {
  Widget withEmptyWidget({
    required bool isEmpty,
    bool isLoading = false,
    required String text,
  }) {
    return isEmpty
        ? Expanded(
            child: Center(child: Text(text, style: AppStyles.ts16W400cBlack)),
          )
        : isLoading
        ? Expanded(child: Center(child: CupertinoActivityIndicator()))
        : this;
  }
}
