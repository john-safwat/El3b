import 'package:El3b/Data/Models/Games/RAWG/StoreDTO.dart';
import 'package:El3b/Domain/Models/Games/RAWG/Stores.dart';

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

  Stores toDomain(){
    return Stores(
      id: id ,
      store: store?.toDomain()
    );
  }
}