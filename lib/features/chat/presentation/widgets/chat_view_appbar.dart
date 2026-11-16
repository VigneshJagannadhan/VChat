import 'package:flutter/material.dart';
import 'package:vignesh_project_01/core/themes/app_dimens.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_app_bar.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/label_text.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/title_text.dart';

class ChatViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatViewAppBar({super.key, required this.name, this.subtitle});

  final String name;

  /// Optional second line (e.g. presence, once the backend tracks it).
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final subtitle = this.subtitle;
    return AppAppBar(
      centerTitle: false,
      titleWidget: Row(
        spacing: AppSpacing.sm,
        children: [
          const CircleAvatar(
            radius: AppSizes.avatarSm,
            child: Icon(Icons.person),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TitleText.medium(name, overflow: TextOverflow.ellipsis),
                if (subtitle != null)
                  LabelText.small(subtitle, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
