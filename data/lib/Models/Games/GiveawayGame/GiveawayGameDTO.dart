import 'package:domain/Models/Games/GiveawayGames/GiveawayGame.dart';

class GiveawayGameDTO {
  GiveawayGameDTO({
      this.id, 
      this.title, 
      this.worth, 
      this.thumbnail, 
      this.image, 
      this.description, 
      this.instructions, 
      this.openGiveawayUrl, 
      this.publishedDate, 
      this.type, 
      this.platforms, 
      this.endDate, 
      this.users, 
      this.status, 
      this.gamerpowerUrl,
      this.openGiveaway,});

  GiveawayGameDTO.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    worth = json['worth'];
    thumbnail = json['thumbnail'];
    image = json['image'];
    description = json['description'];
    instructions = json['instructions'];
    openGiveawayUrl = json['open_giveaway_url'];
    publishedDate = json['published_date'];
    type = json['type'];
    platforms = json['platforms'];
    endDate = json['end_date'];
    users = json['users'];
    status = json['status'];
    gamerpowerUrl = json['gamerpower_url'];
    openGiveaway = json['open_giveaway'];
  }
  num? id;
  String? title;
  String? worth;
  String? thumbnail;
  String? image;
  String? description;
  String? instructions;
  String? openGiveawayUrl;
  String? publishedDate;
  String? type;
  String? platforms;
  String? endDate;
  num? users;
  String? status;
  String? gamerpowerUrl;
  String? openGiveaway;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['worth'] = worth;
    map['thumbnail'] = thumbnail;
    map['image'] = image;
    map['description'] = description;
    map['instructions'] = instructions;
    map['open_giveaway_url'] = openGiveawayUrl;
    map['published_date'] = publishedDate;
    map['type'] = type;
    map['platforms'] = platforms;
    map['end_date'] = endDate;
    map['users'] = users;
    map['status'] = status;
    map['gamerpower_url'] = gamerpowerUrl;
    map['open_giveaway'] = openGiveaway;
    return map;
  }

  GiveawayGame toDomain(){
    return GiveawayGame(
        title : title ,
        worth : worth ,
        image : image ,
        instructions : instructions ,
        openGiveawayUrl : openGiveawayUrl ,
        platforms : platforms ,
        endDate : endDate ,
    );
  }

}