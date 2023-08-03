import 'package:appwrite_oath/router/service.dart';
import 'package:appwrite_oath/router/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<AppRouter>(
  (ref) => AppRouter(
    ref,
    service: ref.read(routeServiceProvider),
  ),
);

class AppRouter {
  AppRouter(this.ref, {required this.service});
  final Ref ref;
  final RouteService service;

  late final GoRouter router = GoRouter(
    routes: ref.read(mainRouteProvider),
    initialLocation: AppPage.home.path,
    refreshListenable: service,
    redirect: (context, state) {
      final splashLocation = state.namedLocation(AppPage.splash.name);
      final homeLocation = state.namedLocation(AppPage.home.name);
      final loginLocation = state.namedLocation(AppPage.login.name);

      final isLogin = service.isLogin;
      final isInitialized = service.isInitialized;

      final isGoingToSplash = state.matchedLocation == splashLocation;

      final isGoingToLogin = state.matchedLocation == loginLocation;

      if (!isInitialized && !isGoingToSplash) {
        return splashLocation;
      } else if (isInitialized && !isLogin && !isGoingToLogin) {
        return loginLocation;
      } else if ((isLogin && isGoingToLogin) ||
          (isInitialized && isGoingToSplash)) {
        return homeLocation;
      }
      return null;
    },
  );

  GoRouter get goRouter => router;
}
