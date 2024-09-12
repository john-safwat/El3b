
import 'package:data/Models/Games/RAWG/rawg_game_dto.dart';
import 'package:data/Models/Games/RAWG/rawg_games_response_dto.dart';
import 'package:data/Models/Games/RAWG/stores_dto.dart';
import 'package:domain/Models/Games/RAWG/Genres.dart';
import 'package:domain/Models/Games/RAWG/ShortScreenshots.dart';
import 'package:domain/Models/Games/RAWG/Store.dart';

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

  RAWGGameDTO toData() {
    return RAWGGameDTO(
        id : id,
        name : name,
        released : released,
        backgroundImage : backgroundImage,
        rating : rating,
        metacritic : metacritic,
        genres : genres?.map((e) => e.toData()).toList(),
        stores : stores?.map((e) => StoresDTO(store: e.toData())).toList(),
        shortScreenshots : shortScreenshots?.map((e) => e.toData()).toList(),
    );
  }

}
