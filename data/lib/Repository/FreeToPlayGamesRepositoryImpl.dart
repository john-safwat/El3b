import 'dart:convert';
import 'package:core/Extension/DateOnlyExtinsion.dart';
import 'package:data/DataSource/CacheDataLocalDataSourceImpl.dart';
import 'package:data/DataSource/FreeToPlayGamesRemoteDataSourceImpl.dart';
import 'package:domain/DataSource/CacheDataLocalDataSource.dart';
import 'package:domain/DataSource/FreeToPlayGamesRemoteDataSource.dart';
import 'package:domain/Models/Games/FreeToPlayGame/FreeToPlayGame.dart';
import 'package:domain/Repository/FreeToPlayGamesRepository.dart';


// dependency injection
FreeToPlayGamesRepository injectFreeToPlayGamesRepository(){
  return FreeToPlayGamesRepositoryImpl(
    remoteDataSource: injectFreeToPlayGamesRemoteDataSource(),
      localDataSource: injectCacheDataLocalDataSource()
  );
}

class FreeToPlayGamesRepositoryImpl implements FreeToPlayGamesRepository {

  FreeToPlayGamesRemoteDataSource remoteDataSource;
  CacheDataLocalDataSource localDataSource;
  FreeToPlayGamesRepositoryImpl({required this.remoteDataSource , required this.localDataSource});

  // function to load free to play game from api throw data source
  // in this function it call the cache to check for the last time data cached
  // it the cache is outDated or has not stored is call the api
  @override
  Future<List<FreeToPlayGame>?> getGames() async{
    // get last update time for the data in cache
    var lastUpdate =  await localDataSource.getLastUpdatedDate(key: "FreeToPlayGames");
    // if user first time open the app this value will be null
    if(lastUpdate != null ){
      // if the data is valid is return the data from the cache else it call the api
      if(!lastUpdate.isBefore(DateTime.now().dateOnly(DateTime.now()))){
        var response = await localDataSource.getFreeToPlayGames();
        return response;
      }else {
        var response = await remoteDataSource.getGames();
        var data = jsonEncode(response!.map((e) => e.toData().toJson()).toList());
        await localDataSource.cacheData(data: data, key: "FreeToPlayGames");
        return response;
      }
    }else {
      var response = await remoteDataSource.getGames();
      var data = jsonEncode(response!.map((e) => e.toData().toJson()).toList());
      await localDataSource.cacheData(data: data, key: "FreeToPlayGames");
      return response;
    }
  }

}