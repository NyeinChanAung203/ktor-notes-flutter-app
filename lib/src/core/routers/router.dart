import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_template/src/core/routers/routes.dart';
import 'package:my_template/src/features/auth/presentation/sign_in_screen.dart';
import 'package:my_template/src/features/auth/presentation/sign_up_screen.dart';

import '../ui/widgets/error_screen_widget.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

abstract final class AppRouter {
  static GoRouter router = router;
}

final router = GoRouter(
  requestFocus: false,
  debugLogDiagnostics: kDebugMode,
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.signIn.path,
  errorBuilder: (context, state) => const ErrorScreen(),
  routes: [
    GoRoute(
      path: Routes.signIn.path,
      name: Routes.signIn.name,
      builder: (context, state) {
        return SignInScreen();
      },
    ),
    GoRoute(
      path: Routes.signUp.path,
      name: Routes.signUp.name,
      builder: (context, state) {
        return SignUpScreen();
      },
    )
  ],
  // redirect: (context, state) {
  //   print("path => ${state.fullPath}");
  //   const isAuthenticated = false;
  //   if (!isAuthenticated) {
  //     if (state.fullPath == Routes.wallet.path) {
  //       return Routes.login.path;
  //     }
  //   }
  //   return null;
  // },
);
