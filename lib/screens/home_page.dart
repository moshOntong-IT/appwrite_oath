import 'package:appwrite_oath/appwrite_helper.dart';
import 'package:appwrite_oath/router/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              final account = AppwriteClientHelper.instance.account;
              await account.deleteSession(sessionId: 'current');
              ref.read(routeServiceProvider).login = false;
            },
            child: const Text('Logout')),
      ),
    );
  }
}
