import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routeServiceProvider =
    ChangeNotifierProvider<RouteService>((ref) => RouteService(ref));

class RouteService extends ChangeNotifier {
  RouteService(this.ref);

  final Ref ref;

  bool _isLogin = false;
  bool _isInitialized = false;

  bool get isLogin => _isLogin;
  bool get isInitialized => _isInitialized;

  set login(bool isLogin) {
    _isLogin = isLogin;
    // TODO create a method to check if authenticated
    notifyListeners();
  }

  set initialized(bool isInitialized) {
    _isInitialized = isInitialized;
    notifyListeners();
  }

  Future<void> onAppStart() async {
    await Future.delayed(const Duration(seconds: 2));

    await getLoginStatus();
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> getLoginStatus() async {
    // TODO create a method to check if authenticated
    _isLogin = false;
  }
}
