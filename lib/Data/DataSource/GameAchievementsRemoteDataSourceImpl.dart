import 'dart:async';
import 'dart:io';

import 'package:El3b/Data/Api/RAWGGamesAPI/RAWGAPI.dart';
import 'package:El3b/Data/Error/DioErrorHandler.dart';
import 'package:El3b/Domain/DataSource/GameAchievementsRemoteDataSource.dart';
import 'package:El3b/Domain/Exception/DioServerException.dart';
import 'package:El3b/Domain/Exception/InternetConnectionException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
import 'package:El3b/Domain/Models/Achievements/Achievement.dart';
import 'package:dio/dio.dart';


// dependency injection
GameAchievementsRemoteDataSource injectGameAchievementsRemoteDataSource(){
  return GameAchievementsRemoteDataSourceImpl(
    api: injectRAWGAPI(),
    errorHandler: injectDioErrorHandler()
  );
}


class GameAchievementsRemoteDataSourceImpl implements GameAchievementsRemoteDataSource {

  RAWGGamesAPI api ;
  DioErrorHandler errorHandler;
  GameAchievementsRemoteDataSourceImpl({required this.api , required this.errorHandler});

  @override
  Future<List<Achievement>?> getGameAchievements({required String id}) async{
    try {
      var response = await api.getGameAchievements(id: id , size: "10").timeout(const Duration(seconds: 60));
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

  @override
  Future<(String?, List<Achievement>?)> getAllAGameAchievements({required String id})async {
    try {
      var response = await api.getGameAchievements(id: id , size: "40").timeout(const Duration(seconds: 60));
      return (response?.next , response?.results?.map((e) => e.toDomain()).toList());
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