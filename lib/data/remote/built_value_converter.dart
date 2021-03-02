import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:chopper/chopper.dart';
import 'serializers.dart';

//ignore_for_file: always_specify_types, avoid_as

/// BuiltValueConverter
class BuiltValueConverter extends JsonConverter {
  @override
  Request convertRequest(Request request) {
    if (request.body is List<int> || request.body is List<String>) {
      return super.convertRequest(request);
    }

    if (request.multipart) {
      return super.convertRequest(request);
    }

    if (request.body is Map) {
      return super.convertRequest(request);
    }

    return super.convertRequest(
      request.copyWith(
        body: serializers.serializeWith(
          serializers.serializerForType(request.body.runtimeType as Type),
          request.body,
        ),
      ),
    );
  }

  @override
  Response<BodyType> convertResponse<BodyType, SingleItemType>(
      Response response) {
    final dynamicResponse = super.convertResponse(response);
    final customBody =
        _convertToCustomerObject<SingleItemType>(dynamicResponse.body)
            as BodyType;
    return dynamicResponse.copyWith<BodyType>(body: customBody);
  }

  dynamic _convertToCustomerObject<SingleItemType>(element) {
    if (element is SingleItemType) {
      return element;
    }
    if (element is List) {
      return _deserializeListOf<SingleItemType>(element);
    } else {
      return _deserialize<SingleItemType>(element as Map<String, dynamic>);
    }
  }

  BuiltList<SingleItemType> _deserializeListOf<SingleItemType>(
          List dynamicList) =>
      BuiltList<SingleItemType>(
        dynamicList.map(
            (e) => _deserialize<SingleItemType>(e as Map<String, dynamic>)),
      );

  SingleItemType _deserialize<SingleItemType>(Map<String, dynamic> value) =>
      serializers.deserializeWith(
          serializers.serializerForType(SingleItemType)
              as Serializer<SingleItemType>,
          value);
}
