import 'dart:async';
import 'dart:io';

import 'package:data/Api/GiveawayGamesApi/giveaway_games_api.dart';
import 'package:domain/DataSource/giveaway_games_remote_data_source.dart';
import 'package:domain/Exception/dio_server_exception.dart';
import 'package:domain/Exception/internet_connection_exception.dart';
import 'package:domain/Exception/time_out_operations_exception.dart';
import 'package:domain/Exception/unknown_exception.dart';
import 'package:domain/Models/Games/GiveawayGames/giveaway_game.dart';
import 'package:dio/dio.dart';

GiveawayGamesRemoteDataSource injectGiveawayGamesRemoteDataSource() {
  return GiveawayGamesRemoteDataSourceImpl(
    api: injectGiveawayGamesApi(),
  );
}

// the object
class GiveawayGamesRemoteDataSourceImpl implements GiveawayGamesRemoteDataSource {

  GiveawayGamesApi api ;

  GiveawayGamesRemoteDataSourceImpl({required this.api });

  // function to load giveaway game from api and handle any remote data source calling exception
  @override
  Future<List<GiveawayGame>?> getAllGames() async{
    try {
      var response = await api.getAllGames().timeout(const Duration(seconds: 60));
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