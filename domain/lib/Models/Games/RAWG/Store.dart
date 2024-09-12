
import 'package:data/Models/Games/RAWG/StoreDTO.dart';
import 'package:data/Models/Games/RAWG/StoresDTO.dart';

class Store {
  num? gameID;
  num? id;
  String? name;
  String? slug;
  String? domain;
  num? gamesCount;
  String? imageBackground;

  Store(
      { this.gameID,
        this.id,
        this.name,
        this.slug,
        this.domain,
        this.gamesCount,
        this.imageBackground});


  StoreDTO toData(){
    return StoreDTO(
        id : id,
        name : name,
        slug : slug,
        domain : domain,
        gamesCount : gamesCount,
        imageBackground : imageBackground,
    );
  }

}