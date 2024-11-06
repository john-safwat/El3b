class FeedbackDTO {

  String uid;
  String message;
  double rating;
  String userName;
  String userEmail;
  String image;

  FeedbackDTO({
    required this.uid,
    required this.message,
    required this.rating,
    required this.userName,
    required this.userEmail,
    required this.image,
  });


  FeedbackDTO.fromFireStore(Map<String , dynamic> json):this(
      uid : json["uid"],
      message : json["message"],
      rating : json["rating"],
      userName : json["userName"],
      userEmail : json["userEmail"],
      image : json["image"],
  );

  Map<String , dynamic> toFireStore(){
    return {
      "uid" : uid,
      "message" : message,
      "rating" : rating,
      "userName" : userName,
      "userEmail" : userEmail,
      "image" : image,
    };
  }


}