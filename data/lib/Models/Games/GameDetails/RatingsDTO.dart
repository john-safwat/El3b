
import 'package:domain/Models/Games/GameDetails/Ratings.dart';

class RatingsDTO {
  num? id;
  String? title;
  num? count;
  num? percent;

  RatingsDTO({this.id, this.title, this.count, this.percent});

  RatingsDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    count = json['count'];
    percent = json['percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['count'] = count;
    data['percent'] = percent;
    return data;
  }

  Ratings toDomain(){
    return Ratings(
        id : id,
        title : title,
        count : count,
        percent : percent,
    );
  }

}
