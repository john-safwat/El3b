import 'package:El3b/Data/Models/Feedback/FeedbackDTO.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


// dependency injection
FeedbackFirebaseDatabase injectFeedbackFirebaseDatabase(){
  return FeedbackFirebaseDatabase.getInstance();
}

class FeedbackFirebaseDatabase {

  // singleton pattern
  FeedbackFirebaseDatabase._();
  static FeedbackFirebaseDatabase? _instance;
  static FeedbackFirebaseDatabase getInstance(){
    return _instance?? FeedbackFirebaseDatabase._();
  }
  
  // get collection Feedback collection references
  CollectionReference<FeedbackDTO> getCollectionReference(){
    return FirebaseFirestore.instance.collection("Feedback").withConverter(
        fromFirestore: (snapshot, options) => FeedbackDTO.fromFireStore(snapshot.data()!),
        toFirestore: (value, options) => value.toFireStore(),
    );
  }

  // function to send feedback to database
  Future<String> addFeedback({required FeedbackDTO feedback})async{
    await getCollectionReference().doc().set(feedback);
    return "Feedback Sent";
  }

}