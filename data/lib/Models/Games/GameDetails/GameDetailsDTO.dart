
import 'package:data/Models/Games/GameDetails/DevelopersDTO.dart';
import 'package:data/Models/Games/GameDetails/GenresDTO.dart';
import 'package:data/Models/Games/GameDetails/MetacriticPlatformsDTO.dart';
import 'package:data/Models/Games/GameDetails/PlatformDTO.dart';
import 'package:data/Models/Games/GameDetails/PlatformsDTO.dart';
import 'package:data/Models/Games/GameDetails/RatingsDTO.dart';
import 'package:data/Models/Games/GameDetails/StoresDTO.dart';
import 'package:data/Models/Games/GameDetails/TagsDTO.dart';
import 'package:domain/Models/Games/GameDetails/GameDetails.dart';

class GameDetailsDTO {
  num? id;
  String? slug;
  String? name;
  String? nameOriginal;
  String? description;
  num? metacritic;
  List<MetacriticPlatformsDTO>? metacriticPlatforms;
  String? released;
  String? backgroundImage;
  String? backgroundImageAdditional;
  String? website;
  num? rating;
  num? ratingTop;
  List<RatingsDTO>? ratings;
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
  List<PlatformsDTO>? platforms;
  List<StoresDTO>? stores;
  List<DevelopersDTO>? developers;
  List<GenresDTO>? genres;
  List<TagsDTO>? tags;
  PlatformDTO? esrbRating;
  String? descriptionRaw;

