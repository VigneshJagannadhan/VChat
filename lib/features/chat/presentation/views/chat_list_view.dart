import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vignesh_project_01/core/extensions/date_time_extensions.dart';
import 'package:vignesh_project_01/core/routes/app_args.dart';
import 'package:vignesh_project_01/core/themes/app_colors.dart';
import 'package:vignesh_project_01/core/themes/app_styles.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_list/chat_list_cubit.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_list/chat_list_states.dart';
import 'package:vignesh_project_01/features/chat/presentation/views/chat_view.dart';
import 'package:vignesh_project_01/features/chat/presentation/views/test.dart';
import 'package:vignesh_project_01/features/user/presentation/views/user_list_view.dart';
import 'package:vignesh_project_01/features/user/presentation/views/user_profile_view.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';
import 'package:vignesh_project_01/shared/others/snackbars/general_snackbar.dart';
import 'package:vignesh_project_01/shared/presentation/cubits/update/update_cubit.dart';
import 'package:vignesh_project_01/shared/presentation/cubits/update/update_states.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/custom_error_widget.dart';

class ChatListView extends StatefulWidget {
  static const String route = '/home_view';
  const ChatListView({super.key});

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  ChatCubit? chatProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((v) async {
      chatProvider = context.read<ChatCubit>();
      UpdateCubit updateCubit = context.read<UpdateCubit>();

      await chatProvider?.getChatList();
      updateCubit.checkForUpdate();
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

          showDialog(
            context: context,
            barrierDismissible: isOptionalUpdate,
            builder: (context) {
              return PopScope(
                onPopInvokedWithResult: (didPop, result) => isOptionalUpdate,
                child: AlertDialog(
                  title: Text(
                    AppLocalizations.of(context)!.updateAvailableTitle,
                    style: AppStyles.ts20W400cBlack,
                  ),
                  content: Text(
                    state.updateEntity.updateMessage ??
                        AppLocalizations.of(context)!.defaultUpdateMessage,
                    style: AppStyles.ts14W400cBlack,
                  ),
                  actions: [
                    if (isOptionalUpdate)
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.updateLaterButtonLabel,
                          style: AppStyles.ts16W400cPrimary,
                        ),
                      ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        isOptionalUpdate
                            ? AppLocalizations.of(context)!.updateNowButtonLabel
                            : AppLocalizations.of(
                                context,
                              )!.updateToContinueButtonLabel,
                        style: AppStyles.ts16W400cPrimary,
                      ),
                    ),
                  ],
                ),
              );
            },
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
                    chatProvider?.getChatList(search: value);
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
                  return const Expanded(
                    child: Center(child: CupertinoActivityIndicator()),
                  );
                }

                if (state is ChatListLoaded) {
                  if (state.chats.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.noChatMessage,
                          style: AppStyles.ts12W400cBlack,
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView.separated(
                      itemCount: state.chats.length,
                      separatorBuilder: (context, index) =>
                          Divider(height: 0.5.h, thickness: 0.5.h),
                      itemBuilder: (_, index) {
                        final chat = state.chats[index];
                        final username = chat.participant?.username ?? '';
                        final time =
                            chat.lastMessage?.createdAt?.messageFormat() ?? '';

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                            ),
                            leading: Stack(
                              children: [
                                CircleAvatar(radius: 20.r),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.green,
                                    radius: 5.r,
                                  ),
                                ),
                              ],
                            ),
                            title: Text(username.toUpperCase()),
                            subtitle: Text(chat.lastMessage?.content ?? ''),
                            trailing: Text(time),
                            onTap: () => Navigator.of(context).pushNamed(
                              ChatView.route,
                              arguments: ChatDetailViewArgs(chatId: chat.id),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,

          onPressed: () => Navigator.pushNamed(context, UserListView.route),
          child: Icon(Icons.message_outlined, color: Colors.white),
        ),
      ),
    );
  }
}
