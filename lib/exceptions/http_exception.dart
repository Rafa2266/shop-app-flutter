class HttpExceptionFire implements Exception {
  final String msg;
  final int statusCode;

  HttpExceptionFire({required this.msg, required this.statusCode});

  @override
  String toString() {
    return msg;
  }
}
