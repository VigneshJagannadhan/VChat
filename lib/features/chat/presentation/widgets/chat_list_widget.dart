import 'package:flutter/material.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_list/chat_list_states.dart';
import 'package:vignesh_project_01/features/chat/presentation/widgets/chat_list_item.dart';

class ChatListWidget extends StatelessWidget {
  const ChatListWidget({super.key, required this.state});

  final ChatListLoaded state;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: state.chats.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (_, index) => ChatListItem(chat: state.chats[index]),
    );
  }
}
