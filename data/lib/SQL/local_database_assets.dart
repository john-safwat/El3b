
// dependency injection
LocalDatabaseAssets injectLocalDatabaseAssets(){
  return LocalDatabaseAssets.getInstance();
}


class LocalDatabaseAssets {

  // singleton pattern
  LocalDatabaseAssets._();
  static LocalDatabaseAssets? _instance;
  static LocalDatabaseAssets getInstance(){
    return _instance ??= LocalDatabaseAssets._();
  }

  String rawgGamesTable = '''
        CREATE TABLE `rawgGamesTable` (  
          `uid` text null ,
          `id` INTEGER  null,
          `name` text  null,
          `released` text  null,
          `backgroundImage` text  null,
          `rating` double(6,2) null, 
          `metacritic` INTEGER  null 
        );
  ''';

  String rawgGamesGenresTable = '''
          CREATE TABLE `rawgGamesGenresTable` (
            `uid` text null ,
            `gameID` INTEGER null ,  
            `id` INTEGER null ,
            `name` text null  ,
            `slug` text null  ,
            `gamesCount` INTEGER null ,
            `imageBackground` text null  
          );
    ''';

  String rawgGamesStoresTable = '''
          CREATE TABLE `rawgGamesStoresTable` (
            `uid` text null ,
            `gameID` INTEGER null ,  
            `id` INTEGER null ,
            `name` text null ,
            `slug` text null ,
            `domain` text null ,
            `gamesCount` INTEGER null ,
            `imageBackground` text null 
          );
    ''';

  String rawgGamesScreenShotsTable = '''
          CREATE TABLE `rawgGamesScreenShotsTable` (
            `uid` text null ,
            `gameID` INTEGER null ,  
            `id` INTEGER null ,
            `image` text null
          );
    ''';

  String favoriteRAWGGamesTable = '''
        CREATE TABLE `favoriteRAWGGamesTable` (  
          `uid` text null ,
          `id` INTEGER  null,
          `name` text  null,
          `released` text  null,
          `backgroundImage` text  null,
          `rating` double(6,2) null, 
          `metacritic` INTEGER  null 
        );
  ''';

  String favoriteRAWGGamesGenresTable = '''
          CREATE TABLE `favoriteRAWGGamesGenresTable` (
            `uid` text null ,
            `gameID` INTEGER null ,  
            `id` INTEGER null ,
            `name` text null  ,
            `slug` text null  ,
            `gamesCount` INTEGER null ,
            `imageBackground` text null  
          );
    ''';

  String favoriteRAWGGamesStoresTable = '''
          CREATE TABLE `favoriteRAWGGamesStoresTable` (
            `uid` text null ,
            `gameID` INTEGER null ,  
            `id` INTEGER null ,
            `name` text null ,
            `slug` text null ,
            `domain` text null ,
            `gamesCount` INTEGER null ,
            `imageBackground` text null 
          );
    ''';

  String favoriteRAWGGamesScreenShotsTable = '''
          CREATE TABLE `favoriteRAWGGamesScreenShotsTable` (
            `uid` text null ,
            `gameID` INTEGER null ,  
            `id` INTEGER null ,
            `image` text null
          );
    ''';




}
