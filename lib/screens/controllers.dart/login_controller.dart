import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite_oath/appwrite_helper.dart';
import 'package:appwrite_oath/router/service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginControllerProvider =
    AutoDisposeAsyncNotifierProvider(LoginController.new);

class LoginController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() async {}

  Future<void> googleLogin() async {
    state = const AsyncLoading();
    final account = AppwriteClientHelper.instance.account;

    try {
      await account.createOAuth2Session(
        provider: 'google',
      );
      ref.read(routeServiceProvider).login = true;
      state = const AsyncData(null);
    } on AppwriteException catch (e, stackTrace) {
      print(e.message);

      state = AsyncError(e.toString(), stackTrace);
    }
  }
}
