import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:vignesh_project_01/core/constants/app_constants.dart';

class CustomLoaderWidget extends StatelessWidget {
  const CustomLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset(AppConstants.lottieLoading));
  }
}
