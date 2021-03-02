import 'package:currency_conventer/models/order.dart';
import 'package:currency_conventer/route_names.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';

import '../exception/token_expired_exeption.dart';
import '../reposity/business_reposity.dart';
import '../reposity_implement/business_repo_impl.dart';
import '../shared_preferences_manager.dart';

typedef FutureCaller<T> = Future<T> Function();

/// Business service
class BusinessService {
  BusinessService(this._navigatorKey, [BusinessRepoImpl _repo]) {
    _businessRepo = _repo ?? BusinessRepoImpl();
  }

  final GlobalKey<NavigatorState> _navigatorKey;

  BusinessRepo _businessRepo;

  /// A function to catch the second `TokenExpiredException`. The first one
  /// exception was catched in [..._repo_impl], it call refresh token API to
  /// get new accessToken and refreshToken.
  ///
  /// This exception was throw when `accessToken` and `refreshToken`
  /// are bolth expired. So we need to resignin.
  ///
  /// When exception was throw, catch it and navigate the application
  /// to the login screen, clear out all stored user data.
  Future<T> tokenExpiredCatcher<T>({@required FutureCaller<T> caller}) async {
    try {
      return await caller();
    } on TokenExpiredException {
      final s = await SharedPreferencesManager.instance();
      s
        ..accessToken = null
        ..refreshToken = null;
      unawaited(_navigatorKey?.currentState?.pushNamedAndRemoveUntil(
        RouteNamesCofig.signInpage,
        (route) => false,
        arguments: <String, dynamic>{
          'notifi': true,
          'notifi_content': 'Your login session is expired!',
        },
      ));
      return null;
    }
  }

  /// dispose
  void dispose() {
    _businessRepo?.dispose();
  }

  /// create a order
  Future<Order> orderCreate() {
    return tokenExpiredCatcher(caller: () => _businessRepo.orderCreate());
  }
}
