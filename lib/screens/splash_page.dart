import 'package:appwrite_oath/router/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    start();
  }

  void start() async {
    await ref.read(routeServiceProvider).onAppStart();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Placeholder(),
        ),
      ),
    );
  }
}
