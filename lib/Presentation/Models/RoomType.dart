import 'package:flutter/cupertino.dart';
import 'package:icons_plus/icons_plus.dart';

class RoomType {
  IconData icon;
  String title;
  
  RoomType({required this.icon , required this.title});
  
  static List<RoomType> getTypesList (){
    return [
      RoomType(icon: EvaIcons.people_outline, title: "Public"),
      RoomType(icon: EvaIcons.lock_outline, title: "Private"),
    ];
  }

  static RoomType getRoomType(String id){
    var types = getTypesList();
    switch (id){
      case "Public":
        return types[0];
      case "Private":
        return types[1];
      default:
        return RoomType(icon: EvaIcons.people_outline, title: "Public") ;
    }
  }
}