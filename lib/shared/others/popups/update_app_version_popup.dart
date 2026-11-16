import 'package:flutter/material.dart';
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
        title: Text(AppLocalizations.of(context)!.updateAvailableTitle),
        content: Text(
          updateMessage ?? AppLocalizations.of(context)!.defaultUpdateMessage,
        ),
        actions: [
          if (isOptionalUpdate)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.updateLaterButtonLabel),
            ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              isOptionalUpdate
                  ? AppLocalizations.of(context)!.updateNowButtonLabel
                  : AppLocalizations.of(context)!.updateToContinueButtonLabel,
            ),
          ),
        ],
      ),
    );
  },
);
