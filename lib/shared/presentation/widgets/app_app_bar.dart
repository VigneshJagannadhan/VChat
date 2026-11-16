import 'package:flutter/material.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/title_text.dart';

/// The app's only app bar. Colors and title style come from `appBarTheme`.
///
/// Pass [title] for a plain text title, or [titleWidget] for a custom one
/// (e.g. avatar + name in a chat). The back button is implied by the route.
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.centerTitle,
    this.showBackButton = true,
  }) : assert(
         title == null || titleWidget == null,
         'Pass either title or titleWidget, not both.',
       );

  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final bool? centerTitle;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return AppBar(
      automaticallyImplyLeading: showBackButton,
      centerTitle: centerTitle,
      title: titleWidget ?? (title == null ? null : TitleText.medium(title)),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
