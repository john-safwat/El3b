
import 'package:image_picker/image_picker.dart';

abstract class FirebaseImagesRemoteDatasource {

  Future<String> uploadImage({required XFile file});
  Future<String> updateImage({required XFile file , required String url});

}
