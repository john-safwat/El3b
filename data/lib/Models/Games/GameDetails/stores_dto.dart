import 'package:data/Models/Games/GameDetails/store_dto.dart';
import 'package:domain/Models/Games/GameDetails/Stores.dart';

class StoresDTO {
  num? id;
  String? url;
  StoreDTO? store;

  StoresDTO({this.id, this.url, this.store});

  StoresDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    store = json['store'] != null ?  StoreDTO.fromJson(json['store']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    if (store != null) {
      data['store'] = store!.toJson();
    }
    return data;
  }

  Stores toDomain(){
    return Stores(
        id: id,
        url: url,
        store: store?.toDomain(),
    );
  }

}