import 'package:El3b/Data/Models/Games/GameDetails/PlatformDetailsDTO.dart';
import 'package:El3b/Data/Models/Games/GameDetails/RequirementsDTO.dart';
import 'package:El3b/Domain/Models/Games/GameDetails/Platforms.dart';

class PlatformsDTO {
  PlatformDetailsDTO? platform;
  String? releasedAt;
  RequirementsDTO? requirements;

  PlatformsDTO({this.platform, this.releasedAt, this.requirements});

  PlatformsDTO.fromJson(Map<String, dynamic> json) {
    platform = json['platform'] != null
        ?  PlatformDetailsDTO.fromJson(json['platform'])
        : null;
    releasedAt = json['released_at'];
    requirements = json['requirements'] != null
        ?  RequirementsDTO.fromJson(json['requirements'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (platform != null) {
      data['platform'] = platform!.toJson();
    }
    data['released_at'] = releasedAt;
    if (requirements != null) {
      data['requirements'] = requirements!.toJson();
    }
    return data;
  }

  Platforms toDomain(){
    return Platforms(
        platform : platform?.toDomain(),
        releasedAt : releasedAt,
        requirements : requirements?.toDomain(),
    );
  }

}
