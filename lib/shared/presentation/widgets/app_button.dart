import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vignesh_project_01/core/extensions/theme_extensions.dart';
import 'package:vignesh_project_01/core/themes/app_dimens.dart';

enum _AppButtonVariant { primary, secondary, destructive, text }

/// The app's only button. Base styling comes from the theme's
/// `filledButtonTheme` / `outlinedButtonTheme` / `textButtonTheme`.
///
/// Accessibility is handled here: the button exposes a single semantics node
/// (label + button role + tap action) so screen readers announce it once,
/// including while [isLoading] shows a spinner instead of the label.
class AppButton extends StatelessWidget {
  const AppButton.primary({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.fullWidth = true,
  }) : _variant = _AppButtonVariant.primary;

  const AppButton.secondary({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.fullWidth = true,
  }) : _variant = _AppButtonVariant.secondary;

  const AppButton.destructive({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.fullWidth = true,
  }) : _variant = _AppButtonVariant.destructive;

  /// Low-emphasis button for links and dialog actions. Not full width.
  const AppButton.text({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.fullWidth = false,
  }) : _variant = _AppButtonVariant.text;

  final String label;

  /// `null` disables the button.
  final VoidCallback? onPressed;

  /// Shows a spinner and ignores taps, while keeping the enabled colors.
  final bool isLoading;
  final bool fullWidth;
  final _AppButtonVariant _variant;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final enabled = onPressed != null;

    final foreground = switch (_variant) {
      _AppButtonVariant.primary => colors.onPrimary,
      _AppButtonVariant.destructive => colors.onErrorContainer,
      _AppButtonVariant.secondary || _AppButtonVariant.text => colors.tertiary,
    };

    final child = isLoading
        ? CupertinoActivityIndicator(color: foreground)
        : Text(label);

    final Widget button = switch (_variant) {
      _AppButtonVariant.primary => FilledButton(
        onPressed: onPressed,
        child: child,
      ),
      _AppButtonVariant.destructive => FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: colors.errorContainer,
          foregroundColor: colors.onErrorContainer,
        ),
        child: child,
      ),
      _AppButtonVariant.secondary => OutlinedButton(
        onPressed: onPressed,
        child: child,
      ),
      _AppButtonVariant.text => TextButton(onPressed: onPressed, child: child),
    };

    return Semantics(
      button: true,
      enabled: enabled,
      label: label,
      onTap: enabled && !isLoading ? onPressed : null,
      excludeSemantics: true,
      child: IgnorePointer(
        ignoring: isLoading,
        child: fullWidth
            ? SizedBox(
                width: double.infinity,
                height: AppSizes.controlHeight,
                child: button,
              )
            : button,
      ),
    );
  }
}
