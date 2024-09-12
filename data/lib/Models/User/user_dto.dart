import 'package:domain/Models/User/MyUser.dart';

class UserDTO {

  String name ;
  String email ;
  String password ;
  String image;
  String phoneNumber;
  String birthDate ;
  String bio;

  UserDTO({
    required this.name,
    required this.email,
    required this.password,
    required this.image ,
    required this.phoneNumber,
    required this.bio ,
    required this.birthDate
  });

  UserDTO.fromFireStore(Map<String , dynamic> json):this(
      name : json["name"],
      email : json["email"],
      password : json["password"],
      image : json["image"],
      phoneNumber : json["phoneNumber"],
      bio : json["bio"],
      birthDate : json["birthDate"],
  );

  Map<String , dynamic> toFireStore(){
    return {
      "name" : name,
      "email" : email,
      "password" : password,
      "image" : image,
      "phoneNumber" : phoneNumber,
      "bio" : bio,
      "birthDate" : birthDate,
    };
  }

  MyUser toDomain(){
    return MyUser(
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