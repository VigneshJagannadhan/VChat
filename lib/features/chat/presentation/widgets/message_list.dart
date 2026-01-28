import 'package:flutter/material.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_detail/chat_detail_states.dart';
import 'package:vignesh_project_01/features/chat/presentation/widgets/message_bubble.dart';
import 'package:vignesh_project_01/features/chat/presentation/widgets/typing_message_bubble.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key, required this.state});

  final ChatDetailLoaded state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            reverse: true,
            itemCount: state.messages.length,
            itemBuilder: (context, index) =>
                MessageBubble(message: state.messages[index]),
          ),
        ),
        if (state.isTyping) TypingMessageBubble(),
      ],
    );
  }
}
