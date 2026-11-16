import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignesh_project_01/core/extensions/theme_extensions.dart';
import 'package:vignesh_project_01/core/routes/app_args.dart';
import 'package:vignesh_project_01/core/themes/app_dimens.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_list/chat_list_cubit.dart';
import 'package:vignesh_project_01/features/chat/presentation/views/chat_view.dart';
import 'package:vignesh_project_01/features/user/domain/entities/user_entity.dart';
import 'package:vignesh_project_01/features/user/presentation/cubits/user_list/user_list_cubit.dart';
import 'package:vignesh_project_01/features/user/presentation/cubits/user_list/user_list_states.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_app_bar.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_empty_view.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_error_view.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_loader.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_scaffold.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_text_field.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/body_text.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/title_text.dart';

class UserListView extends StatefulWidget {
  static const String route = '/user_list_view';
  const UserListView({super.key});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserListCubit>().fetchUsers();
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

    return AppScaffold(
      appBar: AppAppBar(title: l10n.userListTitle),
      body: Column(
        children: [
          Padding(
            padding: AppSpacing.screen,
            child: AppTextField.search(
              controller: _searchController,
              label: l10n.searchUserLabel,
              onChanged: (value) =>
                  context.read<UserListCubit>().fetchUsers(search: value),
            ),
          ),
          Expanded(
            child: BlocBuilder<UserListCubit, UserListState>(
              builder: (context, state) => switch (state) {
                UserListLoading() => const AppLoader(),
                UserListFailure(:final failure) => AppErrorView(
                  message: failure.message,
                  onRetry: () => context.read<UserListCubit>().fetchUsers(
                    search: _searchController.text,
                  ),
                ),
                UserListLoaded(:final users) when users.isEmpty => AppEmptyView(
                  message: l10n.noUsersFound,
                  icon: Icons.person_search_outlined,
                ),
                UserListLoaded(:final users) => ListView.separated(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: users.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (_, index) => UserListItem(user: users[index]),
                ),
                UserListInitial() => AppEmptyView(
                  message: l10n.noUsers,
                  icon: Icons.person_search_outlined,
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UserListItem extends StatelessWidget {
  UserListItem({super.key, required this.user});

  final UserEntity user;
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      title: TitleText.medium(user.name ?? ''),
      subtitle: BodyText.medium(
        user.email ?? '',
        color: context.colors.onSurfaceVariant,
      ),
      leading: const CircleAvatar(),
      trailing: ValueListenableBuilder(
        valueListenable: isLoading,
        builder: (context, value, child) {
          return value
              ? const AppLoader.inline()
              : const Icon(Icons.arrow_forward_ios, size: AppSizes.iconXs);
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
