library business_api;

import 'package:chopper/chopper.dart';
import 'package:currency_conventer/models/order.dart';
import 'package:currency_conventer/models/order_create_req.dart';

part 'business_api.chopper.dart';

/// BusinessAPI - contains APIs need authorization to get response
@ChopperApi(baseUrl: '/api/v1/')
abstract class BusinessAPI extends ChopperService {
  static BusinessAPI create(ChopperClient client) => _$BusinessAPI(client);

  /// create new order
  @Post(path: 'order/create')
  Future<Response<Order>> orderCreate(
    @Body() OrderCreateReq request,
  );
}
