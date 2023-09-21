import 'dart:async';
import 'dart:io';

import 'package:El3b/Data/Api/RAWGGamesAPI/RAWGAPI.dart';
import 'package:El3b/Data/Error/DioErrorHandler.dart';
import 'package:El3b/Domain/DataSource/RAWGGamesRemoteDataSource.dart';
import 'package:El3b/Domain/Exception/DioServerException.dart';
import 'package:El3b/Domain/Exception/InternetConnectionException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:dio/dio.dart';


// dependency injection
RAWGGamesRemoteDataSource injectRAWGGamesRemoteDataSource(){
  return RAWGGamesRemoteDataSourceImpl(api: injectRAWGAPI(), errorHandler: injectDioErrorHandler());
}

class RAWGGamesRemoteDataSourceImpl implements RAWGGamesRemoteDataSource {

  RAWGGamesAPI api ;
  DioErrorHandler errorHandler;

  RAWGGamesRemoteDataSourceImpl({required this.api , required this.errorHandler});

  // function to get all general games
  @override
  Future<List<RAWGGame>?> getGeneralGames() async{
    try {
      var response = await api.getGeneralGames().timeout(const Duration(seconds: 60));
      return response?.results?.map((e) => e.toDomain()).toList();
    }on DioException catch (e){
      throw DioServerException(errorMessage: errorHandler.dioExceptionHandler(e.type));
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
      throw DioServerException(errorMessage: errorHandler.dioExceptionHandler(e.type));
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
      throw DioServerException(errorMessage: errorHandler.dioExceptionHandler(e.type));
    }on TimeoutException {
      throw TimeOutOperationsException(errorMessage: "Loading Data Timed Out Refresh To Reload");
    }on IOException catch(e){
      throw InternetConnectionException(errorMessage: "Check Your Internet Connection");
    }catch (e){
      throw UnknownException(errorMessage: e.toString());
    }
  }

}