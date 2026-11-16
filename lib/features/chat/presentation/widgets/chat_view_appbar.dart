import 'package:flutter/material.dart';
import 'package:vignesh_project_01/core/themes/app_dimens.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_app_bar.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/label_text.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/title_text.dart';

class ChatViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatViewAppBar({super.key, required this.name, required this.lastSeen});

  final String name;
  final String lastSeen;

  @override
  Widget build(BuildContext context) {
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
                LabelText.small(lastSeen, overflow: TextOverflow.ellipsis),
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
