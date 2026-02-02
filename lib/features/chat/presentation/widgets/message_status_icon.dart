import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vignesh_project_01/core/utils/enums.dart';

class MessageStatusIcon extends StatelessWidget {
  const MessageStatusIcon({super.key, required this.status});

  final MessageStatus status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case MessageStatus.pending:
        return Icon(
          Icons.access_time_rounded,
          size: 10.sp,
          color: Colors.white70,
        );
      case MessageStatus.failed:
        return Icon(Icons.error_outline, size: 10.sp, color: Colors.red);
      case MessageStatus.success:
        return Icon(Icons.check_circle, size: 10.sp, color: Colors.white);
    }
  }
}
