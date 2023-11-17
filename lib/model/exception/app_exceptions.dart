class AppException implements Exception {
  final String? message, prefix;

  AppException({required this.message, this.prefix});

  @override
  String toString() {
    return "$prefix -> $message";
  }
}

class AppTimeoutException extends AppException {
  AppTimeoutException({String? message = "İşlem zaman aşımına uğradı bağlantınızı kontrol edip tekrar deneyin"})
      : super(message: message);
}

class UnauthorisedException extends AppException {
  UnauthorisedException({String? message = "Oturum bulunamadı kullanıcı bilgilerinizi kontrol edin"}) : super(message: message);
}
