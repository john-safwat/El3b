import 'package:El3b/Data/Models/Games/RAWG/PlatformDTO.dart';


class ParentPlatformsDTO {
  PlatformDTO? platform;

  ParentPlatformsDTO({this.platform});

  ParentPlatformsDTO.fromJson(Map<String, dynamic> json) {
    platform = json['platform'] != null
        ?  PlatformDTO.fromJson(json['platform'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (platform != null) {
      data['platform'] = platform!.toJson();
    }
    return data;
  }

}