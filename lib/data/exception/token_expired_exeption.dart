/// A exeption was fire when token is expired(API result code 401)
class TokenExpiredException implements Exception {
  /// constructor
  // ignore: avoid_positional_boolean_parameters
  const TokenExpiredException([this.message, this.refreshTokenExpired = false]);

  /// http result code
  static const int code = 401;

  /// error message
  final String message;

  /// check when `refreshToken` is expired too. you need to navigate
  /// app to login page.
  final bool refreshTokenExpired;

  @override
  String toString() => 'TokenExpiredException: $message';
}
