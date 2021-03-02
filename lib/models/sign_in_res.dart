import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sign_in_res.g.dart';

abstract class SignInRes implements Built<SignInRes, SignInResBuilder> {
  factory SignInRes([void Function(SignInResBuilder) updates]) = _$SignInRes;
  SignInRes._();

  /// accessToken
  @nullable
  @BuiltValueField(wireName: 'access_token')
  String get accessToken;

  /// refreshToken
  @nullable
  @BuiltValueField(wireName: 'refresh_token')
  String get refreshToken;

  /// tokenType
  @nullable
  @BuiltValueField(wireName: 'token_type')
  String get tokenType;

  static Serializer<SignInRes> get serializer => _$signInResSerializer;
}
