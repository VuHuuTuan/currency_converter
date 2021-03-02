/// ValidationException
class ValidationException implements Exception {
  /// constructor
  const ValidationException([this.message, this.type]);

  /// http result code
  static const int code = 422;

  /// message
  final String message, type;

  @override
  String toString() => 'ValidationException: $message';
}
