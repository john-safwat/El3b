import 'positions.dart';

class Developer {
  Developer({
      this.id, 
      this.name, 
      this.slug, 
      this.image, 
      this.imageBackground, 
      this.gamesCount,
      this.positions,
      this.description
  });

  num? id;
  String? name;
  String? slug;
  String? image;
  String? imageBackground;
  num? gamesCount;
  List<Positions>? positions;
  String? description;

}