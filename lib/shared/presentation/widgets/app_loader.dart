import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:vignesh_project_01/core/constants/app_constants.dart';
import 'package:vignesh_project_01/core/extensions/theme_extensions.dart';
import 'package:vignesh_project_01/core/themes/app_dimens.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/body_text.dart';

/// Loading state.
///
/// [AppLoader] is the full-area version (animation + message) and sizes to
/// its parent, so wrap it in [Expanded] inside a [Column].
/// [AppLoader.inline] is a small spinner for tiles and rows.
class AppLoader extends StatelessWidget {
  const AppLoader({super.key, this.message}) : _inline = false;

  const AppLoader.inline({super.key}) : message = null, _inline = true;

  /// Defaults to the localized "Loading...".
  final String? message;
  final bool _inline;

  @override
  Widget build(BuildContext context) {
    if (_inline) return const CupertinoActivityIndicator();

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.sm,
        children: [
          Lottie.asset(
            AppConstants.lottieLoading,
            width: AppSizes.loader,
            height: AppSizes.loader,
          ),
          BodyText.large(
            message ?? AppLocalizations.of(context)!.loadingLabel,
            color: context.colors.tertiary,
          ),
        ],
      ),
    );
  }
}
