import 'dart:async';
import 'dart:io';

import 'package:El3b/Data/Api/GiveawayGamesApi/GiveawayGamesApi.dart';
import 'package:El3b/Domain/DataSource/GiveawayGamesRemoteDataSource.dart';
import 'package:El3b/Domain/Exception/DioServerException.dart';
import 'package:El3b/Domain/Exception/InternetConnectionException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
import 'package:El3b/Domain/Models/Games/GiveawayGames/GiveawayGame.dart';
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