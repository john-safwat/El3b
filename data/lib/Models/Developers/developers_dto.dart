
import 'package:data/Models/Developers/positions_dto.dart';
import 'package:domain/Models/Developers/Developers.dart';

class DevelopersDTO {
  DevelopersDTO({
      this.id, 
      this.name, 
      this.slug, 
      this.image, 
      this.imageBackground, 
      this.gamesCount,
      this.positions,
      this.description,
  });

  DevelopersDTO.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    imageBackground = json['image_background'];
    gamesCount = json['games_count'];
    description = json['description'];
    if (json['positions'] != null) {
      positions = [];
      json['positions'].forEach((v) {
        positions?.add(PositionsDTO.fromJson(v));
      });
    }
  }
  num? id;
  String? name;
  String? slug;
  String? image;
  String? imageBackground;
  num? gamesCount;
  List<PositionsDTO>? positions;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['image'] = image;
    map['description'] = description;
    map['image_background'] = imageBackground;
    map['games_count'] = gamesCount;
    if (positions != null) {
      map['positions'] = positions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  Developer toDomain(){
    return Developer(
        id : id,
        name : name,
        slug : slug,
        image : image,
        imageBackground : imageBackground,
        gamesCount : gamesCount,
        positions : positions?.map((e) => e.toDomain()).toList(),
        description:description
    );
  }

}