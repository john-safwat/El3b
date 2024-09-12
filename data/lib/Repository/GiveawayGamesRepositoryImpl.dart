
import 'dart:convert';

import 'package:core/Extension/DateOnlyExtinsion.dart';
import 'package:data/DataSource/CacheDataLocalDataSourceImpl.dart';
import 'package:data/DataSource/GiveawayGamesRemoteDataSourceImpl.dart';
import 'package:domain/DataSource/CacheDataLocalDataSource.dart';
import 'package:domain/DataSource/GiveawayGamesRemoteDataSource.dart';
import 'package:domain/Models/Games/GiveawayGames/GiveawayGame.dart';
import 'package:domain/Repository/GiveawayGamesRepository.dart';
// dependency injection
GiveawayGamesRepository injectGiveawayGamesRepository(){
  return GiveawayGamesRepositoryImpl(
    remoteDataSource: injectGiveawayGamesRemoteDataSource(),
    localDataSource: injectCacheDataLocalDataSource()
  );
}

// the object
class GiveawayGamesRepositoryImpl implements GiveawayGamesRepository {

  GiveawayGamesRemoteDataSource remoteDataSource ;
  CacheDataLocalDataSource localDataSource;
  GiveawayGamesRepositoryImpl({required this.remoteDataSource , required this.localDataSource});

  // function to load giveaway game from api throw data source
  // in this function it call the cache to check for the last time data cached
  // it the cache is outDated or has not stored is call the api
  @override
  Future<List<GiveawayGame>?> getAllGames() async{
    // get last update time for the data in cache
    var lastUpdate =  await localDataSource.getLastUpdatedDate(key: "GiveawayGames");
    // if user first time open the app this value will be null
    if(lastUpdate != null ){
      // if the data is valid is return the data from the cache else it call the api
      if(!lastUpdate.isBefore(DateTime.now().dateOnly(DateTime.now()))){
        var response = await localDataSource.getGiveawayGames();
        return response;
      }else {
        var response = await remoteDataSource.getAllGames();
        var data = jsonEncode(response!.map((e) => e.toData().toJson()).toList());
        await localDataSource.cacheData(data: data, key: "GiveawayGames");
        return response;
      }
    }else {
      var response = await remoteDataSource.getAllGames();
      var data = jsonEncode(response!.map((e) => e.toData().toJson()).toList());
      await localDataSource.cacheData(data: data, key: "GiveawayGames");
      return response;
    }
  }

  // function to load data from server on refresh
  @override
  Future<List<GiveawayGame>?> getDataFromServer() async{
    var response = await remoteDataSource.getAllGames();
    var data = jsonEncode(response!.map((e) => e.toData().toJson()).toList());
    await localDataSource.cacheData(data: data, key: "GiveawayGames");
    return response;
  }


}