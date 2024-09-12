import 'package:data/Models/Feedback/feedback_dto.dart';

class Feedback {

  String uid;
  String message;
  double rating;
  String userName;
  String userEmail;
  String image;

  Feedback({
    required this.uid,
    required this.message,
    required this.rating,
    required this.userName,
    required this.userEmail,
    required this.image,
  });

  FeedbackDTO toDatasource(){
    return FeedbackDTO(
      uid: uid,
      message: message,
      rating: rating,
      userName: userName,
      userEmail: userEmail,
      image: image
    );
  }

}