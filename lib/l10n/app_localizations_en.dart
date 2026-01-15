// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'VChat';

  @override
  String get appName => 'VChat';

  @override
  String get chatListTitle => 'VChat';

  @override
  String get searchLabel => 'Search';

  @override
  String get noChatMessage => 'No Chats';

  @override
  String get sendMessagePlaceholder => 'Send a message to get started!';

  @override
  String get userProfileTitle => 'User Profile';

  @override
  String get userListTitle => 'User List';

  @override
  String get searchUserLabel => 'Search user';

  @override
  String get noUsersFound => 'No users found';

  @override
  String get noUsers => 'No Users';

  @override
  String get nameLabel => 'Name';

  @override
  String get emailLabel => 'Email';

  @override
  String get saveButtonLabel => 'Save';

  @override
  String get logoutButtonLabel => 'Logout';

  @override
  String get retryButtonLabel => 'Retry';

  @override
  String get updateAvailableTitle => 'Update Available';

  @override
  String get updateLaterButtonLabel => 'Update Later';

  @override
  String get updateNowButtonLabel => 'Update Now';

  @override
  String get updateToContinueButtonLabel => 'Update to continue';

  @override
  String get defaultUpdateMessage =>
      'A new version of the app is available. Please update to continue.';

  @override
  String get confirmDialogTitle => 'Confirm';

  @override
  String get okButtonLabel => 'OK';

  @override
  String get cancelButtonLabel => 'Cancel';

  @override
  String get generalErrorMessage => 'Something went wrong!';

  @override
  String get networkErrorMessage => 'Network error. Please try again';

  @override
  String get settingsButtonTooltip => 'Settings';
}
