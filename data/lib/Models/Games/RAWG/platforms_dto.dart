import 'package:data/Models/Games/RAWG/platform_dto.dart';
import 'package:data/Models/Games/RAWG/requirements_en_dto.dart';

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


}
