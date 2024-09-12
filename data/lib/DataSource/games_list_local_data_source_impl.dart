import 'package:data/SQL/local_database.dart';
import 'package:domain/DataSource/games_list_local_data_source.dart';
import 'package:domain/Models/Games/RAWG/genres.dart';
import 'package:domain/Models/Games/RAWG/rawg_game.dart';
import 'package:domain/Models/Games/RAWG/short_screenshots.dart';
import 'package:domain/Models/Games/RAWG/store.dart';


// dependency injection
GamesListLocalDataSource injectGamesListLocalDataSource(){
  return GamesListLocalDataSourceImpl(database: injectLocalDatabase());
}

class GamesListLocalDataSourceImpl implements GamesListLocalDataSource{

  LocalDatabase database;
  GamesListLocalDataSourceImpl({required this.database});


  // this function goal is tom generate the sql query to send it to the database
  @override
  Future<int> addGameToWishList({required RAWGGame game, required String uid}) async{
    // parse the data of the game into sql query tp add it
    var gameSQL =  'INSERT INTO `favoriteRAWGGamesTable` (`uid`, `id` , `name` , `released` , `backgroundImage` , `rating` , `metacritic`) VALUES("$uid", ${game.id} , "${game.name}" , "${game.released}" , "${game.backgroundImage}" , ${game.rating} , ${game.metacritic});';
    var genresSQL = 'INSERT INTO `favoriteRAWGGamesGenresTable` (`uid`, `gameID`, `id` , `name` , `slug` , `gamesCount` , `imageBackground` ) VALUES';
    for (int i = 0 ; i<game.genres!.length ; i++){
      genresSQL += '("$uid", ${game.id} , ${game.genres![i].id} , "${game.genres![i].name}" , "${game.genres![i].slug}" , ${game.genres![i].gamesCount} , "${game.genres![i].imageBackground}")';
      if (i< game.genres!.length -1){
        genresSQL += " , ";
      }
    }
    genresSQL+= ";";
    var storesSQL = 'INSERT INTO `favoriteRAWGGamesStoresTable` (`uid`, `gameID`, `id` , `name` , `slug` , `domain` , `gamesCount` , `imageBackground` ) VALUES';
    for (int i = 0 ; i<game.stores!.length ; i++){
      storesSQL += '("$uid", ${game.id} , ${game.stores![i].id} , "${game.stores![i].name}" , "${game.stores![i].slug}" , "${game.stores![i].domain}", ${game.stores![i].gamesCount} , "${game.stores![i].imageBackground}")';
      if (i< game.stores!.length -1){
        storesSQL += " , ";
      }
    }
    var screenShotsSQL = 'INSERT INTO `favoriteRAWGGamesScreenShotsTable` (`uid` , `gameID` , `id` , `image` ) VALUES';
    for (int i = 0 ; i<game.shortScreenshots!.length ; i++){
      screenShotsSQL += '("$uid", ${game.id} , ${game.shortScreenshots![i].id} , "${game.shortScreenshots![i].image}")';
      if (i< game.shortScreenshots!.length -1){
        screenShotsSQL += " , ";
      }
    }
    screenShotsSQL+= ";";
    try {
      var response = await database.addGame(gameSQL: gameSQL, genresSQL: genresSQL, storesSQL: storesSQL, screenShotsSQL: screenShotsSQL);
      return response;
    }catch (e){
      throw Exception();
    }
  }

  // in this function it prepare all sql queries to delete the game from wish list
  @override
  Future<int> deleteGameFromWishList({required int game, required String uid}) async {
    var gameSQL = "DELETE FROM `favoriteRAWGGamesTable` WHERE `uid` = '$uid' AND `id` = $game ;";
    var genresSQL = "DELETE FROM `favoriteRAWGGamesGenresTable` WHERE `uid` = '$uid' AND `gameID` = $game ;";
    var storesSQL = "DELETE FROM `favoriteRAWGGamesStoresTable` WHERE `uid` = '$uid' AND `gameID` = $game ;";
    var screenShotsSQL = "DELETE FROM `favoriteRAWGGamesScreenShotsTable` WHERE `uid` = '$uid' AND `gameID` = $game ;";

    try {
      var response = await database.deleteGame(gameSQL: gameSQL, genresSQL: genresSQL, storesSQL: storesSQL, screenShotsSQL: screenShotsSQL);
      return response;
    }catch (e){
      throw Exception();
    }
  }

