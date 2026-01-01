class AppException implements Exception {
  final String message;
  final int? code;
  final String? type;
  final Map<String, dynamic>? detail;

  AppException(this.message, {this.code, this.type, this.detail});

  @override
  String toString() {
    return message;
  }
}
