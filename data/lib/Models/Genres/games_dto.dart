class GamesDTO {
  GamesDTO({
      this.id, 
      this.slug, 
      this.name, 
      this.added,});

  GamesDTO.fromJson(dynamic json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
    added = json['added'];
  }
  num? id;
  String? slug;
  String? name;
  num? added;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['slug'] = slug;
    map['name'] = name;
    map['added'] = added;
    return map;
  }

}