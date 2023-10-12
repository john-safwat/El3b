import 'dart:io';

import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Presentation/UI/EditProfile/EditProfileNavigator.dart';
import 'package:El3b/Presentation/UI/EditProfile/EditProfileViewModel.dart';
import 'package:El3b/Presentation/UI/EditProfile/Widgets/BottomSheeteWiget.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            //Image Picker
            InkWell(
              onTap: viewModel!.showMyModalBottomSheet,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    color: viewModel!.themeProvider!.isDark()
                        ? MyTheme.lightPurple
                        : MyTheme.offWhite,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      )
                    ]),
                child: Column(
                  children: [
                    viewModel!.image == null?
                    Image.asset(
                      viewModel!.themeProvider!.isDark()
                          ? "Assets/Images/DarkLogo2.png"
                          : "Assets/Images/LightLogo2.png",
                    ):Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(File(viewModel!.image!.path)),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(20)
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // form
            Form(
              child: Column(
                children: [

                ],
              )
            )
          ],
        ),
      ),
    );
  }

  @override
  showMyModalBottomSheetWidget() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => MyBottomSheetWidget(
          title: viewModel!.local!.selectPickingImageMethod,
          pickImageFromCamera: viewModel!.pickImageFromCamera,
          cameraTitle: viewModel!.local!.camera,
          galleryTitle: viewModel!.local!.gallery,
          pickImageFromGallery: viewModel!.pickImageFromGallery,
        ),
        backgroundColor: viewModel!.themeProvider!.isDark()
            ? MyTheme.purple
            : MyTheme.offWhite,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            )));
  }


  @override
  EditProfileViewModel initViewModel() {
    return EditProfileViewModel();
  }
}
