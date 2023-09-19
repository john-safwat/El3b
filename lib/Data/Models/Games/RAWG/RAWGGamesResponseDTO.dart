import 'package:El3b/Data/Models/Games/RAWG/FiltersDTO.dart';
import 'package:El3b/Data/Models/Games/RAWG/RAWGGameDTO.dart';

class RAWGGamesResponseDTO {
  num? count;
  String? next;
  String? previous;
  List<RAWGGameDTO>? results;
  String? seoTitle;
  String? seoDescription;
  String? seoKeywords;
  String? seoH1;
  bool? noindex;
  bool? nofollow;
  String? description;
  FiltersDTO? filters;
  List<String>? nofollowCollections;

  RAWGGamesResponseDTO(
      { this.count,
        this.next,
        this.previous,
        this.results,
        this.seoTitle,
        this.seoDescription,
        this.seoKeywords,
        this.seoH1,
        this.noindex,
        this.nofollow,
        this.description,
        this.filters,
        this.nofollowCollections});

  RAWGGamesResponseDTO.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <RAWGGameDTO>[];
      json['results'].forEach((v) {
        results!.add(RAWGGameDTO.fromJson(v));
      });
    }
    seoTitle = json['seo_title'];
    seoDescription = json['seo_description'];
    seoKeywords = json['seo_keywords'];
    seoH1 = json['seo_h1'];
    noindex = json['noindex'];
    nofollow = json['nofollow'];
    description = json['description'];
    filters =
    json['filters'] != null ?  FiltersDTO.fromJson(json['filters']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['seo_title'] = seoTitle;
    data['seo_description'] = seoDescription;
    data['seo_keywords'] = seoKeywords;
    data['seo_h1'] = seoH1;
    data['noindex'] = noindex;
    data['nofollow'] = nofollow;
    data['description'] = description;
    if (filters != null) {
      data['filters'] = filters!.toJson();
    }
    data['nofollow_collections'] = nofollowCollections;
    return data;
  }
}




















