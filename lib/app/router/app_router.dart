
import 'package:connectly/features/authentication/presentation/screens/login_screen.dart';
import 'package:connectly/features/authentication/presentation/screens/register_screen.dart';
import 'package:connectly/features/conversations/presentation/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref){
  final router = GoRouter(
      initialLocation: "/login",
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
            name: "home",
            path: '/',
            builder: (context,state){
              return const HomeScreen();
            }
        ),
        GoRoute(
            name: "login",
            path: '/login',
            builder: (context,state){
              return const LoginScreen();
            }
        ),
        GoRoute(
            name: "register",
            path: '/register',
            builder: (context,state){
              return const RegisterScreen();
            }
        ),
      ]
  );

  ref.onDispose(router.dispose);
  return router;
});