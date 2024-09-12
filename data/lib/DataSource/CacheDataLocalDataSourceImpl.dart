import 'dart:convert';

import 'package:data/Cache/LocalCache.dart';
import 'package:data/Models/Games/FreeToPlayGame/FreeToPlayGameDTO.dart';
import 'package:data/Models/Games/GiveawayGame/GiveawayGameDTO.dart';
import 'package:data/Models/Games/RAWG/RAWGGameDTO.dart';
import 'package:data/Models/Genres/GenreDTO.dart';
import 'package:domain/DataSource/CacheDataLocalDataSource.dart';
import 'package:domain/Exception/CacheException.dart';
import 'package:domain/Models/Games/FreeToPlayGame/FreeToPlayGame.dart';
import 'package:domain/Models/Games/GiveawayGames/GiveawayGame.dart';
import 'package:domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:domain/Models/Genres/Genre.dart';


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

  @override
  Future<List<Genre>?> getGenresList() async{
    var response = await cache.loadData(key: "Genre");
    var games = jsonDecode(response!) as List<dynamic>;
    return games.map((e) => GenreDTO.fromJson(e).toDomain()).toList();
  }

}