
import 'dart:convert';

import 'package:El3b/Core/Extension/DateOnlyExtinsion.dart';
import 'package:El3b/Data/Cache/LocalCache.dart';
import 'package:El3b/Data/DataSource/CacheDataLocalDataSourceImpl.dart';
import 'package:El3b/Data/DataSource/RAWGGamesRemoteDataSourceImpl.dart';
import 'package:El3b/Data/DataSource/WishListLocalDataSourceImpl.dart';
import 'package:El3b/Domain/DataSource/CacheDataLocalDataSource.dart';
import 'package:El3b/Domain/DataSource/RAWGGamesRemoteDataSource.dart';
import 'package:El3b/Domain/DataSource/WishListLocalDataSource.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:El3b/Domain/Repository/RAWGGamesRepository.dart';


// dependency injection
RAWGGamesRepository injectRAWGGamesRepository(){
  return RAWGGamesRepositoryImpl(
    remoteDataSource: injectRAWGGamesRemoteDataSource(),
    wishListLocalDataSource: injectWishListLocalDataSource(),
    localDataSource: injectCacheDataLocalDataSource()
  );
}


class RAWGGamesRepositoryImpl implements RAWGGamesRepository {

  RAWGGamesRemoteDataSource remoteDataSource ;
  CacheDataLocalDataSource localDataSource;
  WishListLocalDataSource wishListLocalDataSource;
  RAWGGamesRepositoryImpl({
    required this.remoteDataSource ,
    required this.wishListLocalDataSource,
    required this.localDataSource
  });

  // function to load giveaway game from api throw data source
  // in this function it call the cache to check for the last time data cached
  // it the cache is outDated or has not stored is call the api
  @override
  Future<List<RAWGGame>?> getGeneralGames() async {
    var response = await remoteDataSource.getGeneralGames();
    return response;
    // get last update time for the data in cache
    var lastUpdate =  await localDataSource.getLastUpdatedDate(key: "GeneralGames");
    // if user first time open the app this value will be null
    if(lastUpdate != null ){
      // if the data is valid is return the data from the cache else it call the api
      if(!lastUpdate.isBefore(DateTime.now().dateOnly(DateTime.now()))){
        var response = await localDataSource.getGeneralGames();
        return response;
      }else {
        var response = await remoteDataSource.getGeneralGames();
        var data = jsonEncode(response!.map((e) => e.toData().toJson()).toList());
        await localDataSource.cacheData(data: data, key: "GeneralGames");
        return response;
      }
    }else {
      var response = await remoteDataSource.getGeneralGames();
      var data = jsonEncode(response!.map((e) => e.toData().toJson()).toList());
      await localDataSource.cacheData(data: data, key: "GeneralGames");
      return response;
    }
  }

  @override
  Future<int> addGameToWishList({required RAWGGame game, required String uid}) async{
    var response = await wishListLocalDataSource.addGameToWishList(game: game, uid: uid);
    return response;
  }

  @override
  Future<int> deleteGameFromWishList({required int game, required String uid}) async{
    var response = await wishListLocalDataSource.deleteGameFromWishList(game: game, uid: uid);
    return response;
  }

  @override
  Future<List<RAWGGame>?> loadGamesFromWishList({required String uid}) async{
    var response = await wishListLocalDataSource.loadGamesFromWishList(uid: uid);
    return response!;
  }

}