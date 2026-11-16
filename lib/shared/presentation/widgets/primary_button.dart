import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Filled button. Colors come from the theme's `elevatedButtonTheme`
/// (primary / onPrimary) unless [color] / [foregroundColor] are given,
/// e.g. `context.colors.errorContainer` + `onErrorContainer` for destructive.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.color,
    this.foregroundColor,
    this.isLoading = false,
  });

  final String label;
  final Function() onTap;
  final Color? color;
  final Color? foregroundColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final fg = foregroundColor ?? Theme.of(context).colorScheme.onPrimary;
    return SizedBox(
      height: 55.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? () {} : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: fg,
        ),
        child: isLoading
            ? CupertinoActivityIndicator(color: fg)
            : Text(label),
      ),
    );
  }
}
