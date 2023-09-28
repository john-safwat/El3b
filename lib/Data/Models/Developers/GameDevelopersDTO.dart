import 'DevelopersDTO.dart';

class GameDevelopersDTO {
  GameDevelopersDTO({
      this.count, 
      this.next, 
      this.previous, 
      this.developers,});

  GameDevelopersDTO.fromJson(dynamic json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      developers = [];
      json['results'].forEach((v) {
        developers?.add(DevelopersDTO.fromJson(v));
      });
    }
  }
  num? count;
  dynamic next;
  dynamic previous;
  List<DevelopersDTO>? developers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['next'] = next;
    map['previous'] = previous;
    if (developers != null) {
      map['results'] = developers?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}