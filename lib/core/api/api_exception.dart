class ApiException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  ApiException({required this.message, this.stackTrace});

  @override
  String toString() => message;
}
