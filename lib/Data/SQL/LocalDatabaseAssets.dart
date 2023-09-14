
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


  String giveawayGamesTable = '''
      CREATE TABLE `GiveawayGames` (  
      `title` text null , 
      `worth` text null ,
      `image` text null ,
      `instructions` text null ,
      `openGiveawayUrl` text null ,
      `platforms` text null ,
      `endDate` text null 
    );
  ''';

  String freeToPlayGamesTable = '''
      CREATE TABLE `FreeToPlayGames` (  
        `title` text null,
        `thumbnail` text null,
        `shortDescription` text null,
        `gameUrl` text null,
        `genre` text null,
        `platform` text null
      );
  ''';

  String rawgGamesTable = '''
        CREATE TABLE `rawgGamesTable` (  
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
            `gameID` INTEGER null ,  
            `id` INTEGER null ,
            `image` text null
          );
    ''';

  String favoriteRAWGGamesTable = '''
        CREATE TABLE `favoriteRAWGGamesTable` (  
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
            `gameID` INTEGER null ,  
            `id` INTEGER null ,
            `image` text null
          );
    ''';




}
