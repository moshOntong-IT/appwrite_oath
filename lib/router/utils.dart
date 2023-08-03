import 'package:appwrite_oath/router/service.dart';
import 'package:appwrite_oath/screens/home_page.dart';
import 'package:appwrite_oath/screens/login_page.dart';
import 'package:appwrite_oath/screens/splash_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum AppPage {
  splash(name: 'splash', path: '/splash', fullPath: '/splash'),
  onBoarding(name: 'onBoarding', path: '/onboarding', fullPath: '/onboarding'),
  home(name: 'home', path: '/home', fullPath: '/home'),
  login(name: 'login', path: '/login', fullPath: '/login'),
  register(name: 'register', path: '/register', fullPath: '/register');

  const AppPage({
    required this.path,
    required this.name,
    required this.fullPath,
  });

  final String path;
  final String fullPath;
  final String name;
}

final mainRouteProvider = Provider<List<GoRoute>>((ref) {
  final service = ref.read(routeServiceProvider);
  return [
    GoRoute(
        path: AppPage.splash.path,
        name: AppPage.splash.name,
        builder: (context, state) => const SplashPage()),
    GoRoute(
        path: AppPage.login.path,
        name: AppPage.login.name,
        builder: (context, state) => const LoginPage()),
    GoRoute(
        path: AppPage.home.path,
        name: AppPage.home.name,
        redirect: (context, state) {
          final isLogin = service.isLogin;
          if (!isLogin) return AppPage.login.path;
          return null;
        },
        builder: (context, state) => const HomePage()),
  ];
});
