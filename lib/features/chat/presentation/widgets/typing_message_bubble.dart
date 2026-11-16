import 'package:flutter/material.dart';
import 'package:vignesh_project_01/core/extensions/theme_extensions.dart';
import 'package:vignesh_project_01/core/themes/app_dimens.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/label_text.dart';

class TypingMessageBubble extends StatelessWidget {
  const TypingMessageBubble({super.key});

  @override
  Widget build(BuildContext context) {
    final chatColors = context.chatColors;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsetsDirectional.only(
          start: AppSpacing.screenHorizontal,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.sm,
        ),
        decoration: ShapeDecoration(
          color: chatColors.receivedBubble,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
        ),
        child: LabelText.small(
          AppLocalizations.of(context)!.typingLabel,
          color: chatColors.onReceivedBubbleMuted,
        ),
      ),
    );
  }
}
