import 'package:data/Models/Games/FreeToPlayGame/FreeToPlayGameDTO.dart';

class FreeToPlayGame {
  FreeToPlayGame({
      this.title, 
      this.thumbnail, 
      this.shortDescription, 
      this.gameUrl, 
      this.genre, 
      this.platform,});

  String? title;
  String? thumbnail;
  String? shortDescription;
  String? gameUrl;
  String? genre;
  String? platform;
  String? icon;

  FreeToPlayGameDTO toData(){
    return FreeToPlayGameDTO(
        title : title,
        thumbnail : thumbnail,
        shortDescription : shortDescription,
        gameUrl : gameUrl,
        genre : genre,
        platform : platform,
    );
  }

}