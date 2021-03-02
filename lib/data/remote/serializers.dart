library serializers;

import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:currency_conventer/models/order.dart';
import 'package:currency_conventer/models/order_create_req.dart';
import 'package:currency_conventer/models/refresh_token_req.dart';
import 'package:currency_conventer/models/refresh_token_res.dart';
import 'package:currency_conventer/models/sign_in_req.dart';
import 'package:currency_conventer/models/sign_in_res.dart';

part 'serializers.g.dart';

@SerializersFor([
  SignInReq,
  SignInRes,
  Order,
  OrderCreateReq,
  RefreshTokenReq,
  RefreshTokenRes,
])

/// serializers
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
