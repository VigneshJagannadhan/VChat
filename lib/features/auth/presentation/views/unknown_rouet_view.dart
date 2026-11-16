import 'package:flutter/material.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_app_bar.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_empty_view.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_scaffold.dart';

class UnknownRouteView extends StatelessWidget {
  static const String route = '/unknown_route_view';
  const UnknownRouteView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const AppAppBar(),
      body: AppEmptyView(
        message: AppLocalizations.of(context)!.unknownRouteMessage,
        icon: Icons.explore_off_outlined,
      ),
    );
  }
}
