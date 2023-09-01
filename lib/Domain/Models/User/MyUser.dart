import 'package:El3b/Data/Models/User/UserDTO.dart';

class MyUser {

  String name ;
  String email ;
  String password ;
  String image;
  String phoneNumber;
  DateTime birthDate ;
  String bio;

  MyUser({
    required this.name,
    required this.email,
    required this.password,
    required this.image ,
    required this.phoneNumber,
    required this.bio ,
    required this.birthDate
  });

  UserDTO toDataSource(){
    return UserDTO(
        name: name,
        email: email,
        password: password,
        image: image,
        phoneNumber: phoneNumber,
        bio: bio,
        birthDate: birthDate
    );
  }
}