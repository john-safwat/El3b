
import 'package:data/Models/Games/RAWG/short_screenshots_dto.dart';

class ShortScreenshots {
  num? gameID;
  num? id;
  String? image;

  ShortScreenshots({this.gameID , this.id, this.image});

  ShortScreenshotsDTO toData(){
    return ShortScreenshotsDTO(
        id : id,
        image : image,
    );
  }
}