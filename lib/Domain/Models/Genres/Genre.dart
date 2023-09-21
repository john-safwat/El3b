import 'package:El3b/Data/Models/Genres/GenreDTO.dart';

class Genre {
  Genre({
      this.id, 
      this.name, 
      this.slug, 
      this.gamesCount, 
      this.imageBackground, 
  });

  Genre.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    gamesCount = json['games_count'];
    imageBackground = json['image_background'];
  }
  num? id;
  String? name;
  String? slug;
  num? gamesCount;
  String? imageBackground;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['games_count'] = gamesCount;
    map['image_background'] = imageBackground;
    return map;
  }

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