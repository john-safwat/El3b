import 'dart:async';
import 'dart:io';

import 'package:El3b/Data/Api/FreeToPlayGamesApi/FreeToPlayGamesApi.dart';
import 'package:El3b/Domain/DataSource/FreeToPlayGamesRemoteDataSource.dart';
import 'package:El3b/Domain/Exception/DioServerException.dart';
import 'package:El3b/Domain/Exception/InternetConnectionException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
import 'package:El3b/Domain/Models/Games/FreeToPlayGame/FreeToPlayGame.dart';
import 'package:dio/dio.dart';

// dependency injection
FreeToPlayGamesRemoteDataSource injectFreeToPlayGamesRemoteDataSource(){
  return FreeToPlayGamesRemoteDataSourceImpl(
    api: injectFreeToPlayGamesApi(),
  );
}


class FreeToPlayGamesRemoteDataSourceImpl implements FreeToPlayGamesRemoteDataSource {

  FreeToPlayGamesApi api;
  FreeToPlayGamesRemoteDataSourceImpl({required this.api});

  // function to get the free to play games from The Api
  @override
  Future<List<FreeToPlayGame>?> getGames()async {
    try {
      var response = await api.getGames().timeout(const Duration(seconds: 60));
      return response!.map((e) => e.toDomain()).toList();
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