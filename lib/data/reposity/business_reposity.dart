import 'package:currency_conventer/models/order.dart';

/// BusinessRepo
abstract class BusinessRepo {
  void dispose();

  /// data for order create
  Future<Order> orderCreate();
}
