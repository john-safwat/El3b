import 'package:El3b/Domain/Models/Games/GameDetails/Platform.dart';

class PlatformDTO {
  num? platform;
  String? name;
  String? slug;

  PlatformDTO({this.platform, this.name, this.slug});

  PlatformDTO.fromJson(Map<String, dynamic> json) {
    platform = json['platform'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['platform'] = platform;
    data['name'] = name;
    data['slug'] = slug;
    return data;
  }

  Platform toDomain(){
    return Platform(
        platform : platform,
        name : name,
        slug : slug,
    );
  }

}