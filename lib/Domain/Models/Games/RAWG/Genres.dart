import 'package:El3b/Data/Models/Games/RAWG/GenresDTO.dart';

class Genres {
  num? gameID;
  num? id;
  String? name;
  String? slug;
  num? gamesCount;
  String? imageBackground;

  Genres({this.gameID , this.id, this.name, this.slug, this.gamesCount, this.imageBackground});

  GenresDTO toData(){
    return GenresDTO(
        id : id ,
        name : name ,
        slug : slug ,
        gamesCount : gamesCount ,
        imageBackground : imageBackground ,
    );
  }

}
