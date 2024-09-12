

import 'package:domain/Models/Games/GameDetails/developers.dart';
import 'package:domain/Models/Games/GameDetails/genres.dart';
import 'package:domain/Models/Games/GameDetails/metacritic_platforms.dart';
import 'package:domain/Models/Games/GameDetails/platform.dart';
import 'package:domain/Models/Games/GameDetails/platforms.dart';
import 'package:domain/Models/Games/GameDetails/ratings.dart';
import 'package:domain/Models/Games/GameDetails/stores.dart';
import 'package:domain/Models/Games/GameDetails/tags.dart';

class GameDetails {
  num? id;
  String? slug;
  String? name;
  String? nameOriginal;
  String? description;
  num? metacritic;
  List<MetacriticPlatforms>? metacriticPlatforms;
  String? released;
  String? backgroundImage;
  String? backgroundImageAdditional;
  String? website;
  num? rating;
  num? ratingTop;
  List<Ratings>? ratings;
  num? playtime;
  num? screenshotsCount;
  num? moviesCount;
  num? creatorsCount;
  num? achievementsCount;
  num? parentAchievementsCount;
  String? redditUrl;
  String? redditName;
  String? redditDescription;
  String? redditLogo;
  num? redditCount;
  num? twitchCount;
  num? youtubeCount;
  num? reviewsTextCount;
  num? ratingsCount;
  num? suggestionsCount;
  List<String>? alternativeNames;
  String? metacriticUrl;
  num? parentsCount;
  num? additionsCount;
  num? gameSeriesCount;
  num? reviewsCount;
  String? saturatedColor;
  String? dominantColor;
  List<Platforms>? platforms;
  List<Stores>? stores;
  List<Developers>? developers;
  List<Genres>? genres;
  List<Tags>? tags;
  Platform? esrbRating;
  String? descriptionRaw;

  GameDetails(
      { this.id,
        this.slug,
        this.name,
        this.nameOriginal,
        this.description,
        this.metacritic,
        this.metacriticPlatforms,
        this.released,
        this.backgroundImage,
        this.backgroundImageAdditional,
        this.website,
        this.rating,
        this.ratingTop,
        this.ratings,
        this.playtime,
        this.screenshotsCount,
        this.moviesCount,
        this.creatorsCount,
        this.achievementsCount,
        this.parentAchievementsCount,
        this.redditUrl,
        this.redditName,
        this.redditDescription,
        this.redditLogo,
        this.redditCount,
        this.twitchCount,
        this.youtubeCount,
        this.reviewsTextCount,
        this.ratingsCount,
        this.suggestionsCount,
        this.alternativeNames,
        this.metacriticUrl,
        this.parentsCount,
        this.additionsCount,
        this.gameSeriesCount,
        this.reviewsCount,
        this.saturatedColor,
        this.dominantColor,
        this.platforms,
        this.stores,
        this.developers,
        this.genres,
        this.tags,
        this.esrbRating,
        this.descriptionRaw});

}
