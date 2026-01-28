import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_list/chat_list_states.dart';
import 'package:vignesh_project_01/features/chat/presentation/widgets/chat_list_item.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/sync_widget.dart';

class ChatListWidget extends StatelessWidget {
  const ChatListWidget({super.key, required this.state});

  final ChatListLoaded state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView.builder(
            itemCount: state.chats.length,
            itemBuilder: (_, index) => ChatListItem(chat: state.chats[index]),
          ),
          if (state.isSyncing) Positioned(bottom: 30.h, child: SyncWidget()),
        ],
      ),
    );
  }
}
