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
  String dioExceptionHandlerEnglish (DioExceptionType type){
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
    }}


    // function to handle dio exceptions
    String dioExceptionHandlerArabic (DioExceptionType type){
      switch (type) {
        case DioExceptionType.connectionTimeout:
          return 'انتهى وقت محاولة الاتصال';
        case DioExceptionType.sendTimeout:
          return 'انتهى وقت محاولة الإرسال';
        case DioExceptionType.receiveTimeout:
          return 'انتهى وقت محاولة الاستلام';
        case DioExceptionType.badCertificate:
          return 'شهادة الاتصال بها خطاء ما';
        case DioExceptionType.badResponse:
          return 'خطاء في الرد';
        case DioExceptionType.cancel:
          return 'تم الغاء الاتصال';
        case DioExceptionType.connectionError:
          return 'خطاء في الاتصال';
        case DioExceptionType.unknown:
          return 'خطاء غير معروف';
      }
    }

}