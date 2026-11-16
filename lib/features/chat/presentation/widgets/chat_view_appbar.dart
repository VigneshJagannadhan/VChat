import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vignesh_project_01/core/extensions/theme_extensions.dart';

class ChatViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatViewAppBar({super.key, required this.name, required this.lastSeen});

  final String name;
  final String lastSeen;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          CircleAvatar(radius: 20.r, child: const Icon(Icons.person)),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: .start,
            children: [
              Text(name, style: context.textTheme.titleMedium),
              Text(lastSeen, style: context.textTheme.labelSmall),
            ],
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size(1.sw, kToolbarHeight.h);
}
