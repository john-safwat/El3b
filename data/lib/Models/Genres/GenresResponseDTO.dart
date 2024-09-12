import 'GenreDTO.dart';

class GenresResponseDTO {
  GenresResponseDTO({
      this.count, 
      this.next, 
      this.previous, 
      this.results,});

  GenresResponseDTO.fromJson(dynamic json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(GenreDTO.fromJson(v));
      });
    }
  }
  num? count;
  dynamic next;
  dynamic previous;
  List<GenreDTO>? results;

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