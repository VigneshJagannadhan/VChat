import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vignesh_project_01/core/di/locator.dart';
import 'package:vignesh_project_01/core/services/storage_service.dart';
import 'package:vignesh_project_01/core/services/update_service.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_list/chat_list_cubit.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_list/chat_list_states.dart';
import 'package:vignesh_project_01/features/chat/presentation/views/test.dart';
import 'package:vignesh_project_01/features/chat/presentation/widgets/chat_list_widget.dart';
import 'package:vignesh_project_01/features/chat/presentation/widgets/send_new_message_button.dart';
import 'package:vignesh_project_01/features/user/presentation/views/user_profile_view.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';
import 'package:vignesh_project_01/shared/others/popups/update_app_version_popup.dart';
import 'package:vignesh_project_01/shared/others/snackbars/general_snackbar.dart';
import 'package:vignesh_project_01/shared/presentation/cubits/update/update_cubit.dart';
import 'package:vignesh_project_01/shared/presentation/cubits/update/update_states.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/custom_empty_list_widget.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/custom_error_widget.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/custom_loader_widget.dart';

class ChatListView extends StatefulWidget {
  static const String route = '/home_view';
  const ChatListView({super.key});

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  late ChatCubit chatProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((v) async {
      chatProvider = context.read<ChatCubit>();
      StorageService storageService = locator<StorageService>();
      UpdateService updateService = locator<UpdateService>();
      UpdateCubit updateCubit = context.read<UpdateCubit>();

      var version = await updateService.findVersion();
      await storageService.saveVersion(version: version);
      await Future.wait<void>([
        updateCubit.checkForUpdate(),
        chatProvider.getChatList(),
      ]);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateCubit, UpdateStates>(
      listener: (context, state) {
        if (state is UpdateLoaded && state.isUpdateAvailable) {
          var isOptionalUpdate = !(state.updateEntity.forceUpdate ?? false);
          showUpdateAppVersionPopup(
            context: context,
            isOptionalUpdate: isOptionalUpdate,
            updateMessage: state.updateEntity.updateMessage,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.appTitle),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () =>
                  Navigator.of(context).pushNamed(UserProfileView.route),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: AkTextFormField(
                controller: _searchController,
                label: AppLocalizations.of(context)!.searchLabel,
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    chatProvider.getChatList(search: value);
                  });
                },
              ),
            ),
            SizedBox(height: 20.h),
            BlocConsumer<ChatCubit, ChatListState>(
              listener: (context, state) {
                if (state is ChatListFailure) {
                  showGeneralSnackbar(
                    context: context,
                    errorMessage: state.failure.message,
                  );
                }
              },
              builder: (context, state) {
                if (state is ChatListFailure) {
                  return CustomErrorWidget(
                    message: state.failure.message,
                    onRetry: () => context.read<ChatCubit>().getChatList(),
                  );
                }
                if (state is ChatListLoading) {
                  return CustomLoaderWidget();
                }

                if (state is ChatListLoaded) {
                  if (state.chats.isEmpty) {
                    return Expanded(
                      child: EmptyListWidget(
                        text: AppLocalizations.of(context)!.noChatMessage,
                      ),
                    );
                  }

                  return ChatListWidget(state: state);
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),

        floatingActionButton: SendNewMessageButton(),
      ),
    );
  }
}
