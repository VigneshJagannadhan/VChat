import 'package:flutter/material.dart';
import 'package:vignesh_project_01/core/helpers/navigation_helper.dart';
import 'package:vignesh_project_01/core/themes/app_colors.dart';
import 'package:vignesh_project_01/features/user/presentation/views/user_list_view.dart';

class SendNewMessageButton extends StatelessWidget {
  const SendNewMessageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.primaryColor,

      onPressed: () => NavigationHelper.pushNamed(
        context: context,
        route: UserListView.route,
      ),
      child: Icon(Icons.add, color: Colors.white),
    );
  }
}
