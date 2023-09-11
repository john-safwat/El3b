import 'package:El3b/Data/Models/Games/RAWG/AddedByStatusDTO.dart';
import 'package:El3b/Data/Models/Games/RAWG/GenresDTO.dart';
import 'package:El3b/Data/Models/Games/RAWG/ParentPlatformsDTO.dart';
import 'package:El3b/Data/Models/Games/RAWG/PlatformDTO.dart';
import 'package:El3b/Data/Models/Games/RAWG/PlatformsDTO.dart';
import 'package:El3b/Data/Models/Games/RAWG/RatingsDTO.dart';
import 'package:El3b/Data/Models/Games/RAWG/ShortScreenshotsDTO.dart';
import 'package:El3b/Data/Models/Games/RAWG/StoresDTO.dart';
import 'package:El3b/Data/Models/Games/RAWG/TagsDTO.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';

class RAWGGameDTO {
  num? id;
  String? slug;
  String? name;
  String? released;
  bool? tba;
  String? backgroundImage;
  num? rating;
  num? ratingTop;
  List<RatingsDTO>? ratings;
  num? ratingsCount;
  num? reviewsTextCount;
  num? added;
  AddedByStatusDTO? addedByStatus;
  num? metacritic;
  num? playtime;
  num? suggestionsCount;
  String? updated;
  String? userGame;
  num? reviewsCount;
  String? saturatedColor;
  String? dominantColor;
  List<PlatformsDTO>? platforms;
  List<ParentPlatformsDTO>? parentPlatforms;
  List<GenresDTO>? genres;
  List<StoresDTO>? stores;
  String? clip;
  List<TagsDTO>? tags;
  PlatformDTO? esrbRating;
  List<ShortScreenshotsDTO>? shortScreenshots;

  RAWGGameDTO(
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

  RAWGGameDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
    released = json['released'];
    tba = json['tba'];
    backgroundImage = json['background_image'];
    rating = json['rating'];
    ratingTop = json['rating_top'];
    if (json['ratings'] != null) {
      ratings = <RatingsDTO>[];
      json['ratings'].forEach((v) {
        ratings!.add( RatingsDTO.fromJson(v));
      });
    }
    ratingsCount = json['ratings_count'];
    reviewsTextCount = json['reviews_text_count'];
    added = json['added'];
    addedByStatus = json['added_by_status'] != null
        ?  AddedByStatusDTO.fromJson(json['added_by_status'])
        : null;
    metacritic = json['metacritic'];
    playtime = json['playtime'];
    suggestionsCount = json['suggestions_count'];
    updated = json['updated'];
    userGame = json['user_game'];
    reviewsCount = json['reviews_count'];
    saturatedColor = json['saturated_color'];
    dominantColor = json['dominant_color'];
    if (json['platforms'] != null) {
      platforms = <PlatformsDTO>[];
      json['platforms'].forEach((v) {
        platforms!.add( PlatformsDTO.fromJson(v));
      });
    }
    if (json['parent_platforms'] != null) {
      parentPlatforms = <ParentPlatformsDTO>[];
      json['parent_platforms'].forEach((v) {
        parentPlatforms!.add( ParentPlatformsDTO.fromJson(v));
      });
    }
    if (json['genres'] != null) {
      genres = <GenresDTO>[];
      json['genres'].forEach((v) {
        genres!.add( GenresDTO.fromJson(v));
      });
    }
    if (json['stores'] != null) {
      stores = <StoresDTO>[];
      json['stores'].forEach((v) {
        stores!.add( StoresDTO.fromJson(v));
      });
    }
    clip = json['clip'];
    if (json['tags'] != null) {
      tags = <TagsDTO>[];
      json['tags'].forEach((v) {
        tags!.add( TagsDTO.fromJson(v));
      });
    }
    esrbRating = json['esrb_rating'] != null
        ?  PlatformDTO.fromJson(json['esrb_rating'])
        : null;
    if (json['short_screenshots'] != null) {
      shortScreenshots = <ShortScreenshotsDTO>[];
      json['short_screenshots'].forEach((v) {
        shortScreenshots!.add( ShortScreenshotsDTO.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    data['name'] = name;
    data['released'] = released;
    data['tba'] = tba;
    data['background_image'] = backgroundImage;
    data['rating'] = rating;
    data['rating_top'] = ratingTop;
    if (ratings != null) {
      data['ratings'] = ratings!.map((v) => v.toJson()).toList();
    }
    data['ratings_count'] = ratingsCount;
    data['reviews_text_count'] = reviewsTextCount;
    data['added'] = added;
    if (addedByStatus != null) {
      data['added_by_status'] = addedByStatus!.toJson();
    }
    data['metacritic'] = metacritic;
    data['playtime'] = playtime;
    data['suggestions_count'] = suggestionsCount;
    data['updated'] = updated;
    data['user_game'] = userGame;
    data['reviews_count'] = reviewsCount;
    data['saturated_color'] = saturatedColor;
    data['dominant_color'] = dominantColor;
    if (platforms != null) {
      data['platforms'] = platforms!.map((v) => v.toJson()).toList();
    }
    if (parentPlatforms != null) {
      data['parent_platforms'] =
          parentPlatforms!.map((v) => v.toJson()).toList();
    }
    if (genres != null) {
      data['genres'] = genres!.map((v) => v.toJson()).toList();
    }
    if (stores != null) {
      data['stores'] = stores!.map((v) => v.toJson()).toList();
    }
    data['clip'] = clip;
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    if (esrbRating != null) {
      data['esrb_rating'] = esrbRating!.toJson();
    }
    if (shortScreenshots != null) {
      data['short_screenshots'] =
          shortScreenshots!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  RAWGGame toDomain(){
    return RAWGGame(
        id : id ,
        slug : slug ,
        name : name ,
        released : released ,
        tba : tba ,
        backgroundImage : backgroundImage ,
        rating : rating ,
        ratingTop : ratingTop ,
        ratings : ratings?.map((e) => e.toDomain()).toList() ,
        ratingsCount : ratingsCount ,
        reviewsTextCount : reviewsTextCount ,
        added : added ,
        addedByStatus : addedByStatus?.toDomain() ,
        metacritic : metacritic ,
        playtime : playtime ,
        suggestionsCount : suggestionsCount ,
        updated : updated ,
        userGame : userGame ,
        reviewsCount : reviewsCount ,
        saturatedColor : saturatedColor ,
        dominantColor : dominantColor ,
        platforms : platforms?.map((e) => e.toDomain()).toList() ,
        parentPlatforms : parentPlatforms?.map((e) => e.toDomain()).toList() ,
        genres : genres?.map((e) => e.toDomain()).toList() ,
        stores : stores?.map((e) => e.toDomain()).toList() ,
        clip : clip ,
        tags : tags?.map((e) => e.toDomain()).toList() ,
        esrbRating : esrbRating?.toDomain() ,
        shortScreenshots : shortScreenshots?.map((e) => e.toDomain()).toList(),
    );
  }

}
