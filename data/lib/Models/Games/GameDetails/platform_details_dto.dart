
import 'package:domain/Models/Games/GameDetails/platform_details.dart';

class PlatformDetailsDTO {
  num? id;
  String? name;
  String? slug;
  String? image;
  String? yearEnd;
  String? yearStart;
  num? gamesCount;
  String? imageBackground;

  PlatformDetailsDTO(
      { this.id,
        this.name,
        this.slug,
        this.image,
        this.yearEnd,
        this.yearStart,
        this.gamesCount,
        this.imageBackground});

  PlatformDetailsDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    yearEnd = json['year_end'];
    yearStart = json['year_start'].toString();
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

  PlatformDetails toDomain(){
    return PlatformDetails(
        id : id,
        name : name,
        slug : slug,
        image : image,
        yearEnd : yearEnd,
        yearStart : yearStart,
        gamesCount : gamesCount,
        imageBackground : imageBackground,
    );
  }
}
