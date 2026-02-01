import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vignesh_project_01/core/themes/app_colors.dart';
import 'package:vignesh_project_01/core/themes/app_styles.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_detail/chat_detail_cubit.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_detail/chat_detail_states.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/custom_loader_widget.dart';

class ChatViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatViewAppBar({super.key, required this.name, required this.lastSeen});

  final String name;
  final String lastSeen;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      title: BlocBuilder<ChatDetailCubit, ChatDetailState>(
        builder: (context, state) {
          if (state is ChatDetailLoading) {
            return Text(
              'Syncing latest messages...',
              style: AppStyles.ts12W400cBlack,
            );
          }

          if (state is ChatDetailFailure) {
            return Text(state.failure.message);
          }

          if (state is ChatDetailLoaded) {
            return state.isSyncing
                ? Text(
                    'Syncing latest messages...',
                    style: AppStyles.ts12W400cBlack,
                  )
                : Row(
                    children: [
                      CircleAvatar(
                        radius: 20.r,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(name, style: AppStyles.ts16W400cBlack),
                          Text(lastSeen, style: AppStyles.ts10W400cBlack),
                        ],
                      ),
                    ],
                  );
          }

          return SizedBox.shrink();
        },
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size(1.sw, kToolbarHeight.h);
}
