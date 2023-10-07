import 'package:El3b/Data/Models/Genres/GenreDTO.dart';

class Genre {
  Genre({
      this.id, 
      this.name, 
      this.slug, 
      this.gamesCount, 
      this.imageBackground, 
  });

  num? id;
  String? name;
  String? slug;
  num? gamesCount;
  String? imageBackground;

  GenreDTO toData (){
    return GenreDTO(
        id : id,
        name : name,
        slug : slug,
        gamesCount : gamesCount,
        imageBackground : imageBackground,
    );
  }

}