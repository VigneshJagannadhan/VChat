import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_detail/chat_detail_cubit.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_detail/chat_detail_states.dart';
import 'package:vignesh_project_01/features/chat/presentation/widgets/message_list.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/custom_empty_list_widget.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/custom_error_widget.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/custom_loader_widget.dart';

class ChatViewMessageBody extends StatelessWidget {
  const ChatViewMessageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatDetailCubit, ChatDetailState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ChatDetailFailure) {
          return CustomErrorWidget(message: state.failure.message);
        }

        if (state is ChatDetailLoading) {
          return const CustomLoaderWidget();
        }

        if (state is ChatDetailLoaded) {
          return state.messages.isEmpty
              ? EmptyListWidget(
                  text: AppLocalizations.of(context)!.sendMessagePlaceholder,
                )
              : MessageList(state: state);
        }

        return EmptyListWidget(
          text: AppLocalizations.of(context)!.sendMessagePlaceholder,
        );
      },
    );
  }
}
