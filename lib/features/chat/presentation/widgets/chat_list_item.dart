import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vignesh_project_01/core/helpers/navigation_helper.dart';
import 'package:vignesh_project_01/core/routes/app_args.dart';
import 'package:vignesh_project_01/core/themes/app_colors.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/chat_entity.dart';
import 'package:vignesh_project_01/features/chat/presentation/views/chat_view.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({super.key, required this.chat});

  final ChatEntity chat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
        leading: Stack(
          children: [
            CircleAvatar(radius: 20.r),
            Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                backgroundColor: AppColors.onlineIndicator,
                radius: 5.r,
              ),
            ),
          ],
        ),
        title: Text(chat.participantName),
        subtitle: Text(chat.lastMessageContent),
        trailing: Text(chat.lastMessageTime),
        onTap: () => NavigationHelper.pushNamed(
          context: context,
          route: ChatView.route,
          arguments: ChatDetailViewArgs(chatId: chat.id),
        ),
      ),
    );
  }
}
