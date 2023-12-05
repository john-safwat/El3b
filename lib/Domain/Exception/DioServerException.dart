import 'package:dio/dio.dart';

class DioServerException implements Exception {
  DioExceptionType errorMessage ;
  DioServerException({required this.errorMessage});
}