  // this function is more complex
  // it prepare the sql queries
  // then it request the data from the database
  // then convert it into objects to response
  @override
  Future<List<RAWGGame>?> loadGamesFromWishList({required String uid}) async{
    var gameSQL = "SELECT * FROM `favoriteRAWGGamesTable` WHERE `uid` = '$uid'";
    var genresSQL = "SELECT * FROM `favoriteRAWGGamesGenresTable` WHERE `uid` = '$uid'";
    var storesSQL = "SELECT * FROM `favoriteRAWGGamesStoresTable` WHERE `uid` = '$uid'";
    var screenShotsSQL = "SELECT * FROM `favoriteRAWGGamesScreenShotsTable` WHERE `uid` = '$uid'";

    try {
      var response = await database.getGames(gameSQL: gameSQL, genresSQL: genresSQL, storesSQL: storesSQL, screenShotsSQL: screenShotsSQL);
      var genres = response[1].map((e) => Genres(
          gameID : e["gameID"],
          id : e["id"],
          name : e["name"],
          slug : e["slug"],
          gamesCount : e["gamesCount"],
          imageBackground : e["imageBackground"]
      )).toList();

      var stores = response[2].map((e) => Store(
          gameID : e['gameID'],
          id : e['id'],
          name : e['name'],
          slug : e['slug'],
          domain : e['domain'],
          gamesCount : e['gamesCount'],
          imageBackground : e['imageBackground']
      )).toList();

       var screenShots = response[3].map((e) => ShortScreenshots(
           gameID : e['gameID'],
           id : e['id'],
           image : e['image']
      )).toList();

      var games = response[0].map((e) => RAWGGame(
          id : e["id"],
          name : e["name"],
          released : e["released"],
          backgroundImage : e["backgroundImage"],
          rating : e["rating"],
          metacritic : e["metacritic"],
          genres: genres.where((element) => element.gameID == e['id']).toList(),
          stores: stores.where((element) => element.gameID == e['id']).toList(),
          shortScreenshots:  screenShots.where((element) => element.gameID == e['id']).toList(),
      )).toList();

      return games;
    }catch (e){
      throw Exception();
    }

  }

  @override
  Future<int> addGameToHistory({required RAWGGame game, required String uid})async{
    // parse the data of the game into sql query tp add it
    var gameSQL =  'INSERT INTO `rawgGamesTable` (`uid`, `id` , `name` , `released` , `backgroundImage` , `rating` , `metacritic`) VALUES("$uid", ${game.id} , "${game.name}" , "${game.released}" , "${game.backgroundImage}" , ${game.rating} , ${game.metacritic});';
    var genresSQL = 'INSERT INTO `rawgGamesGenresTable` (`uid`, `gameID`, `id` , `name` , `slug` , `gamesCount` , `imageBackground` ) VALUES';
    for (int i = 0 ; i<game.genres!.length ; i++){
      genresSQL += '("$uid", ${game.id} , ${game.genres![i].id} , "${game.genres![i].name}" , "${game.genres![i].slug}" , ${game.genres![i].gamesCount} , "${game.genres![i].imageBackground}")';
      if (i< game.genres!.length -1){
        genresSQL += " , ";
      }
    }
    genresSQL+= ";";
    var storesSQL = 'INSERT INTO `rawgGamesStoresTable` (`uid`, `gameID`, `id` , `name` , `slug` , `domain` , `gamesCount` , `imageBackground` ) VALUES';
    for (int i = 0 ; i<game.stores!.length ; i++){
      storesSQL += '("$uid", ${game.id} , ${game.stores![i].id} , "${game.stores![i].name}" , "${game.stores![i].slug}" , "${game.stores![i].domain}", ${game.stores![i].gamesCount} , "${game.stores![i].imageBackground}")';
      if (i< game.stores!.length -1){
        storesSQL += " , ";
      }
    }
    var screenShotsSQL = 'INSERT INTO `rawgGamesScreenShotsTable` (`uid` , `gameID` , `id` , `image` ) VALUES';
    for (int i = 0 ; i<game.shortScreenshots!.length ; i++){
      screenShotsSQL += '("$uid", ${game.id} , ${game.shortScreenshots![i].id} , "${game.shortScreenshots![i].image}")';
      if (i< game.shortScreenshots!.length -1){
        screenShotsSQL += " , ";
      }
    }
    screenShotsSQL+= ";";
    try {
      var response = await database.addGame(gameSQL: gameSQL, genresSQL: genresSQL, storesSQL: storesSQL, screenShotsSQL: screenShotsSQL);
      return response;
    }catch (e){
      throw Exception();
    }
  }

