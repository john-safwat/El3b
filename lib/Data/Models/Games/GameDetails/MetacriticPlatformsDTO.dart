import 'package:El3b/Data/Models/Games/GameDetails/PlatformDTO.dart';
import 'package:El3b/Domain/Models/Games/GameDetails/MetacriticPlatforms.dart';

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
