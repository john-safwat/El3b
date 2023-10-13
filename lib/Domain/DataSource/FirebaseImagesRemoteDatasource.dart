
import 'package:image_picker/image_picker.dart';

abstract class FirebaseImagesRemoteDatasource {

  Future<String> uploadUserProfileImage({required XFile file});
  Future<String> updateUserProfileImage({required XFile file , required String name});

}
