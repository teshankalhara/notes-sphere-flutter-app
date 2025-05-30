import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_sphere_flutter_app/screens/home_screen.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    debugLogDiagnostics: true,
    initialLocation: "/",
    routes: [
      //home screen
      GoRoute(
        name: "home",
        path: "/",
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
    ],
  );
}
