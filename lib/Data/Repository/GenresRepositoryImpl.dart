import 'dart:convert';

import 'package:El3b/Core/Extension/DateOnlyExtinsion.dart';
import 'package:El3b/Data/DataSource/CacheDataLocalDataSourceImpl.dart';
import 'package:El3b/Data/DataSource/GenresListRemoteDataSourceImpl.dart';
import 'package:El3b/Domain/DataSource/CacheDataLocalDataSource.dart';
import 'package:El3b/Domain/DataSource/GenresListRemoteDataSource.dart';
import 'package:El3b/Domain/Models/Genres/Genre.dart';
import 'package:El3b/Domain/Repository/GenresRepository.dart';


// dependency injection
GenresRepository injectGenresRepository() {
  return GenresRepositoryImpl(
      remoteDataSource: injectGenresListRemoteDataSource(),
      localDataSource: injectCacheDataLocalDataSource()
  );
}

class GenresRepositoryImpl implements GenresRepository {

  GenresListRemoteDataSource remoteDataSource;
  CacheDataLocalDataSource localDataSource;
  GenresRepositoryImpl ({required this.remoteDataSource , required this.localDataSource});


  // function to load genres from api throw data source
  // in this function it call the cache to check for the last time data cached
  // it the cache is outDated or has not stored is call the api
  @override
  Future<List<Genre>?> getGenres()async {
    // get last update time for the data in cache
    var lastUpdate =  await localDataSource.getLastUpdatedDate(key: "Genre");
    // if user first time open the app this value will be null
    if(lastUpdate != null ){
      // if the data is valid is return the data from the cache else it call the api
      if(!lastUpdate.isBefore(DateTime.now().dateOnly(DateTime.now()))){
        var response = await localDataSource.getGenresList();
        return response;
      }else {
        var response = await remoteDataSource.getAllGenres();
        var data = jsonEncode(response!.map((e) => e.toData().toJson()).toList());
        await localDataSource.cacheData(data: data, key: "Genre");
        return response;
      }
    }else {
      var response = await remoteDataSource.getAllGenres();
      var data = jsonEncode(response!.map((e) => e.toData().toJson()).toList());
      await localDataSource.cacheData(data: data, key: "Genre");
      return response;
    }
  }



}