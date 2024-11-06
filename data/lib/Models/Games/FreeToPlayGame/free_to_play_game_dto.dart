import 'package:domain/Models/Games/FreeToPlayGame/free_to_play_game.dart';

class FreeToPlayGameDTO {
  FreeToPlayGameDTO({
      this.id, 
      this.title, 
      this.thumbnail, 
      this.shortDescription, 
      this.gameUrl, 
      this.genre, 
      this.platform, 
      this.publisher, 
      this.developer, 
      this.releaseDate, 
      this.freetogameProfileUrl,});

  FreeToPlayGameDTO.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    shortDescription = json['short_description'];
    gameUrl = json['game_url'];
    genre = json['genre'];
    platform = json['platform'];
    publisher = json['publisher'];
    developer = json['developer'];
    releaseDate = json['release_date'];
    freetogameProfileUrl = json['freetogame_profile_url'];
  }
  num? id;
  String? title;
  String? thumbnail;
  String? shortDescription;
  String? gameUrl;
  String? genre;
  String? platform;
  String? publisher;
  String? developer;
  String? releaseDate;
  String? freetogameProfileUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['thumbnail'] = thumbnail;
    map['short_description'] = shortDescription;
    map['game_url'] = gameUrl;
    map['genre'] = genre;
    map['platform'] = platform;
    map['publisher'] = publisher;
    map['developer'] = developer;
    map['release_date'] = releaseDate;
    map['freetogame_profile_url'] = freetogameProfileUrl;
    return map;
  }

  FreeToPlayGame toDomain(){
    return FreeToPlayGame(
        title : title ,
        thumbnail : thumbnail ,
        shortDescription : shortDescription ,
        gameUrl : gameUrl ,
        genre : genre ,
        platform : platform ,
    );
  }

}