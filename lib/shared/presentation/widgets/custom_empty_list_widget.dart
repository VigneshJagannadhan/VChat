import 'package:flutter/material.dart';
import 'package:vignesh_project_01/core/themes/app_styles.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(child: Text(text, style: AppStyles.ts12W400cBlack)),
    );
  }
}
