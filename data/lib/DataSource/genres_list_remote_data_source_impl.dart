import 'dart:async';
import 'dart:io';

import 'package:data/Api/RAWGGamesAPI/rawg_api.dart';
import 'package:domain/DataSource/genres_list_remote_data_source.dart';
import 'package:domain/Exception/dio_server_exception.dart';
import 'package:domain/Exception/internet_connection_exception.dart';
import 'package:domain/Exception/time_out_operations_exception.dart';
import 'package:domain/Exception/unknown_exception.dart';
import 'package:domain/Models/Genres/genre.dart';
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