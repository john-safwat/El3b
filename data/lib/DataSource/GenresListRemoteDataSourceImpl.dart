import 'dart:async';
import 'dart:io';

import 'package:data/Api/RAWGGamesAPI/RAWGAPI.dart';
import 'package:domain/DataSource/GenresListRemoteDataSource.dart';
import 'package:domain/Exception/DioServerException.dart';
import 'package:domain/Exception/InternetConnectionException.dart';
import 'package:domain/Exception/TimeOutOperationsException.dart';
import 'package:domain/Exception/UnknownException.dart';
import 'package:domain/Models/Genres/Genre.dart';
import 'package:dio/dio.dart';


GenresListRemoteDataSource injectGenresListRemoteDataSource(){
  return GenresListRemoteDataSourceImpl(
      api: injectRAWGAPI(),
  );
}


class GenresListRemoteDataSourceImpl implements GenresListRemoteDataSource {

  RAWGGamesAPI api ;
  GenresListRemoteDataSourceImpl({required this.api});


  // function to get the genres response from api and send the genres list to the  
  @override
  Future<List<Genre>?> getAllGenres() async{
    try{
      var response = await api.getAllGenres().timeout(const Duration(seconds: 60));
      return response.results!.map((e) => e.toDomain()).toList();
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