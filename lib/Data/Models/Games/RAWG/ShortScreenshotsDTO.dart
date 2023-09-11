
import 'package:El3b/Domain/Models/Games/RAWG/ShortScreenshots.dart';

class ShortScreenshotsDTO {
  num? id;
  String? image;

  ShortScreenshotsDTO({this.id, this.image});

  ShortScreenshotsDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    return data;
  }

  ShortScreenshots toDomain(){
    return ShortScreenshots(
      id: id,
      image: image
    );
  }

}