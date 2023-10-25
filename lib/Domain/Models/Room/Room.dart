import 'package:El3b/Data/Models/Room/RoomDTO.dart';

class Room {
  String id;
  String name;
  String description;
  String type;
  String ownerId;
  List<String> users;
  int dateTime;

  Room({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.ownerId,
    required this.users,
    required this.dateTime
  });

  RoomDTO toDataSource() {
    return RoomDTO(
        id: id,
        name: name,
        description: description,
        type: type,
        ownerId:ownerId,
        users: users,
        dateTime: dateTime
    );
  }
}