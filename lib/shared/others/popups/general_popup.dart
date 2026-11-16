import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vignesh_project_01/core/constants/app_constants.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';
import 'package:vignesh_project_01/core/extensions/theme_extensions.dart';
import 'package:vignesh_project_01/core/themes/app_dimens.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_button.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/body_text.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/title_text.dart';

Future<bool?> showGeneralPopup({
  required BuildContext context,
  required String? title,
  required String? message,
  String? confirmLabel,
  String? cancelLabel,
  bool singleButton = false,
  bool barrierDismissible = true,
}) async {
  return await showDialog<bool?>(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (context) {
      final l10n = AppLocalizations.of(context)!;
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xxl),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: AppSpacing.lg,
            children: [
              TitleText.large(title ?? l10n.confirmDialogTitle),
              Lottie.asset(AppConstants.lottieError, height: 100),
              BodyText.medium(
                message ?? l10n.confirmDialogMessage,
                color: context.colors.onSurfaceVariant,
                textAlign: TextAlign.center,
              ),
              AppButton.primary(
                label: confirmLabel ?? l10n.okButtonLabel,
                onPressed: () => Navigator.of(context).pop(true),
              ),
              if (!singleButton)
                AppButton.secondary(
                  label: cancelLabel ?? l10n.cancelButtonLabel,
                  onPressed: () => Navigator.of(context).pop(false),
                ),
            ],
          ),
        ),
      );
    },
  );
}
