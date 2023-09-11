import 'package:El3b/Domain/Models/Games/RAWG/Tags.dart';

class TagsDTO {
  num? id;
  String? name;
  String? slug;
  String? language;
  num? gamesCount;
  String? imageBackground;

  TagsDTO(
      { this.id,
        this.name,
        this.slug,
        this.language,
        this.gamesCount,
        this.imageBackground});

  TagsDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    language = json['language'];
    gamesCount = json['games_count'];
    imageBackground = json['image_background'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['language'] = language;
    data['games_count'] = gamesCount;
    data['image_background'] = imageBackground;
    return data;
  }

  Tags toDomain(){
    return Tags(
        id : id,
        name : name,
        slug : slug,
        language : language,
        gamesCount : gamesCount,
        imageBackground : imageBackground,
    );
  }
}