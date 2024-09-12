import 'package:core/Base/BaseAPIAssets.dart';
import 'package:dio/dio.dart';

abstract class BaseAPIManager<A extends BaseAPIAssets> {
  A apiAssets;

  BaseAPIManager(this.apiAssets);

  Dio dio = Dio();
}
