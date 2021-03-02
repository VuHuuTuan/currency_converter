import 'dart:async';

import 'package:chopper/chopper.dart';
import '../shared_preferences_manager.dart';
import 'api/authen_api.dart';
import 'api/business_api.dart';
import 'built_value_converter.dart';

// ignore: avoid_classes_with_only_static_members
/// RestAPI class
class RestAPI {
  /// root_url of production enviroment
  static const String PRO_URL = 'abc.com';

  /// root_url of develope enviroment
  static const String DEV_URL = 'localhost:8080';

  /// get current enviroment root_url
  static String rootURL() => isInDevMode ? DEV_URL : PRO_URL;

  /// Create a client with no `Authorization` for service/API without need to be singin.
  static Future<AuthenAPI> provideAuthenAPI() async =>
      AuthenAPI.create(await _createClient(signedIn: false));

  /// Create a client with `Authorization` for service/API need to be singin.
  static Future<BusinessAPI> provideBusinessAPI() async =>
      BusinessAPI.create(await _createClient());

  static Future<ChopperClient> _createClient({bool signedIn = true}) async =>
      ChopperClient(
        baseUrl: isInDevMode ? DEV_URL : PRO_URL,
        services: <ChopperService>[],
        interceptors: <dynamic>[
          if (signedIn) SignedInInterceptor() else PreSignInInterceptor(),
          HttpLoggingInterceptor(),
        ],
        converter: BuiltValueConverter(),
      );

  /// getter will return a bool value ill check this app is running
  /// in dev mode or not
  static bool get isInDevMode {
    bool inDevMode;
    assert(inDevMode = true, 'Development mode');
    return inDevMode ?? false;
  }
}

/// A Interceptor without `Authorization` in header
class PreSignInInterceptor implements RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) async {
    final s = await SharedPreferencesManager.instance();
    final headers = <String, String>{
      'AppId': '',
      'Signature': '',
      'Content-Type': 'application/json'
    };
    return request.copyWith(headers: headers);
  }
}

/// A Interceptor with `Authorization` in header
class SignedInInterceptor implements RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) async {
    final s = await SharedPreferencesManager.instance();
    final headers = <String, String>{
      'AppId': '',
      'Authorization': 'Bearer ${s.accessToken}',
      'Signature': '',
      'Content-Type': 'application/json'
    };
    return request.copyWith(headers: headers);
  }
}
