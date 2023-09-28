import 'Positions.dart';

class Developers {
  Developers({
      this.id, 
      this.name, 
      this.slug, 
      this.image, 
      this.imageBackground, 
      this.gamesCount,
      this.positions,});

  num? id;
  String? name;
  String? slug;
  String? image;
  String? imageBackground;
  num? gamesCount;
  List<Positions>? positions;

}