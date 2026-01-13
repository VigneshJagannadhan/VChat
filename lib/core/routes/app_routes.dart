import 'package:flutter/material.dart';
import 'package:vignesh_project_01/core/routes/app_args.dart';
import 'package:vignesh_project_01/features/auth/presentation/views/auth_view.dart';
import 'package:vignesh_project_01/features/auth/presentation/views/unknown_rouet_view.dart';
import 'package:vignesh_project_01/features/chat/presentation/views/chat_list_view.dart';
import 'package:vignesh_project_01/features/chat/presentation/views/chat_view.dart';
import 'package:vignesh_project_01/features/user/presentation/views/user_list_view.dart';
import 'package:vignesh_project_01/features/user/presentation/views/user_profile_view.dart';
import 'package:vignesh_project_01/shared/presentation/views/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    /// SPLASH SCREEN
    case SplashView.route:
      return MaterialPageRoute(builder: (context) => SplashView());

    /// AUTH SCREEN
    case AuthView.route:
      return MaterialPageRoute(builder: (context) => AuthView());

    /// CHAT LIST SCREEN / HOME SCREEN
    case ChatListView.route:
      return MaterialPageRoute(builder: (context) => ChatListView());

    /// CHAT DETAIL SCREEN
    case ChatView.route:
      final args = settings.arguments as ChatDetailViewArgs?;
      return MaterialPageRoute(
        builder: (context) => ChatView(chatId: args?.chatId),
      );

    /// USER PROFILE SCREEN
    case UserProfileView.route:
      return MaterialPageRoute(builder: (context) => UserProfileView());

    /// USER LIST SCREEN
    case UserListView.route:
      return MaterialPageRoute(builder: (context) => UserListView());

    /// DEFAULT UNKNOWN SCREEN
    default:
      return MaterialPageRoute(builder: (_) => const UnknownRouteView());
  }
}
