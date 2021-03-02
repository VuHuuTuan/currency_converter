/// UnActiveDeviceException
class UnActiveDeviceException implements Exception {
  /// constructor
  const UnActiveDeviceException(this.message);

  /// http status code
  static const int code = 277;

  /// message
  final String message;

  @override
  String toString() => 'UnActiveDeviceException: $message';
}