  GameDetailsDTO(
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

  GameDetailsDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
    nameOriginal = json['name_original'];
    description = json['description'];
    metacritic = json['metacritic'];
    if (json['metacritic_platforms'] != null) {
      metacriticPlatforms = <MetacriticPlatformsDTO>[];
      json['metacritic_platforms'].forEach((v) {
        metacriticPlatforms!.add( MetacriticPlatformsDTO.fromJson(v));
      });
    }
    released = json['released'];
    backgroundImage = json['background_image'];
    backgroundImageAdditional = json['background_image_additional'];
    website = json['website'];
    rating = json['rating'];
    ratingTop = json['rating_top'];
    if (json['ratings'] != null) {
      ratings = <RatingsDTO>[];
      json['ratings'].forEach((v) {
        ratings!.add( RatingsDTO.fromJson(v));
      });
    }
    playtime = json['playtime'];
    screenshotsCount = json['screenshots_count'];
    moviesCount = json['movies_count'];
    creatorsCount = json['creators_count'];
    achievementsCount = json['achievements_count'];
    parentAchievementsCount = json['parent_achievements_count'];
    redditUrl = json['reddit_url'];
    redditName = json['reddit_name'];
    redditDescription = json['reddit_description'];
    redditLogo = json['reddit_logo'];
    redditCount = json['reddit_count'];
    twitchCount = json['twitch_count'];
    youtubeCount = json['youtube_count'];
    reviewsTextCount = json['reviews_text_count'];
    ratingsCount = json['ratings_count'];
    suggestionsCount = json['suggestions_count'];
    alternativeNames = json['alternative_names'].cast<String>();
    metacriticUrl = json['metacritic_url'];
    parentsCount = json['parents_count'];
    additionsCount = json['additions_count'];
    gameSeriesCount = json['game_series_count'];
    reviewsCount = json['reviews_count'];
    saturatedColor = json['saturated_color'];
    dominantColor = json['dominant_color'];
    if (json['platforms'] != null) {
      platforms = <PlatformsDTO>[];
      json['platforms'].forEach((v) {
        platforms!.add( PlatformsDTO.fromJson(v));
      });
    }
    if (json['stores'] != null) {
      stores = <StoresDTO>[];
      json['stores'].forEach((v) {
        stores!.add( StoresDTO.fromJson(v));
      });
    }
    if (json['developers'] != null) {
      developers = <DevelopersDTO>[];
      json['developers'].forEach((v) {
        developers!.add( DevelopersDTO.fromJson(v));
      });
    }
    if (json['genres'] != null) {
      genres = <GenresDTO>[];
      json['genres'].forEach((v) {
        genres!.add( GenresDTO.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = <TagsDTO>[];
      json['tags'].forEach((v) {
        tags!.add( TagsDTO.fromJson(v));
      });
    }
    esrbRating = json['esrb_rating'] != null
        ?  PlatformDTO.fromJson(json['esrb_rating'])
        : null;
    descriptionRaw = json['description_raw'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    data['name'] = name;
    data['name_original'] = nameOriginal;
    data['description'] = description;
    data['metacritic'] = metacritic;
    if (metacriticPlatforms != null) {
      data['metacritic_platforms'] =
          metacriticPlatforms!.map((v) => v.toJson()).toList();
    }
    data['released'] = released;
    data['background_image'] = backgroundImage;
    data['background_image_additional'] = backgroundImageAdditional;
    data['website'] = website;
    data['rating'] = rating;
    data['rating_top'] = ratingTop;
    if (ratings != null) {
      data['ratings'] = ratings!.map((v) => v.toJson()).toList();
    }
    data['playtime'] = playtime;
    data['screenshots_count'] = screenshotsCount;
    data['movies_count'] = moviesCount;
    data['creators_count'] = creatorsCount;
    data['achievements_count'] = achievementsCount;
    data['parent_achievements_count'] = parentAchievementsCount;
    data['reddit_url'] = redditUrl;
    data['reddit_name'] = redditName;
    data['reddit_description'] = redditDescription;
    data['reddit_logo'] = redditLogo;
    data['reddit_count'] = redditCount;
    data['twitch_count'] = twitchCount;
    data['youtube_count'] = youtubeCount;
    data['reviews_text_count'] = reviewsTextCount;
    data['ratings_count'] = ratingsCount;
    data['suggestions_count'] = suggestionsCount;
    data['alternative_names'] = alternativeNames;
    data['metacritic_url'] = metacriticUrl;
    data['parents_count'] = parentsCount;
    data['additions_count'] = additionsCount;
    data['game_series_count'] = gameSeriesCount;
    data['reviews_count'] = reviewsCount;
    data['saturated_color'] = saturatedColor;
    data['dominant_color'] = dominantColor;
    if (platforms != null) {
      data['platforms'] = platforms!.map((v) => v.toJson()).toList();
    }
    if (stores != null) {
      data['stores'] = stores!.map((v) => v.toJson()).toList();
    }
    if (developers != null) {
      data['developers'] = developers!.map((v) => v.toJson()).toList();
    }
    if (genres != null) {
      data['genres'] = genres!.map((v) => v.toJson()).toList();
    }
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    if (esrbRating != null) {
      data['esrb_rating'] = esrbRating!.toJson();
    }
    data['description_raw'] = descriptionRaw;
    return data;
  }


  GameDetails toDomain(){
    return GameDetails(
        id : id,
        slug : slug,
        name : name,
        nameOriginal : nameOriginal,
        description : description,
        metacritic : metacritic,
        metacriticPlatforms : metacriticPlatforms?.map((e) => e.toDomain()).toList(),
        released : released,
        backgroundImage : backgroundImage,
        backgroundImageAdditional : backgroundImageAdditional,
        website : website,
        rating : rating,
        ratingTop : ratingTop,
        ratings : ratings?.map((e) => e.toDomain()).toList(),
        playtime : playtime,
        screenshotsCount : screenshotsCount,
        moviesCount : moviesCount,
        creatorsCount : creatorsCount,
        achievementsCount : achievementsCount,
        parentAchievementsCount : parentAchievementsCount,
        redditUrl : redditUrl,
        redditName : redditName,
        redditDescription : redditDescription,
        redditLogo : redditLogo,
        redditCount : redditCount,
        twitchCount : twitchCount,
        youtubeCount : youtubeCount,
        reviewsTextCount : reviewsTextCount,
        ratingsCount : ratingsCount,
        suggestionsCount : suggestionsCount,
        alternativeNames : alternativeNames,
        metacriticUrl : metacriticUrl,
        parentsCount : parentsCount,
        additionsCount : additionsCount,
        gameSeriesCount : gameSeriesCount,
        reviewsCount : reviewsCount,
        saturatedColor : saturatedColor,
        dominantColor : dominantColor,
        platforms : platforms?.map((e) => e.toDomain()).toList(),
        stores : stores?.map((e) => e.toDomain()).toList(),
        developers : developers?.map((e) => e.toDomain()).toList(),
        genres : genres?.map((e) => e.toDomain()).toList(),
        tags : tags?.map((e) => e.toDomain()).toList(),
        esrbRating : esrbRating?.toDomain(),
        descriptionRaw : descriptionRaw,
    );
  }

}
