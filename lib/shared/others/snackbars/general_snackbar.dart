import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vignesh_project_01/core/constants/app_constants.dart';
import 'package:vignesh_project_01/core/extensions/theme_extensions.dart';
import 'package:vignesh_project_01/core/themes/app_dimens.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/body_text.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showGeneralSnackbar({
  required BuildContext context,
  required String? errorMessage,
  bool isFailure = true,
}) => ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.xl),
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.xl,
      vertical: AppSpacing.lg,
    ),
    content: Row(
      children: [
        SizedBox.square(
          dimension: AppSizes.iconLg,
          child: SvgPicture.asset(
            isFailure ? AppConstants.errorSvg : AppConstants.successSvg,
            colorFilter: ColorFilter.mode(
              isFailure ? context.colors.error : context.chatColors.success,
              BlendMode.srcIn,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: BodyText.medium(
            errorMessage ?? AppLocalizations.of(context)!.generalErrorMessage,
          ),
        ),
      ],
    ),
  ),
);
