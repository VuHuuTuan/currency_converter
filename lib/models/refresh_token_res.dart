library refresh_token_res;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// ignore: prefer_double_quotes
part 'refresh_token_res.g.dart';

/// RefreshTokenRes
abstract class RefreshTokenRes
    implements Built<RefreshTokenRes, RefreshTokenResBuilder> {
  /// Updates
  factory RefreshTokenRes([void Function(RefreshTokenResBuilder) updates]) =
      _$RefreshTokenRes;
  RefreshTokenRes._();

  /// New accessToken
  @nullable
  @BuiltValueField(wireName: 'access_token')
  String get accessToken;

  /// New refreshToken
  @nullable
  @BuiltValueField(wireName: 'refresh_token')
  String get refreshToken;

  /// New tokenType
  @nullable
  @BuiltValueField(wireName: 'token_type')
  String get tokenType;

  /// Serializer
  static Serializer<RefreshTokenRes> get serializer =>
      _$refreshTokenResSerializer;
}
