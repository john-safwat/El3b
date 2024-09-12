import 'package:data/Models/Games/GameDetails/platform_dto.dart';
import 'package:domain/Models/Games/GameDetails/MetacriticPlatforms.dart';

class MetacriticPlatformsDTO {
  num? metascore;
  String? url;
  PlatformDTO? platform;

  MetacriticPlatformsDTO({this.metascore, this.url, this.platform});

  MetacriticPlatformsDTO.fromJson(Map<String, dynamic> json) {
    metascore = json['metascore'];
    url = json['url'];
    platform = json['platform'] != null
        ?  PlatformDTO.fromJson(json['platform'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['metascore'] = metascore;
    data['url'] = url;
    if (platform != null) {
      data['platform'] = platform!.toJson();
    }
    return data;
  }

  MetacriticPlatforms toDomain(){
    return MetacriticPlatforms(
        metascore : metascore,
        url : url,
        platform : platform?.toDomain(),
    );
  }

}
