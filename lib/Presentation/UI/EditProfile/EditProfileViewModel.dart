import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Presentation/UI/EditProfile/EditProfileNavigator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileViewModel extends BaseViewModel<EditProfileNavigator> {

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();

  XFile? image;


  // image picker from camera
  Future<void> pickImageFromCamera() async {
    navigator!.goBack();
    final ImagePicker picker = ImagePicker();
    // Capture a photo.
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      this.image = image;
      notifyListeners();
    }
  }

  // image picker from gallery
  Future<void> pickImageFromGallery() async {
    navigator!.goBack();
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      this.image = image;
      notifyListeners();
    }
  }

  // function to show modal Bottom Sheet
  void showMyModalBottomSheet() {
    navigator!.showMyModalBottomSheetWidget();
  }


}