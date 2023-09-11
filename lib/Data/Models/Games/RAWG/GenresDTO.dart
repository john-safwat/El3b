import 'package:El3b/Domain/Models/Games/RAWG/Genres.dart';

class GenresDTO {
  num? id;
  String? name;
  String? slug;
  num? gamesCount;
  String? imageBackground;

  GenresDTO(
      {this.id, this.name, this.slug, this.gamesCount, this.imageBackground});

  GenresDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    gamesCount = json['games_count'];
    imageBackground = json['image_background'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['games_count'] = gamesCount;
    data['image_background'] = imageBackground;
    return data;
  }

  Genres toDomain(){
    return Genres(
      id : id,
      name : name,
      slug : slug,
      gamesCount : gamesCount,
      imageBackground : imageBackground,
    );
  }
}