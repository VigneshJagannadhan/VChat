import 'package:flutter/cupertino.dart';

class CustomLoaderWidget extends StatelessWidget {
  const CustomLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(child: Center(child: CupertinoActivityIndicator()));
  }
}
