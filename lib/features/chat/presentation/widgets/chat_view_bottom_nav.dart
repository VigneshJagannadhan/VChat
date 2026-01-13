import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vignesh_project_01/core/constants/app_constants.dart';
import 'package:vignesh_project_01/core/di/locator.dart';
import 'package:vignesh_project_01/core/services/socket_service.dart';
import 'package:vignesh_project_01/core/themes/app_colors.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_detail/chat_detail_cubit.dart';
import 'package:vk_custom_widgets/vk_custom_widgets.dart';

class ChatViewBottomNav extends StatefulWidget {
  const ChatViewBottomNav({
    super.key,
    required this.messageController,
    required this.chatId,
  });
  final TextEditingController messageController;
  final String? chatId;

  @override
  State<ChatViewBottomNav> createState() => _ChatViewBottomNavState();
}

class _ChatViewBottomNavState extends State<ChatViewBottomNav> {
  Timer? _debounce;

  bool _isTyping = false;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColors.scaffoldBackgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          children: [
            Expanded(
              child: VkTextFormField(
                controller: widget.messageController,
                label: '',
                onChanged: (_) {
                  _debounce?.cancel();

                  if (!_isTyping) {
                    locator<SocketService>().startTyping(widget.chatId ?? "");
                    _isTyping = true;
                  }

                  _debounce = Timer(const Duration(seconds: 1), () {
                    _isTyping = false;
                    locator<SocketService>().stopTyping(widget.chatId ?? "");
                  });
                },
              ),
            ),
            SizedBox(width: 10.w),
            InkWell(
              borderRadius: BorderRadius.circular(25.r),
              onTap: () => context
                  .read<ChatDetailCubit>()
                  .sendMessage(
                    userId: widget.chatId ?? '',
                    content: widget.messageController.text,
                  )
                  .then((_) => widget.messageController.clear()),
              child: CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                radius: 25.r,
                child: SvgPicture.asset(
                  AppConstants.sendSvg,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  width: 24.w,
                  height: 24.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
