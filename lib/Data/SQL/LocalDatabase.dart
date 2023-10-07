import 'package:El3b/Data/SQL/LocalDatabaseAssets.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// dependency injection
LocalDatabase injectLocalDatabase() {
  return LocalDatabase.getInstance(injectLocalDatabaseAssets());
}

class LocalDatabase {
  Database? _db;
  LocalDatabaseAssets assets;

  // singleton Pattern
  LocalDatabase._(this.assets) {
    getDB();
  }
  static LocalDatabase? _instance;
  static LocalDatabase getInstance(LocalDatabaseAssets assets) {
    return _instance ??= LocalDatabase._(assets);
  }

  // function to create database
  Future<Database?> getDB() async {
    if (_db == null) {
      _db = await _initiateDB();
      return _db;
    } else {
      return _db;
    }
  }

  // function to init database
  _initiateDB() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'El3b.db');
    Database myDb = await openDatabase(path, onCreate: _onCreate, version: 1);
    return myDb;
  }

  // function to create database and create it's tables
  _onCreate(Database db, int version) async {
    await db.execute(assets.rawgGamesTable);
    await db.execute(assets.rawgGamesGenresTable);
    await db.execute(assets.rawgGamesStoresTable);
    await db.execute(assets.rawgGamesScreenShotsTable);
    await db.execute(assets.favoriteRAWGGamesTable);
    await db.execute(assets.favoriteRAWGGamesGenresTable);
    await db.execute(assets.favoriteRAWGGamesStoresTable);
    await db.execute(assets.favoriteRAWGGamesScreenShotsTable);
    debugPrint("Database Created");
  }

  Future<int> addGame(
      {required String gameSQL,
      required String genresSQL,
      required String storesSQL,
      required String screenShotsSQL}) async {
    await _db!.rawInsert(gameSQL);
    await _db!.rawInsert(genresSQL);
    await _db!.rawInsert(storesSQL);
    var response = await _db!.rawInsert(screenShotsSQL);
    return response;
  }

  Future<int> deleteGame(
      {required String gameSQL,
    required String genresSQL,
    required String storesSQL,
    required String screenShotsSQL})async{
    await _db!.rawDelete(gameSQL);
    await _db!.rawDelete(genresSQL);
    await _db!.rawDelete(storesSQL);
    var response = await _db!.rawDelete(screenShotsSQL);
    return response;
  }

  Future<List<List<Map<String , dynamic>>>> getGames({required String gameSQL,
    required String genresSQL,
    required String storesSQL,
    required String screenShotsSQL})async{
    var games = await _db!.rawQuery(gameSQL);
    var genres = await _db!.rawQuery(genresSQL);
    var stores = await _db!.rawQuery(storesSQL);
    var screenShots = await _db!.rawQuery(screenShotsSQL);

    return [games , genres,stores,screenShots];
  }
}
