import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vignesh_project_01/core/routes/app_args.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_list/chat_list_cubit.dart';
import 'package:vignesh_project_01/features/chat/presentation/views/chat_view.dart';
import 'package:vignesh_project_01/features/user/data/models/user/user_model.dart';
import 'package:vignesh_project_01/features/user/presentation/cubits/user_list/user_list_cubit.dart';
import 'package:vignesh_project_01/features/user/presentation/cubits/user_list/user_list_states.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/custom_error_widget.dart';
import 'package:vk_custom_widgets/vk_custom_widgets.dart';

class UserListView extends StatefulWidget {
  static const String route = '/user_list_view';
  const UserListView({super.key});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((v) async {
      UserListCubit userProvider = context.read<UserListCubit>();
      await userProvider.fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.userListTitle)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            VkTextFormField(
              controller: _searchController,
              label: AppLocalizations.of(context)!.searchUserLabel,
              onChanged: (value) {
                if (_debounce?.isActive ?? true) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 500), () {
                  context.read<UserListCubit>().fetchUsers(search: value);
                });
              },
            ),
            SizedBox(height: 20.h),
            BlocBuilder<UserListCubit, UserListState>(
              builder: (context, state) {
                if (state is UserListLoading) {
                  return const Center(child: CupertinoActivityIndicator());
                }
                if (state is UserListFailure) {
                  return CustomErrorWidget(
                    message: state.failure.message,
                    onRetry: () => context.read<UserListCubit>().fetchUsers(
                      search: _searchController.text,
                    ),
                  );
                }
                if (state is UserListLoaded) {
                  return state.users.isEmpty
                      ? Center(
                          child: Text(
                            AppLocalizations.of(context)!.noUsersFound,
                          ),
                        )
                      : Expanded(
                          child: ListView.separated(
                            itemCount: state.users.length,
                            separatorBuilder: (context, index) =>
                                Divider(height: 1.h, thickness: 1.h),
                            itemBuilder: (context, index) {
                              final user = state.users[index];
                              return UserListItem(user: user);
                            },
                          ),
                        );
                }

                return Center(
                  child: Text(AppLocalizations.of(context)!.noUsers),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UserListItem extends StatelessWidget {
  UserListItem({super.key, required this.user});

  final UserModel user;
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.username ?? ''),
      subtitle: Text(user.email ?? ''),
      leading: CircleAvatar(),
      trailing: ValueListenableBuilder(
        valueListenable: isLoading,
        builder: (context, value, child) {
          return value
              ? const CupertinoActivityIndicator()
              : Icon(Icons.arrow_forward_ios, size: 10.r);
        },
      ),
      onTap: () {
        isLoading.value = true;
        context
            .read<ChatCubit>()
            .getChatRoomId(id: user.id ?? '')
            .then((id) {
              if (context.mounted) {
                Navigator.pushReplacementNamed(
                  context,
                  ChatView.route,
                  arguments: ChatDetailViewArgs(chatId: id),
                );
              }
              isLoading.value = false;
            })
            .onError((error, stackTrace) {
              isLoading.value = false;
            });
      },
    );
  }
}
