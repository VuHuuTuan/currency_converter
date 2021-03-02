library order;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order.g.dart';

abstract class Order implements Built<Order, OrderBuilder> {
  factory Order([void Function(OrderBuilder) updates]) = _$Order;
  Order._();

  static Serializer<Order> get serializer => _$orderSerializer;
}
