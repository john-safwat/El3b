import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Presentation/UI/EditProfile/EditProfileNavigator.dart';
import 'package:El3b/Presentation/UI/EditProfile/EditProfileViewModel.dart';
import 'package:flutter/material.dart';

class EditProfileView extends StatefulWidget {
  static const String routeName = "EditProfile";
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends BaseState<EditProfileView , EditProfileViewModel> implements EditProfileNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          viewModel!.local!.editProfile
        ),
      ),
    );
  }

  @override
  EditProfileViewModel initViewModel() {
    return EditProfileViewModel();
  }
}
