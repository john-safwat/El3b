import 'package:data/Models/Games/RAWG/StoreDTO.dart';

class StoresDTO {
  num? id;
  StoreDTO? store;

  StoresDTO({this.id, this.store});

  StoresDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    store = json['store'] != null ?  StoreDTO.fromJson(json['store']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    if (store != null) {
      data['store'] = store!.toJson();
    }
    return data;
  }

}