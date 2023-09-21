
import 'dart:convert';

import 'package:El3b/Core/Extension/DateOnlyExtinsion.dart';
import 'package:El3b/Data/DataSource/CacheDataLocalDataSourceImpl.dart';
import 'package:El3b/Data/DataSource/GiveawayGamesRemoteDataSourceImpl.dart';
import 'package:El3b/Domain/DataSource/CacheDataLocalDataSource.dart';
import 'package:El3b/Domain/DataSource/GiveawayGamesRemoteDataSource.dart';
import 'package:El3b/Domain/Models/Games/GiveawayGames/GiveawayGame.dart';
import 'package:El3b/Domain/Repository/GiveawayGamesRepository.dart';
import 'package:flutter/material.dart';

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