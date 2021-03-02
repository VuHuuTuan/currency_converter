library order_create_req;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_create_req.g.dart';

abstract class OrderCreateReq
    implements Built<OrderCreateReq, OrderCreateReqBuilder> {
  factory OrderCreateReq([void Function(OrderCreateReqBuilder) updates]) =
      _$OrderCreateReq;
  OrderCreateReq._();

  static Serializer<OrderCreateReq> get serializer =>
      _$orderCreateReqSerializer;
}
