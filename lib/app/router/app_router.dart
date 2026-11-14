
import 'package:connectly/features/conversations/presentation/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref){
  final router = GoRouter(
      initialLocation: "/",
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
            name: "home",
            path: '/',
            builder: (context,state){
              return const HomeScreen();
            }
        ),
      ]
  );

  ref.onDispose(router.dispose);
  return router;
});