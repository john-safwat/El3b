import 'package:El3b/Data/Models/Games/RAWG/PlatformDTO.dart';
import 'package:El3b/Data/Models/Games/RAWG/RequirementsEnDTO.dart';
import 'package:El3b/Domain/Models/Games/RAWG/Platforms.dart';

class PlatformsDTO {
  PlatformDTO? platform;
  String? releasedAt;
  RequirementsEnDTO? requirementsEn;
  RequirementsEnDTO? requirementsRu;

  PlatformsDTO(
      { this.platform,
        this.releasedAt,
        this.requirementsEn,
        this.requirementsRu});

  PlatformsDTO.fromJson(Map<String, dynamic> json) {
    platform = json['platform'] != null
        ?  PlatformDTO.fromJson(json['platform'])
        : null;
    releasedAt = json['released_at'];
    requirementsEn = json['requirements_en'] != null
        ?  RequirementsEnDTO.fromJson(json['requirements_en'])
        : null;
    requirementsRu = json['requirements_ru'] != null
        ?  RequirementsEnDTO.fromJson(json['requirements_ru'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (platform != null) {
      data['platform'] = platform!.toJson();
    }
    data['released_at'] = releasedAt;
    if (requirementsEn != null) {
      data['requirements_en'] = requirementsEn!.toJson();
    }
    if (requirementsRu != null) {
      data['requirements_ru'] = requirementsRu!.toJson();
    }
    return data;
  }

  Platforms toDomain(){
    return Platforms(
        platform : platform?.toDomain(),
        releasedAt : releasedAt,
        requirementsEn : requirementsEn?.toDomain(),
        requirementsRu : requirementsRu?.toDomain(),
    );
  }

}
