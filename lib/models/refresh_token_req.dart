library refresh_token_req;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// ignore: prefer_double_quotes
part 'refresh_token_req.g.dart';

/// RefreshTokenReq
abstract class RefreshTokenReq
    implements Built<RefreshTokenReq, RefreshTokenReqBuilder> {
  /// Updates
  factory RefreshTokenReq([void Function(RefreshTokenReqBuilder) updates]) =
      _$RefreshTokenReq;
  RefreshTokenReq._();

  /// Refresh token from API obtain/app
  @nullable
  @BuiltValueField(wireName: 'token')
  String get token;

  /// Serializer
  static Serializer<RefreshTokenReq> get serializer =>
      _$refreshTokenReqSerializer;
}
