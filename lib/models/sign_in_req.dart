import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sign_in_req.g.dart';

abstract class SignInReq implements Built<SignInReq, SignInReqBuilder> {
  factory SignInReq([void Function(SignInReqBuilder) updates]) = _$SignInReq;
  SignInReq._();

  static Serializer<SignInReq> get serializer => _$signInReqSerializer;
}
