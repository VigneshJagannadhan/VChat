import 'package:flutter/material.dart';
import 'package:vignesh_project_01/core/themes/chat_colors.dart';

extension ThemeContextX on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  ChatColors get chatColors => Theme.of(this).extension<ChatColors>()!;
}
