library authen_api;

import 'package:chopper/chopper.dart';
import 'package:currency_conventer/models/refresh_token_req.dart';
import 'package:currency_conventer/models/refresh_token_res.dart';
import 'package:currency_conventer/models/sign_in_req.dart';
import 'package:currency_conventer/models/sign_in_res.dart';

part 'authen_api.chopper.dart';

/// AuthenAPI - contains APIs can request without authorization
@ChopperApi(baseUrl: '/api/v1')
abstract class AuthenAPI extends ChopperService {
  static AuthenAPI create(ChopperClient client) => _$AuthenAPI(client);

  /// API signin
  @Post(path: '/login/token/obtain/app')
  Future<Response<SignInRes>> signIn(
    @Body() SignInReq req,
  );

  /// API refreshToken
  @Post(path: '/login/token/refresh')
  Future<Response<RefreshTokenRes>> refreshToken(
    @Body() RefreshTokenReq request,
  );
}
