import 'package:El3b/Domain/Models/Achievements/Achievement.dart';

class AchievementDTO {
  AchievementDTO({
    this.id,
    this.name,
    this.description,
    this.image,
    this.percent,});

  AchievementDTO.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    percent = json['percent'];
  }
  num? id;
  String? name;
  String? description;
  String? image;
  String? percent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['image'] = image;
    map['percent'] = percent;
    return map;
  }


  Achievement toDomain(){
    return Achievement(
      id : id,
      name : name,
      description : description,
      image : image,
      percent : percent,
    );
  }

}