  @override
  Future<int> deleteGameFromHistory({required int game, required String uid}) async{
    var gameSQL = "DELETE FROM `rawgGamesTable` WHERE `uid` = '$uid' AND `id` = $game ;";
    var genresSQL = "DELETE FROM `rawgGamesGenresTable` WHERE `uid` = '$uid' AND `gameID` = $game ;";
    var storesSQL = "DELETE FROM `rawgGamesStoresTable` WHERE `uid` = '$uid' AND `gameID` = $game ;";
    var screenShotsSQL = "DELETE FROM `rawgGamesScreenShotsTable` WHERE `uid` = '$uid' AND `gameID` = $game ;";

    try {
      var response = await database.deleteGame(gameSQL: gameSQL, genresSQL: genresSQL, storesSQL: storesSQL, screenShotsSQL: screenShotsSQL);
      return response;
    }catch (e){
      throw Exception();
    }
  }

  @override
  Future<List<RAWGGame>?> loadGamesFromHistory({required String uid}) async{
    var gameSQL = "SELECT * FROM `rawgGamesTable` WHERE `uid` = '$uid'";
    var genresSQL = "SELECT * FROM `rawgGamesGenresTable` WHERE `uid` = '$uid'";
    var storesSQL = "SELECT * FROM `rawgGamesStoresTable` WHERE `uid` = '$uid'";
    var screenShotsSQL = "SELECT * FROM `rawgGamesScreenShotsTable` WHERE `uid` = '$uid'";

    try {
      var response = await database.getGames(gameSQL: gameSQL, genresSQL: genresSQL, storesSQL: storesSQL, screenShotsSQL: screenShotsSQL);
      var genres = response[1].map((e) => Genres(
          gameID : e["gameID"],
          id : e["id"],
          name : e["name"],
          slug : e["slug"],
          gamesCount : e["gamesCount"],
          imageBackground : e["imageBackground"]
      )).toList();

      var stores = response[2].map((e) => Store(
          gameID : e['gameID'],
          id : e['id'],
          name : e['name'],
          slug : e['slug'],
          domain : e['domain'],
          gamesCount : e['gamesCount'],
          imageBackground : e['imageBackground']
      )).toList();

      var screenShots = response[3].map((e) => ShortScreenshots(
          gameID : e['gameID'],
          id : e['id'],
          image : e['image']
      )).toList();

      var games = response[0].map((e) => RAWGGame(
        id : e["id"],
        name : e["name"],
        released : e["released"],
        backgroundImage : e["backgroundImage"],
        rating : e["rating"],
        metacritic : e["metacritic"],
        genres: genres.where((element) => element.gameID == e['id']).toList(),
        stores: stores.where((element) => element.gameID == e['id']).toList(),
        shortScreenshots:  screenShots.where((element) => element.gameID == e['id']).toList(),
      )).toList();

      return games;
    }catch (e){
      throw Exception();
    }
  }

  @override
  Future<bool> gameExist({required String gameId, required String uid}) async{
    try{
      var sql = "SELECT COUNT(*) as count FROM `rawgGamesTable` WHERE `uid` = '$uid' AND `id` = '$gameId';";
      var response =  await database.gameExist(sql: sql);
      return response ;
    }catch(e){
      throw Exception();
    }
  }



}