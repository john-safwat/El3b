
import 'package:domain/Models/Developers/Positions.dart';

class PositionsDTO {
  PositionsDTO({
      this.id, 
      this.name, 
      this.slug,});

  PositionsDTO.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }
  num? id;
  String? name;
  String? slug;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    return map;
  }

  Positions toDomain(){
    return Positions(
        id : id,
        name : name,
        slug : slug,
    );
  }

}