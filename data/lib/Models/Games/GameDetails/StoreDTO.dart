import 'package:domain/Models/Games/GameDetails/Store.dart';

class StoreDTO {
  num? id;
  String? name;
  String? slug;
  String? domain;
  num? gamesCount;
  String? imageBackground;

  StoreDTO(
      { this.id,
        this.name,
        this.slug,
        this.domain,
        this.gamesCount,
        this.imageBackground});

  StoreDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    domain = json['domain'];
    gamesCount = json['games_count'];
    imageBackground = json['image_background'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['domain'] = domain;
    data['games_count'] = gamesCount;
    data['image_background'] = imageBackground;
    return data;
  }

  Store toDomain(){
    return Store(
        id : id ,
        name : name ,
        slug : slug ,
        domain : domain ,
        gamesCount : gamesCount ,
        imageBackground : imageBackground ,
    );
  }
}