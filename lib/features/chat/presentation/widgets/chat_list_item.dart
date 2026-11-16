import 'package:flutter/material.dart';
import 'package:vignesh_project_01/core/extensions/theme_extensions.dart';
import 'package:vignesh_project_01/core/helpers/navigation_helper.dart';
import 'package:vignesh_project_01/core/routes/app_args.dart';
import 'package:vignesh_project_01/core/themes/app_dimens.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/chat_entity.dart';
import 'package:vignesh_project_01/features/chat/presentation/views/chat_view.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/body_text.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/label_text.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/title_text.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({super.key, required this.chat});

  final ChatEntity chat;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      leading: Stack(
        children: [
          const CircleAvatar(radius: AppSizes.avatarSm),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: context.chatColors.online,
              radius: AppSpacing.xs,
            ),
          ),
        ],
      ),
      title: TitleText.medium(chat.participantName),
      subtitle: BodyText.medium(
        chat.lastMessageContent,
        color: context.colors.onSurfaceVariant,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: LabelText.small(chat.lastMessageTime),
      onTap: () => NavigationHelper.pushNamed(
        context: context,
        route: ChatView.route,
        arguments: ChatDetailViewArgs(chatId: chat.id),
      ),
    );
  }
}
