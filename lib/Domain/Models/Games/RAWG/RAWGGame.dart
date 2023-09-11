import 'package:El3b/Domain/Models/Games/RAWG/AddedByStatus.dart';
import 'package:El3b/Domain/Models/Games/RAWG/Genres.dart';
import 'package:El3b/Domain/Models/Games/RAWG/ParentPlatforms.dart';
import 'package:El3b/Domain/Models/Games/RAWG/Platform.dart';
import 'package:El3b/Domain/Models/Games/RAWG/Platforms.dart';
import 'package:El3b/Domain/Models/Games/RAWG/Ratings.dart';
import 'package:El3b/Domain/Models/Games/RAWG/ShortScreenshots.dart';
import 'package:El3b/Domain/Models/Games/RAWG/Stores.dart';
import 'package:El3b/Domain/Models/Games/RAWG/Tags.dart';

class RAWGGame {
  num? id;
  String? slug;
  String? name;
  String? released;
  bool? tba;
  String? backgroundImage;
  num? rating;
  num? ratingTop;
  List<Ratings>? ratings;
  num? ratingsCount;
  num? reviewsTextCount;
  num? added;
  AddedByStatus? addedByStatus;
  num? metacritic;
  num? playtime;
  num? suggestionsCount;
  String? updated;
  String? userGame;
  num? reviewsCount;
  String? saturatedColor;
  String? dominantColor;
  List<Platforms>? platforms;
  List<ParentPlatforms>? parentPlatforms;
  List<Genres>? genres;
  List<Stores>? stores;
  String? clip;
  List<Tags>? tags;
  Platform? esrbRating;
  List<ShortScreenshots>? shortScreenshots;

  RAWGGame(
      { this.id,
        this.slug,
        this.name,
        this.released,
        this.tba,
        this.backgroundImage,
        this.rating,
        this.ratingTop,
        this.ratings,
        this.ratingsCount,
        this.reviewsTextCount,
        this.added,
        this.addedByStatus,
        this.metacritic,
        this.playtime,
        this.suggestionsCount,
        this.updated,
        this.userGame,
        this.reviewsCount,
        this.saturatedColor,
        this.dominantColor,
        this.platforms,
        this.parentPlatforms,
        this.genres,
        this.stores,
        this.clip,
        this.tags,
        this.esrbRating,
        this.shortScreenshots});

}
