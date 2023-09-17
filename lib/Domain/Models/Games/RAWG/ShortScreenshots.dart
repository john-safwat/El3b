
import 'package:El3b/Data/Models/Games/RAWG/ShortScreenshotsDTO.dart';

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