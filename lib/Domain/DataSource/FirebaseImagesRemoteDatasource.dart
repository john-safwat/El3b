import 'package:flutter_image_compress/flutter_image_compress.dart';

abstract class FirebaseImagesRemoteDatasource {

  Future<String> uploadUserProfileImage({required XFile file});

}
