import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_detail/chat_detail_cubit.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_detail/chat_detail_states.dart';
import 'package:vignesh_project_01/features/chat/presentation/widgets/message_list.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_empty_view.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_error_view.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_loader.dart';

class ChatViewMessageBody extends StatelessWidget {
  const ChatViewMessageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final emptyView = AppEmptyView(
      message: AppLocalizations.of(context)!.sendMessagePlaceholder,
    );

    return BlocBuilder<ChatDetailCubit, ChatDetailState>(
      builder: (context, state) => switch (state) {
        ChatDetailFailure(:final failure) => AppErrorView(
          message: failure.message,
        ),
        ChatDetailLoading() => const AppLoader(),
        ChatDetailLoaded(:final messages) when messages.isEmpty => emptyView,
        ChatDetailLoaded() => MessageList(state: state),
        ChatDetailInitial() => emptyView,
      },
    );
  }
}
