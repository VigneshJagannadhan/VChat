import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignesh_project_01/core/constants/app_enums.dart';
import 'package:vignesh_project_01/core/helpers/locale_helpers.dart';
import 'package:vignesh_project_01/shared/presentation/cubits/locale/locale_states.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(const LocaleState(Locale('en')));

  void setLocale(SupportedLocales supportedLocale) {
    emit(LocaleState(supportedLocale.locale));
  }
}
