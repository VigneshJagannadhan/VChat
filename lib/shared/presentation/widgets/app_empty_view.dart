import 'package:flutter/material.dart';
import 'package:vignesh_project_01/core/extensions/theme_extensions.dart';
import 'package:vignesh_project_01/core/themes/app_dimens.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/body_text.dart';

/// Empty state (no chats, no users, no messages...).
///
/// Sizes to its parent (no [Expanded] inside), so wrap it in [Expanded]
/// inside a [Column].
class AppEmptyView extends StatelessWidget {
  const AppEmptyView({
    super.key,
    required this.message,
    this.icon = Icons.chat_bubble_outline_rounded,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final muted = context.colors.onSurfaceVariant;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.xl,
          children: [
            Icon(icon, size: AppSizes.iconXl, color: muted),
            BodyText.medium(message, color: muted, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
