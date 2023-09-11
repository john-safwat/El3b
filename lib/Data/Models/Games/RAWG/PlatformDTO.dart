import 'package:El3b/Domain/Models/Games/RAWG/Platform.dart';

class PlatformDTO {
  num? id;
  String? name;
  String? slug;
  String? image;
  String? yearEnd;
  num? yearStart;
  num? gamesCount;
  String? imageBackground;

  PlatformDTO(
      { this.id,
        this.name,
        this.slug,
        this.image,
        this.yearEnd,
        this.yearStart,
        this.gamesCount,
        this.imageBackground});

  PlatformDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    yearEnd = json['year_end'];
    yearStart = json['year_start'];
    gamesCount = json['games_count'];
    imageBackground = json['image_background'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['image'] = image;
    data['year_end'] = yearEnd;
    data['year_start'] = yearStart;
    data['games_count'] = gamesCount;
    data['image_background'] = imageBackground;
    return data;
  }

  Platform toDomain(){
    return Platform(
        id : id ,
        name : name ,
        slug : slug ,
        image : image ,
        yearEnd : yearEnd ,
        yearStart : yearStart ,
        gamesCount : gamesCount ,
        imageBackground : imageBackground ,
    );
  }
}