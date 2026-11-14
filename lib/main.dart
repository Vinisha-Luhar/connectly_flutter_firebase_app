import 'package:connectly/app/router/app_router.dart';
import 'package:connectly/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const ProviderScope(
    child: ConnectlyApp(),
  ));
}

class ConnectlyApp extends ConsumerWidget {
  const ConnectlyApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Connectly',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
