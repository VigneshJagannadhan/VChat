import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vignesh_project_01/core/extensions/date_time_extensions.dart';
import 'package:vignesh_project_01/core/routes/app_args.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/chat_entity.dart';
import 'package:vignesh_project_01/features/chat/presentation/views/chat_view.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({super.key, required this.chat});

  final ChatEntity chat;

  @override
  Widget build(BuildContext context) {
    final username = (chat.participant?.username ?? '').toUpperCase();
    final time = chat.lastMessage?.createdAt?.messageFormat() ?? '';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
        leading: Stack(
          children: [
            CircleAvatar(radius: 20.r),
            Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(backgroundColor: Colors.green, radius: 5.r),
            ),
          ],
        ),
        title: Text(username),
        subtitle: Text(chat.lastMessage?.content ?? ''),
        trailing: Text(time),
        onTap: () => Navigator.of(context).pushNamed(
          ChatView.route,
          arguments: ChatDetailViewArgs(chatId: chat.id),
        ),
      ),
    );
  }
}
