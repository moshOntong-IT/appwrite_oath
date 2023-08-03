import 'package:appwrite_oath/appwrite_helper.dart';
import 'package:appwrite_oath/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppwriteClientHelper.ensureInitialized('6439771429cdfb6a0b2b');
  runApp(const ProviderScope(
    child: MainApp(),
  ));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.read(appRouterProvider);
    return MaterialApp.router(
      routerConfig: goRouter.goRouter,
    );
  }
}
