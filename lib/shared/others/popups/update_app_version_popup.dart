import 'package:flutter/material.dart';
import 'package:vignesh_project_01/core/themes/app_styles.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';

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
        title: Text(
          AppLocalizations.of(context)!.updateAvailableTitle,
          style: AppStyles.ts20W400cBlack,
        ),
        content: Text(
          updateMessage ?? AppLocalizations.of(context)!.defaultUpdateMessage,
          style: AppStyles.ts14W400cBlack,
        ),
        actions: [
          if (isOptionalUpdate)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                AppLocalizations.of(context)!.updateLaterButtonLabel,
                style: AppStyles.ts16W400cPrimary,
              ),
            ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              isOptionalUpdate
                  ? AppLocalizations.of(context)!.updateNowButtonLabel
                  : AppLocalizations.of(context)!.updateToContinueButtonLabel,
              style: AppStyles.ts16W400cPrimary,
            ),
          ),
        ],
      ),
    );
  },
);
