import 'dart:convert';

import 'package:El3b/Data/Cache/LocalCache.dart';
import 'package:El3b/Data/Models/Games/FreeToPlayGame/FreeToPlayGameDTO.dart';
import 'package:El3b/Data/Models/Games/GiveawayGame/GiveawayGameDTO.dart';
import 'package:El3b/Data/Models/Games/RAWG/RAWGGameDTO.dart';
import 'package:El3b/Domain/DataSource/CacheDataLocalDataSource.dart';
import 'package:El3b/Domain/Exception/CacheException.dart';
import 'package:El3b/Domain/Models/Games/FreeToPlayGame/FreeToPlayGame.dart';
import 'package:El3b/Domain/Models/Games/GiveawayGames/GiveawayGame.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';


// dependency injection
CacheDataLocalDataSource injectCacheDataLocalDataSource(){
  return CacheDataLocalDataSourceImpl(cache: injectLocalCache());
}


class CacheDataLocalDataSourceImpl implements CacheDataLocalDataSource {

  LocalCache cache ;
  CacheDataLocalDataSourceImpl({required this.cache});

  @override
  Future<DateTime?> getLastUpdatedDate({required String key}) async{
    try {
      var response = await cache.lastUpdatedDate(key: key);
      return response;
    }catch (e){
      throw CacheException(errorMessage: "Error Loading Data From Cache");
    }
  }

  @override
  Future<void> cacheData({required String data, required String key}) async{
    try{
      await cache.cacheData(data: data, key: key);
    }catch (e){
      throw CacheException(errorMessage: "Error Adding Data To Cache");
    }
  }

  @override
  Future<List<GiveawayGame>?> getGiveawayGames() async{
    var response = await cache.loadData(key: "GiveawayGames");
    var games = jsonDecode(response!) as List<dynamic>;
    return games.map((e) => GiveawayGameDTO.fromJson(e).toDomain()).toList();
  }

  @override
  Future<List<FreeToPlayGame>?> getFreeToPlayGames() async{
    var response = await cache.loadData(key: "FreeToPlayGames");
    var games = jsonDecode(response!) as List<dynamic>;
    return games.map((e) => FreeToPlayGameDTO.fromJson(e).toDomain()).toList();
  }

  @override
  Future<List<RAWGGame>?> getGeneralGames() async{
    var response = await cache.loadData(key: "GeneralGames");
    var games = jsonDecode(response!) as List<dynamic>;
    return games.map((e) => RAWGGameDTO.fromJson(e).toDomain()).toList();

  }



}