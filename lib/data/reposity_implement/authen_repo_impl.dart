import 'package:currency_conventer/models/sign_in_req.dart';

import '../exception/device_not_active_exception.dart';
import '../remote/api/authen_api.dart';
import '../remote/http_handler.dart';
import '../remote/rest_api.dart';
import '../reposity/authen_reposity.dart';

/// AuthenRepoImpl
class AuthenRepoImpl extends AuthenRepo with HttpHandler {
  AuthenRepoImpl() {
    _create();
  }

  AuthenAPI _authenAPI;

  Future<void> _create() async {
    _authenAPI = await RestAPI.provideAuthenAPI();
  }

  @override
  void dispose() {
    _authenAPI?.dispose();
  }

  @override
  Future<bool> signIn(String email, String password) async {
    final signInReq = SignInReq((b) => b);
    try {
      final signInRes = await call(_authenAPI.signIn(signInReq));
      if (signInRes != null && signInRes.accessToken != null) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (err) {
      if (err is UnActiveDeviceException) {
        rethrow;
      } else {
        return false;
      }
    }
  }
}
