
import 'package:El3b/Domain/Models/Games/RAWG/Genres.dart';
import 'package:El3b/Domain/Models/Games/RAWG/ShortScreenshots.dart';
import 'package:El3b/Domain/Models/Games/RAWG/Store.dart';

class RAWGGame {
  num? id;
  String? name;
  String? released;
  String? backgroundImage;
  num? rating;
  num? metacritic;
  List<Genres>? genres;
  List<Store>? stores;
  List<ShortScreenshots>? shortScreenshots;
  bool? inWishList = false;
  List<String> icons = [];

  RAWGGame(
      { this.id,
        this.name,
        this.released,
        this.backgroundImage,
        this.rating,
        this.metacritic,
        this.genres,
        this.stores,
        this.shortScreenshots});

}
