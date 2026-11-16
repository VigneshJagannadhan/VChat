import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignesh_project_01/core/di/locator.dart';
import 'package:vignesh_project_01/core/services/storage_service.dart';
import 'package:vignesh_project_01/core/services/update_service.dart';
import 'package:vignesh_project_01/core/themes/app_dimens.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_list/chat_list_cubit.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_list/chat_list_states.dart';
import 'package:vignesh_project_01/features/chat/presentation/widgets/chat_list_widget.dart';
import 'package:vignesh_project_01/features/chat/presentation/widgets/start_new_chat_button.dart';
import 'package:vignesh_project_01/features/user/presentation/views/user_profile_view.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';
import 'package:vignesh_project_01/shared/others/popups/update_app_version_popup.dart';
import 'package:vignesh_project_01/shared/others/snackbars/general_snackbar.dart';
import 'package:vignesh_project_01/shared/presentation/cubits/update/update_cubit.dart';
import 'package:vignesh_project_01/shared/presentation/cubits/update/update_states.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_app_bar.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_empty_view.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_error_view.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_loader.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_scaffold.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_sync_banner.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_text_field.dart';

class ChatListView extends StatefulWidget {
  static const String route = '/home_view';
  const ChatListView({super.key});

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final chatCubit = context.read<ChatCubit>();
      final updateCubit = context.read<UpdateCubit>();
      final storageService = locator<StorageService>();
      final updateService = locator<UpdateService>();

      final version = await updateService.findVersion();
      await storageService.saveVersion(version: version);
      await Future.wait<void>([
        updateCubit.checkForUpdate(),
        chatCubit.getChatList(),
      ]);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<UpdateCubit, UpdateStates>(
      listener: (context, state) {
        if (state is UpdateLoaded && state.isUpdateAvailable) {
          final isOptionalUpdate = !(state.updateEntity.forceUpdate ?? false);
          showUpdateAppVersionPopup(
            context: context,
            isOptionalUpdate: isOptionalUpdate,
            updateMessage: state.updateEntity.updateMessage,
          );
        }
      },
      child: AppScaffold(
        appBar: AppAppBar(
          title: l10n.appTitle,
          showBackButton: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: l10n.settingsButtonTooltip,
              onPressed: () =>
                  Navigator.of(context).pushNamed(UserProfileView.route),
            ),
          ],
        ),
        banner: BlocBuilder<ChatCubit, ChatListState>(
          builder: (context, state) => AppSyncBanner(
            visible: state is ChatListLoaded && state.isSyncing,
            message: l10n.syncingLabel,
          ),
        ),
        floatingActionButton: const StartNewChatButton(),
        body: Column(
          children: [
            Padding(
              padding: AppSpacing.screen,
              child: AppTextField.search(
                controller: _searchController,
                label: l10n.searchLabel,
                onChanged: (value) =>
                    context.read<ChatCubit>().getChatList(search: value),
              ),
            ),
            Expanded(
              child: BlocConsumer<ChatCubit, ChatListState>(
                listener: (context, state) {
                  if (state is ChatListFailure) {
                    showGeneralSnackbar(
                      context: context,
                      errorMessage: state.failure.message,
                    );
                  }
                },
                builder: (context, state) {
                  return switch (state) {
                    ChatListFailure(:final failure) => AppErrorView(
                      message: failure.message,
                      onRetry: () => context.read<ChatCubit>().getChatList(
                        search: _searchController.text,
                      ),
                    ),
                    ChatListLoading() => const AppLoader(),
                    ChatListLoaded(:final chats) when chats.isEmpty =>
                      AppEmptyView(message: l10n.noChatMessage),
                    ChatListLoaded() => ChatListWidget(state: state),
                    ChatListInitial() => const SizedBox.shrink(),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
