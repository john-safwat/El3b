import 'package:domain/Models/Genres/Genre.dart';

import 'GamesDTO.dart';

class GenreDTO {
  GenreDTO({
      this.id, 
      this.name, 
      this.slug, 
      this.gamesCount, 
      this.imageBackground, 
      this.games,});

  GenreDTO.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    gamesCount = json['games_count'];
    imageBackground = json['image_background'];
    if (json['games'] != null) {
      games = [];
      json['games'].forEach((v) {
        games?.add(GamesDTO.fromJson(v));
      });
    }
  }
  num? id;
  String? name;
  String? slug;
  num? gamesCount;
  String? imageBackground;
  List<GamesDTO>? games;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['games_count'] = gamesCount;
    map['image_background'] = imageBackground;
    if (games != null) {
      map['games'] = games?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  Genre toDomain(){
    return Genre(
        id : id ,
        name : name ,
        slug : slug ,
        gamesCount : gamesCount ,
        imageBackground : imageBackground
    );
  }

}