import 'package:core/Base/base_api_assets.dart';
import 'package:dio/dio.dart';

abstract class BaseAPIManager<A extends BaseAPIAssets> {
  A apiAssets;

  BaseAPIManager(this.apiAssets);

  Dio dio = Dio();
}
