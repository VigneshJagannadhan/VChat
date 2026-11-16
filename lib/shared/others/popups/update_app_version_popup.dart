import 'package:flutter/material.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_button.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/body_text.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/title_text.dart';

Future<dynamic> showUpdateAppVersionPopup({
  required BuildContext context,
  required bool isOptionalUpdate,
  String? updateMessage,
}) => showDialog(
  context: context,
  barrierDismissible: isOptionalUpdate,
  builder: (context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) => isOptionalUpdate,
      child: AlertDialog(
        title: TitleText.large(
          AppLocalizations.of(context)!.updateAvailableTitle,
        ),
        content: BodyText.medium(
          updateMessage ?? AppLocalizations.of(context)!.defaultUpdateMessage,
        ),
        actions: [
          if (isOptionalUpdate)
            AppButton.text(
              label: AppLocalizations.of(context)!.updateLaterButtonLabel,
              onPressed: () => Navigator.of(context).pop(),
            ),
          AppButton.text(
            label: isOptionalUpdate
                ? AppLocalizations.of(context)!.updateNowButtonLabel
                : AppLocalizations.of(context)!.updateToContinueButtonLabel,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  },
);
