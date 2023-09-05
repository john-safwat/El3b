import 'package:El3b/Data/Api/GiveawayGamesApi/GiveawayGamesApiAssets.dart';
import 'package:El3b/Data/Models/Games/GiveawayGames/GiveawayGamesDTO.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

// dependency injection
GiveawayGamesApi injectGiveawayGamesApi(){
  return GiveawayGamesApi.getInstance(apiAssets: injectGiveawayGamesApiAssets());
}


class GiveawayGamesApi {

  // singleton object
  GiveawayGamesApiAssets apiAssets;
  GiveawayGamesApi._({required this.apiAssets});

  static GiveawayGamesApi? _instance;
  static GiveawayGamesApi getInstance({required GiveawayGamesApiAssets apiAssets}){
    return _instance??= GiveawayGamesApi._(apiAssets: apiAssets);
  }

  final _dio = Dio();

  // function to load giveaway game from api
  Future<List<GiveawayGamesDTO>?> getAllGames() async{
    Uri uri = Uri.https(apiAssets.basUrl, apiAssets.giveawayRoute,);
    var response = await _dio.get<List<dynamic>>(uri.toString());
    return response.data!.map((e) => GiveawayGamesDTO.fromJson(e)).toList();
  }


}


