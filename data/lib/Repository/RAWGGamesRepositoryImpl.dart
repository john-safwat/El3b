
import 'dart:convert';

import 'package:data/DataSource/cache_data_local_data_source_impl.dart';
import 'package:data/DataSource/rawg_games_remote_data_source_impl.dart';
import 'package:data/DataSource/games_list_local_data_source_impl.dart';
import 'package:domain/DataSource/CacheDataLocalDataSource.dart';
import 'package:domain/DataSource/RAWGGamesRemoteDataSource.dart';
import 'package:domain/DataSource/GamesListLocalDataSource.dart';
import 'package:domain/Exception/DioServerException.dart';
import 'package:domain/Exception/InternetConnectionException.dart';
import 'package:domain/Exception/TimeOutOperationsException.dart';
import 'package:domain/Exception/UnknownException.dart';
import 'package:domain/Models/Games/GameDetails/GameDetails.dart';
import 'package:domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:domain/Repository/RAWGGamesRepository.dart';


// dependency injection
RAWGGamesRepository injectRAWGGamesRepository(){
  return RAWGGamesRepositoryImpl(
    remoteDataSource: injectRAWGGamesRemoteDataSource(),
    gamesListLocalDataSource: injectGamesListLocalDataSource(),
    localDataSource: injectCacheDataLocalDataSource()
  );
}


class RAWGGamesRepositoryImpl implements RAWGGamesRepository {

  RAWGGamesRemoteDataSource remoteDataSource ;
  CacheDataLocalDataSource localDataSource;
  GamesListLocalDataSource gamesListLocalDataSource;
  RAWGGamesRepositoryImpl({
    required this.remoteDataSource ,
    required this.gamesListLocalDataSource,
    required this.localDataSource
  });

  // function to load giveaway game from api throw data source
  // in this function it call the cache to check for the last time data cached
  // it the cache is outDated or has not stored is call the api
  @override
  Future<List<RAWGGame>?> getGeneralGames() async {
    try{
      var response = await remoteDataSource.getGeneralGames();
      var data = jsonEncode(response!.map((e) => e.toData().toJson()).toList());
      await localDataSource.cacheData(data: data, key: "GeneralGames");
      return response;
    }catch (e){
      // get last update time for the data in cache
      // if user first time open the app this value will be null
      var lastUpdate =  await localDataSource.getLastUpdatedDate(key: "GeneralGames");
      if(lastUpdate != null ){
        // if the data is valid is return the data from the cache else it call the api
        try{
          var response = await localDataSource.getGeneralGames();
          return response;
        }catch(e){
          if (e is DioServerException ){
            throw DioServerException(errorMessage: e.errorMessage);
          }
          else if (e is TimeOutOperationsException ){
            throw TimeOutOperationsException(errorMessage: "Loading Data Timed Out Refresh To Reload");
          }
          else if (e is InternetConnectionException ){
            throw InternetConnectionException(errorMessage: "Check Your Internet Connection");
          }
          else {
            throw UnknownException(errorMessage: e.toString());
          }
        }
      }else {
        if (e is DioServerException ){
          throw DioServerException(errorMessage: e.errorMessage);
        }
        else if (e is TimeOutOperationsException ){
          throw TimeOutOperationsException(errorMessage: "Loading Data Timed Out Refresh To Reload");
        }
        else if (e is InternetConnectionException ){
          throw InternetConnectionException(errorMessage: "Check Your Internet Connection");
        }
        else {
          throw UnknownException(errorMessage: e.toString());
        }
      }
    }
  }

  // function to add
  @override
  Future<int> addGameToWishList({required RAWGGame game, required String uid}) async{
    var response = await gamesListLocalDataSource.addGameToWishList(game: game, uid: uid);
    return response;
  }

  @override
  Future<int> deleteGameFromWishList({required int game, required String uid}) async{
    var response = await gamesListLocalDataSource.deleteGameFromWishList(game: game, uid: uid);
    return response;
  }

  @override
  Future<List<RAWGGame>?> loadGamesFromWishList({required String uid}) async{
    var response = await gamesListLocalDataSource.loadGamesFromWishList(uid: uid);
    return response!;
  }

  @override
  Future<List<RAWGGame>?> searchForGame({required String query}) async{
    var response = await remoteDataSource.searchForGame(query: query);
    return response ;
  }

  @override
  Future<(num? , List<RAWGGame>?)> getGamesByGenre({required String genre, required int pageNumber}) async{
   var (count , response) = await remoteDataSource.getGamesByGenre(genre: genre, pageNumber: pageNumber);
   return (count , response);
  }

  // function to get the Game details from RAWG games API
  @override
  Future<GameDetails?> getGameDetails({required String id}) async{
    var response = await remoteDataSource.getGameDetails(id: id);
    return response;
  }

  // function to validate if the game data exist in data base or not
  @override
  Future<bool> gameExist({required String gameId, required String uid})async {
    var response = await gamesListLocalDataSource.gameExist(gameId: gameId, uid: uid);
    return response ;
  }

  @override
  Future<int> addGameToHistory({required RAWGGame game, required String uid}) async{
    var response = await gamesListLocalDataSource.addGameToHistory(game: game, uid: uid);
    return response ;
  }

  @override
  Future<int> deleteGameFromHistory({required int game, required String uid}) async{
    var response = await gamesListLocalDataSource.deleteGameFromHistory(game: game, uid: uid);
    return response ;
  }

  @override
  Future<List<RAWGGame>?> loadGamesFromHistory({required String uid}) async {
    var response = await gamesListLocalDataSource.loadGamesFromHistory(uid: uid);
    return response ;
  }

}