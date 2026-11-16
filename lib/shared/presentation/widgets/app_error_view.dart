import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vignesh_project_01/core/constants/app_constants.dart';
import 'package:vignesh_project_01/core/extensions/theme_extensions.dart';
import 'package:vignesh_project_01/core/themes/app_dimens.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_button.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/body_text.dart';

/// Error state with an optional retry button.
///
/// Sizes to its parent (no [Expanded] inside), so it works both as a
/// screen body and, wrapped in [Expanded], inside a [Column].
class AppErrorView extends StatelessWidget {
  const AppErrorView({super.key, this.message, this.onRetry});

  /// Defaults to the localized general error message.
  final String? message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final onRetry = this.onRetry;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.lg,
          children: [
            SvgPicture.asset(
              AppConstants.errorSvg,
              width: AppSizes.iconLg,
              height: AppSizes.iconLg,
              colorFilter: ColorFilter.mode(
                context.colors.error,
                BlendMode.srcIn,
              ),
            ),
            BodyText.medium(
              message ?? l10n.generalErrorMessage,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null)
              AppButton.primary(
                label: l10n.retryButtonLabel,
                onPressed: onRetry,
              ),
          ],
        ),
      ),
    );
  }
}
