import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vignesh_project_01/core/constants/app_constants.dart';
import 'package:vignesh_project_01/core/themes/app_styles.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_detail/chat_detail_cubit.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_detail/chat_detail_states.dart';
import 'package:vignesh_project_01/features/chat/presentation/widgets/message_bubble.dart';

class ChatViewMessageBody extends StatelessWidget {
  const ChatViewMessageBody({super.key});

  @override
  Widget build(BuildContext context) {
    log('Listening to cubit: ${context.read<ChatDetailCubit>().hashCode}');
    return BlocConsumer<ChatDetailCubit, ChatDetailState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ChatDetailFailure) {
          return Center(
            child: Column(
              mainAxisSize: .min,
              children: [
                SvgPicture.asset(
                  width: 50.r,
                  height: 50.r,
                  AppConstants.errorSvg,
                  colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
                ),
                SizedBox(height: 20.h),
                Text(state.failure.message, style: AppStyles.ts16W400cBlack),
              ],
            ),
          );
        }

        if (state is ChatDetailLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }

        if (state is ChatDetailLoaded) {
          return state.messages.isEmpty
              ? Center(
                  child: Text(
                    'Send a message to start the conversation',
                    style: AppStyles.ts16W400cBlack,
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        reverse: true,
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          var message = state.messages[index];
                          return MessageBubble(message: message);
                        },
                      ),
                    ),
                    if (state.isTyping)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 20.w),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: Colors.grey[300],
                          ),
                          child: Text(
                            'Typing...',
                            style: AppStyles.ts10W400cBlack,
                          ),
                        ),
                      ),
                  ],
                );
        }

        return Center(child: Text("Send a message to get started!"));
      },
    );
  }
}
