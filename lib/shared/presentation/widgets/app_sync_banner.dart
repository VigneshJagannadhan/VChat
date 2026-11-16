import 'package:flutter/material.dart';
import 'package:vignesh_project_01/core/extensions/theme_extensions.dart';
import 'package:vignesh_project_01/core/themes/app_dimens.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/label_text.dart';

/// Thin full-width status strip that slides in under the app bar while
/// [visible]. Pass it to [AppScaffold.banner].
class AppSyncBanner extends StatelessWidget {
  const AppSyncBanner({
    super.key,
    required this.visible,
    required this.message,
  });

  final bool visible;
  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AnimatedSize(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      alignment: Alignment.topCenter,
      child: visible
          ? ColoredBox(
              color: colors.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
                child: Center(
                  child: LabelText.medium(
                    message,
                    color: colors.onPrimaryContainer,
                  ),
                ),
              ),
            )
          : const SizedBox(width: double.infinity),
    );
  }
}
