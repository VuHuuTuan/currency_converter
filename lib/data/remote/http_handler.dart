import 'dart:convert';

import 'package:chopper/chopper.dart';

import '../exception/device_not_active_exception.dart';
import '../exception/exits_product_exeption.dart';
import '../exception/resource_not_found_exception.dart';
import '../exception/token_expired_exeption.dart';
import '../exception/validation_exception.dart';

/// Time to timeout a request (in seconds)
const int timeout = 120;

/// HttpHandler
mixin HttpHandler {
  /// a success http result code
  static const int OK = 200;

  /// a error http result code
  static const int UNAUTHORIZED = 401;

  /// activation processing
  static const int ACTIVATION_PROCESSING = 277;

  /// a fail http result code
  static const int FAIL = 422;

  /// a server error http result code
  static const int SERVER_ERROR = 500;

  /// NON_VERIFY_ACCOUNT
  static const int NON_VERIFY_ACCOUNT = 403;

  /// The resource was not found
  static const int RESOUCE_NOT_FOUND = 404;

  /// call
  Future<T> call<T>(Future<Response<T>> requestFuture) async {
    final res = await requestFuture.timeout(
      const Duration(seconds: timeout),
      onTimeout: () {
        throw Exception('Something went wrong, please try again later');
      },
    );
    return _handleResponse(res);
  }

  T _handleResponse<T>(Response<T> res) {
    if (res.statusCode != OK) {
      String errorMessage;
      if (res.error != null) {
        try {
          errorMessage =
              json.decode(res.error.toString())['messageError'] as String;
          errorMessage ??=
              json.decode(res.error.toString())['message'] as String;
        } catch (_) {
          // throw ManuallyException(
          //   errorMessage ?? 'Something went wrong, please try again later');
        }
      }
      if (res.statusCode == UnActiveDeviceException.code) {
        throw const UnActiveDeviceException(
            'This device is waiting for activating, please check your mail');
      }
      if (res.statusCode == ValidationException.code) {
        throw ValidationException(res.bodyString);
      }
      if (res.statusCode == TokenExpiredException.code) {
        throw TokenExpiredException(res.bodyString);
      }
      if (res.statusCode == ResourceNotFoundException.code) {
        throw ResourceNotFoundException(res.bodyString);
      }
      if (res.statusCode == ExitsProductException.code) {
        throw ExitsProductException(res.bodyString);
      }
      throw Exception(
          errorMessage ?? 'Something went wrong, please try again later');
    }
    if (res.headers['x-page'] != null &&
        res.headers['x-per-page'] != null &&
        res.headers['x-total-amount'] != null) {
      if (int.parse(res.headers['x-total-amount']) +
              int.parse(res.headers['x-per-page']) <=
          int.parse(res.headers['x-page']) *
              int.parse(res.headers['x-per-page'])) {
        throw Exception('No more data');
      }
    }
    return res.body;
  }
}
