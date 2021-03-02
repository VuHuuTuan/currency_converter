import 'package:chopper/chopper.dart';
import 'package:currency_conventer/models/order.dart';
import 'package:currency_conventer/models/order_create_req.dart';
import 'package:currency_conventer/models/refresh_token_req.dart';

import '../exception/token_expired_exeption.dart';
import '../remote/api/authen_api.dart';
import '../remote/api/business_api.dart';
import '../remote/http_handler.dart';
import '../remote/rest_api.dart';
import '../reposity/business_reposity.dart';
import '../shared_preferences_manager.dart';

/// Business repository implementatation
class BusinessRepoImpl extends BusinessRepo with HttpHandler {
  BusinessRepoImpl() {
    _create();
  }

  BusinessAPI _businessAPI;
  AuthenAPI _authenAPI;

  Future<void> _create() async {
    _businessAPI = await RestAPI.provideBusinessAPI();
    _authenAPI = await RestAPI.provideAuthenAPI();
  }

  @override
  void dispose() {
    _businessAPI?.dispose();
    _authenAPI?.dispose();
  }

  /// Function was call refresh token when it expired.
  /// - using refresh_token to get new access_token and new refresh_token.
  /// - access_token expired after 2 minute and refresh_token is 30 days.
  /// - when refresh_token expired -> need to re signIn.
  ///
  /// * Call this function instead 'call'.
  Future<T> safeCall<T>(Future<Response<T>> Function() requestFuture) async {
    try {
      return await call<T>(requestFuture());
    } on TokenExpiredException {
      // print('Access token is expired!, trying to refreshing token...');
      final s = await SharedPreferencesManager.instance();
      final request = RefreshTokenReq((b) => b..token = s.refreshToken);
      try {
        // Call refresh token API and saving them.
        final response = await call(_authenAPI.refreshToken(request));
        s
          ..refreshToken = response.refreshToken
          ..accessToken = response.accessToken;

        // ReCreate business client (Interceptor)
        _businessAPI.client.httpClient.close();
        _businessAPI = await RestAPI.provideBusinessAPI();

        // ReCall your API
        return call(requestFuture());
      } on TokenExpiredException {
        throw const TokenExpiredException(
          'Your login session is expired, please reLogin!',
          true,
        );
      }
    }
  }

  @override
  Future<Order> orderCreate() {
    return safeCall(() => _businessAPI.orderCreate(OrderCreateReq((b) => b)));
  }
}
