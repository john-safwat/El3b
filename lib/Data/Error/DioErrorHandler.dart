import 'package:dio/dio.dart';

// dependency injection
DioErrorHandler injectDioErrorHandler(){
  return DioErrorHandler.getInstance();
}

class DioErrorHandler {

  // singleton object
  DioErrorHandler._();
  static DioErrorHandler? _instance;
  static DioErrorHandler getInstance(){
    return _instance??= DioErrorHandler._();
  }

  // function to handle dio exceptions
  String dioExceptionHandler (DioExceptionType type){
    switch (type) {
      case DioExceptionType.connectionTimeout:
        return 'connection timeout';
      case DioExceptionType.sendTimeout:
        return 'send timeout';
      case DioExceptionType.receiveTimeout:
        return 'receive timeout';
      case DioExceptionType.badCertificate:
        return 'bad certificate';
      case DioExceptionType.badResponse:
        return 'bad response';
      case DioExceptionType.cancel:
        return 'request cancelled';
      case DioExceptionType.connectionError:
        return 'connection error';
      case DioExceptionType.unknown:
        return 'unknown';
    }
  }

}