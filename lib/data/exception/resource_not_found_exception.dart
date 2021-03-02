/// ResourceNotFoundException
class ResourceNotFoundException implements Exception {
  /// constructor
  const ResourceNotFoundException(this.message);

  /// http result code
  static const int code = 404;

  /// message
  final String message;

  @override
  String toString() => 'ResourceNotFoundException: $message';
}
