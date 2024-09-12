import 'package:data/Models/Games/RAWG/YearsDTO.dart';

class FiltersDTO {
  List<YearsDTO>? years;

  FiltersDTO({this.years});

  FiltersDTO.fromJson(Map<String, dynamic> json) {
    if (json['years'] != null) {
      years = <YearsDTO>[];
      json['years'].forEach((v) {
        years!.add( YearsDTO.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (years != null) {
      data['years'] = years!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}