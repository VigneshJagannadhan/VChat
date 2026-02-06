import 'package:flutter/material.dart';

class UnknownRouteView extends StatelessWidget {
  static const String route = '/unknown_route_view';
  const UnknownRouteView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Unknown Route')));
  }
}
