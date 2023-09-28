import 'dart:async';
import 'dart:io';

import 'package:El3b/Data/Api/RAWGGamesAPI/RAWGAPI.dart';
import 'package:El3b/Data/Error/DioErrorHandler.dart';
import 'package:El3b/Domain/DataSource/GameDevelopersRemoteDataSource.dart';
import 'package:El3b/Domain/Exception/DioServerException.dart';
import 'package:El3b/Domain/Exception/InternetConnectionException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
import 'package:El3b/Domain/Models/Developers/Developers.dart';
import 'package:dio/dio.dart';



// dependency injection
GameDevelopersRemoteDataSource injectGameDevelopersRemoteDataSource(){
  return GameDevelopersRemoteDataSourceImpl(
      api: injectRAWGAPI(),
      errorHandler: injectDioErrorHandler()
  );
}


class GameDevelopersRemoteDataSourceImpl extends GameDevelopersRemoteDataSource {

  RAWGGamesAPI api ;
  DioErrorHandler errorHandler;

  GameDevelopersRemoteDataSourceImpl({required this.api , required this.errorHandler});

  @override
  Future<List<Developers>?> getGameDevelopers({required String id})async {
    try {
      var response = await api.getGameDevelopers(id: id).timeout(const Duration(seconds: 60));
      return response?.developers?.map((e) => e.toDomain()).toList();
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