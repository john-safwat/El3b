import 'dart:async';
import 'dart:io';

import 'package:data/Api/RAWGGamesAPI/rawg_api.dart';
import 'package:domain/DataSource/RAWGGamesRemoteDataSource.dart';
import 'package:domain/Exception/DioServerException.dart';
import 'package:domain/Exception/InternetConnectionException.dart';
import 'package:domain/Exception/TimeOutOperationsException.dart';
import 'package:domain/Exception/UnknownException.dart';
import 'package:domain/Models/Games/GameDetails/GameDetails.dart';
import 'package:domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:dio/dio.dart';


// dependency injection
RAWGGamesRemoteDataSource injectRAWGGamesRemoteDataSource(){
  return RAWGGamesRemoteDataSourceImpl(api: injectRAWGAPI());
}

class RAWGGamesRemoteDataSourceImpl implements RAWGGamesRemoteDataSource {

  RAWGGamesAPI api ;

  RAWGGamesRemoteDataSourceImpl({required this.api });

  // function to get all general games
  @override
  Future<List<RAWGGame>?> getGeneralGames() async{
    try {
      var response = await api.getGeneralGames().timeout(const Duration(seconds: 60));
      return response?.results?.map((e) => e.toDomain()).toList();
    }on DioException catch (e){
      throw DioServerException(errorMessage: e.type);
    }on TimeoutException {
      throw TimeOutOperationsException(errorMessage: "Loading Data Timed Out Refresh To Reload");
    }on IOException catch(e){
      throw InternetConnectionException(errorMessage: "Check Your Internet Connection");
    }catch (e){
      throw UnknownException(errorMessage: e.toString());
    }
  }

  // function to load data for games search from RAWG api
  @override
  Future<List<RAWGGame>?> searchForGame({required String query})async {
    try {
      var response = await api.searchForGame(query: query).timeout(const Duration(seconds: 60));
      return response?.results?.map((e) => e.toDomain()).toList();
    }on DioException catch (e){
      throw DioServerException(errorMessage: e.type);
    }on TimeoutException {
      throw TimeOutOperationsException(errorMessage: "Loading Data Timed Out Refresh To Reload");
    }on IOException catch(e){
      throw InternetConnectionException(errorMessage: "Check Your Internet Connection");
    }catch (e){
      throw UnknownException(errorMessage: e.toString());
    }
  }

  // function to load data from API by genre
  @override
  Future<(num? , List<RAWGGame>?)> getGamesByGenre({required String genre , required int pageNumber})async {
    try {
      var response = await api.getGamesByGenre(genres: genre , pageNumber: pageNumber).timeout(const Duration(seconds: 60));
      return (response?.count , response?.results?.map((e) => e.toDomain()).toList());
    }on DioException catch (e){
      throw DioServerException(errorMessage: e.type);
    }on TimeoutException {
      throw TimeOutOperationsException(errorMessage: "Loading Data Timed Out Refresh To Reload");
    }on IOException catch(e){
      throw InternetConnectionException(errorMessage: "Check Your Internet Connection");
    }catch (e){
      throw UnknownException(errorMessage: e.toString());
    }
  }


  // function to get the game details from the RAWG api
  @override
  Future<GameDetails?> getGameDetails({required String id}) async {
    try {
      var response = await api.getGameDetails(id: id).timeout(const Duration(seconds: 60));
      return response.toDomain();
    }on DioException catch (e){
      throw DioServerException(errorMessage: e.type);
    }on TimeoutException {
      throw TimeOutOperationsException(errorMessage: "Loading Data Timed Out Refresh To Reload");
    }on IOException catch(e){
      throw InternetConnectionException(errorMessage: "Check Your Internet Connection");
    }catch (e){
      throw UnknownException(errorMessage: e.toString());
    }
  }

}