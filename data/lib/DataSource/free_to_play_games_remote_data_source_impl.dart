import 'dart:async';
import 'dart:io';

import 'package:data/Api/FreeToPlayGamesApi/free_to_play_games_api.dart';
import 'package:domain/DataSource/free_to_play_games_remote_data_source.dart';
import 'package:domain/Exception/dio_server_exception.dart';
import 'package:domain/Exception/internet_connection_exception.dart';
import 'package:domain/Exception/time_out_operations_exception.dart';
import 'package:domain/Exception/unknown_exception.dart';
import 'package:domain/Models/Games/FreeToPlayGame/free_to_play_game.dart';
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