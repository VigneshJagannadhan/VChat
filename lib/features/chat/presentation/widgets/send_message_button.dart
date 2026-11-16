import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vignesh_project_01/core/constants/app_constants.dart';
import 'package:vignesh_project_01/core/extensions/theme_extensions.dart';
import 'package:vignesh_project_01/core/themes/app_dimens.dart';

class SendMessageButton extends StatelessWidget {
  const SendMessageButton({super.key, required this.onTap});

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final chatColors = context.chatColors;
    const size = AppSizes.sendButton;

    return Material(
      type: MaterialType.transparency,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: Ink(
        width: size,
        height: size,
        decoration: ShapeDecoration(
          shape: const CircleBorder(),
          gradient: chatColors.sentBubbleGradient,
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Center(
            child: SvgPicture.asset(
              AppConstants.sendSvg,
              colorFilter: ColorFilter.mode(
                chatColors.onSentBubble,
                BlendMode.srcIn,
              ),
              width: AppSizes.iconMd,
              height: AppSizes.iconMd,
            ),
          ),
        ),
      ),
    );
  }
}
