import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:vignesh_project_01/core/di/locator.dart';
import 'package:vignesh_project_01/core/services/socket_service.dart';

class AppLifecycleHelper with WidgetsBindingObserver {
  AppLifecycleHelper();

  void start() {
    log("AppLifecycleHelper: Started observing lifecycle changes");
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    log("AppLifecycleHelper: Stopped observing lifecycle changes");
    WidgetsBinding.instance.removeObserver(this);
    locator<SocketService>().disconnect();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      log("AppLifecycleHelper: App resumed, connecting to socket");
      locator<SocketService>().connect();
      log("AppLifecycleHelper: Socket connected on app resume");
    }

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      log("AppLifecycleHelper: App paused/inactive, disconnecting from socket");
      locator<SocketService>().disconnect();
      log("AppLifecycleHelper: Socket disconnected on app pause/inactive");
    }
  }
}
