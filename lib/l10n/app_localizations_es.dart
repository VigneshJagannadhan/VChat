// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'VChat';

  @override
  String get appName => 'VChat';

  @override
  String get chatListTitle => 'VChat';

  @override
  String get searchLabel => 'Buscar';

  @override
  String get noChatMessage => 'Sin chats';

  @override
  String get sendMessagePlaceholder => '¡Envía un mensaje para comenzar!';

  @override
  String get userProfileTitle => 'Perfil de usuario';

  @override
  String get userListTitle => 'Lista de usuarios';

  @override
  String get searchUserLabel => 'Buscar usuario';

  @override
  String get noUsersFound => 'No se encontraron usuarios';

  @override
  String get noUsers => 'Sin usuarios';

  @override
  String get nameLabel => 'Nombre';

  @override
  String get emailLabel => 'Correo electrónico';

  @override
  String get saveButtonLabel => 'Guardar';

  @override
  String get logoutButtonLabel => 'Cerrar sesión';

  @override
  String get retryButtonLabel => 'Reintentar';

  @override
  String get updateAvailableTitle => 'Actualización disponible';

  @override
  String get updateLaterButtonLabel => 'Actualizar después';

  @override
  String get updateNowButtonLabel => 'Actualizar ahora';

  @override
  String get updateToContinueButtonLabel => 'Actualizar para continuar';

  @override
  String get defaultUpdateMessage =>
      'Una nueva versión de la aplicación está disponible. Por favor, actualiza para continuar.';

  @override
  String get confirmDialogTitle => 'Confirmar';

  @override
  String get okButtonLabel => 'Aceptar';

  @override
  String get cancelButtonLabel => 'Cancelar';

  @override
  String get generalErrorMessage => '¡Algo salió mal!';

  @override
  String get networkErrorMessage => 'Error de red. Por favor, intenta de nuevo';

  @override
  String get settingsButtonTooltip => 'Configuración';
}
