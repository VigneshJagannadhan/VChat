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

  @override
  String get loadingLabel => 'Loading...';

  @override
  String get syncingLabel => 'Syncing...';

  @override
  String get syncingMessagesLabel => 'Syncing latest messages...';

  @override
  String get typingLabel => 'Typing...';

  @override
  String get messageHint => 'Message';

  @override
  String get showPasswordTooltip => 'Show password';

  @override
  String get hidePasswordTooltip => 'Hide password';

  @override
  String get unknownRouteMessage => 'Page not found';

  @override
  String get loginTitle => 'Login';

  @override
  String get registerTitle => 'Register';

  @override
  String get passwordLabel => 'Password';

  @override
  String get noAccountPrompt => 'Do not have an account?';

  @override
  String get haveAccountPrompt => 'Already have an account?';

  @override
  String get forgotPasswordLabel => 'Forgot Password?';

  @override
  String get featureInProgressMessage => 'Feature in progress!';

  @override
  String get pickProfileImageLabel => 'Pick a profile image';

  @override
  String get selectLanguageHint => 'Select language';

  @override
  String get todayLabel => 'Today';

  @override
  String get yesterdayLabel => 'Yesterday';

  @override
  String get confirmDialogMessage =>
      'Are you sure you want to perform this action?';

  @override
  String get messageNotSentLabel => 'Not sent. Tap to retry';

  @override
  String get retrySendHint => 'Retry sending';
}
