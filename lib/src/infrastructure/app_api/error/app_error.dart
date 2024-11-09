import 'package:dio/dio.dart';

enum AppErrorType {
  network,
  badRequest,
  unauthorized,
  forbidden,
  cancel,
  timeout,
  server,
  unknown,
}

class AppError {
  final String message;
  final AppErrorType type;
  const AppError({required this.message, required this.type});
  factory AppError.fromException(Exception error) {
    String message;
    AppErrorType type;
    if (error is DioError) {
      message = error.message!;
      switch (error.type) {
        case DioErrorType.receiveTimeout:
          type = AppErrorType.timeout;
          break;
        case DioErrorType.sendTimeout:
          type = AppErrorType.network;
          break;
        case DioErrorType.cancel:
          type = AppErrorType.cancel;
          break;
        default:
          type = AppErrorType.unknown;
          break;
      }
    } else {
      type = AppErrorType.unknown;
      message = 'AppError: $error';
    }
    return AppError(type: type, message: message);
  }
}
