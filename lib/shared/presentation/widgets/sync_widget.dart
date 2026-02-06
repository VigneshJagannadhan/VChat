import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SyncWidget extends StatelessWidget {
  const SyncWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.grey.shade200,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Syncing...'),
          SizedBox(width: 10.w),
          const CupertinoActivityIndicator(),
        ],
      ),
    );
  }
}
