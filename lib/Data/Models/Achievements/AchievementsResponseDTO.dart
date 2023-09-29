import 'package:El3b/Data/Models/Achievements/AchievementDTO.dart';

class AchievementsResponseDTO {
  AchievementsResponseDTO({
      this.count, 
      this.next, 
      this.previous, 
      this.results,});

  AchievementsResponseDTO.fromJson(dynamic json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(AchievementDTO.fromJson(v));
      });
    }
  }
  num? count;
  String? next;
  dynamic previous;
  List<AchievementDTO>? results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['next'] = next;
    map['previous'] = previous;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}