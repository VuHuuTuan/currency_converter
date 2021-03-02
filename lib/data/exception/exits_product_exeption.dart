/// A exeption was fire when token is expired(API result code 401)
class ExitsProductException implements Exception {
  /// constructor
  const ExitsProductException([this.message]);

  /// http result code
  static const int code = 409;

  /// error message
  final String message;

  @override
  String toString() => 'ExitsProductException: $message';
}
