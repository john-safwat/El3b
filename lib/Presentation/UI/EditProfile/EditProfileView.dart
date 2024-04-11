import 'dart:io';

import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Domain/UseCase/LoadUserDataUseCase.dart';
import 'package:El3b/Domain/UseCase/ResetPasswordUseCase.dart';
import 'package:El3b/Domain/UseCase/UpdateUserProfileUseCase.dart';
import 'package:El3b/Presentation/UI/EditProfile/EditProfileNavigator.dart';
import 'package:El3b/Presentation/UI/EditProfile/EditProfileViewModel.dart';
import 'package:El3b/Presentation/UI/ResetPassword/ResetPasswordView.dart';
import 'package:El3b/Presentation/UI/Widgets/CustomLongTextFormField.dart';
import 'package:El3b/Presentation/UI/Widgets/CustomTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class EditProfileView extends StatefulWidget {
  static const String routeName = "EditProfile";
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends BaseState<EditProfileView , EditProfileViewModel> implements EditProfileNavigator {

  @override
  void initState() {
    super.initState();
    viewModel.loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          viewModel.local!.editProfile
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Consumer<EditProfileViewModel>(
          builder:(context, value, child) {
            if (value.errorMessage != null){
              return ErrorWidget(value.errorMessage!);
            }else if (value.user == null){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    //Image Picker
                    InkWell(
                      onTap: viewModel.showMyModalBottomSheet,
                      child: Container(
                        width: viewModel.mediaQuery!.width - 40,
                        height: viewModel.mediaQuery!.width - 40,
                        decoration: BoxDecoration(
                            color: viewModel.themeProvider!.isDark()
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
                            viewModel.image == null? viewModel.user!.image != ""?Container(
                          width: viewModel.mediaQuery!.width - 40,
                          height: viewModel.mediaQuery!.width - 40,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(viewModel.user!.image),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(20)
                          ),
                        ):
                            Image.asset(
                              viewModel.themeProvider!.isDark()
                                  ? "Assets/Images/DarkLogo2.png"
                                  : "Assets/Images/LightLogo2.png",
                            ):Container(
                              width: viewModel.mediaQuery!.width - 40,
                              height: viewModel.mediaQuery!.width - 40,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(File(viewModel.image!.path)),
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
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            CustomTextFormField(
                                label: value.local!.name,
                                controller: value.nameController,
                                inputType: TextInputType.name,
                                validator: value.nameValidation,
                                icon: EvaIcons.file
                            ),
                            const SizedBox(height: 20,),
                            CustomTextFormField(
                                label: value.local!.phone,
                                controller: value.phoneController,
                                inputType: TextInputType.phone,
                                validator: value.phoneValidation,
                                icon: EvaIcons.phone
                            ),
                            const SizedBox(height: 20,),
                            // date piker button
                            InkWell(
                              onTap: (){
                                viewModel.showDatePicker();
                              },
                              child: Container(
                                padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(width: 2 , color: MyTheme.lightPurple),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(EvaIcons.calendar , color: MyTheme.lightPurple,size: 30,),
                                    const SizedBox(width: 10,),
                                    Text(viewModel.selectedDate , style: Theme.of(context).textTheme.displayMedium,),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            CustomLongTextFormField(
                                label: value.local!.bio,
                                controller: value.bioController,
                                inputType: TextInputType.text,
                                validator: value.bioValidation,
                            ),
                            const SizedBox(height: 20,),
                            // confirm button
                            ElevatedButton(
                              onPressed: viewModel.updateUserData,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(viewModel.local!.updateAccount),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    )
                  ],
                )
              );
            }
          },
        ),
      ),
    );
  }


  @override
  EditProfileViewModel initViewModel() {
    return EditProfileViewModel(
      loadUserDataUseCase: injectLoadUserDataUseCase(),
      updateUserProfileUseCase: injectUpdateUserProfileUseCase()
    );
  }

  @override
  showCustomDatePicker() async{
    DateTime? newDateTime = await showRoundedDatePicker(
      context: context,
      initialDate: viewModel.birthDate,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 1),
      borderRadius: 16,
      height: 300,
      barrierDismissible: false,
      styleDatePicker: MaterialRoundedDatePickerStyle(
        backgroundActionBar: MyTheme.offWhite,
        backgroundHeader: MyTheme.lightPurple,
        colorArrowNext: MyTheme.lightPurple,
        colorArrowPrevious: MyTheme.lightPurple,
        textStyleButtonAction: const TextStyle(fontSize: 16, color: MyTheme.lightPurple,),
        textStyleMonthYearHeader: const TextStyle(fontSize: 16, color: MyTheme.lightPurple,),
        textStyleDayOnCalendarSelected:const TextStyle(fontSize: 16, color: MyTheme.offWhite,),
        textStyleDayOnCalendarDisabled:const TextStyle(fontSize: 16, color: MyTheme.lightPurple,),
        textStyleYearButton: const TextStyle(fontSize: 16, color: MyTheme.offWhite,),
        textStyleDayOnCalendar: const TextStyle(fontSize: 16, color: MyTheme.darkPurple,),
        textStyleDayHeader: const TextStyle(fontSize: 16, color: MyTheme.darkPurple,),
        textStyleDayButton: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: MyTheme.offWhite,),
        textStyleCurrentDayOnCalendar: const TextStyle(fontSize: 16, color: MyTheme.lightPurple,),
        textStyleButtonPositive:  const TextStyle(fontSize: 16, color: MyTheme.lightPurple,),
        textStyleButtonNegative: const TextStyle(fontSize: 16, color: MyTheme.lightPurple,),
        backgroundHeaderMonth: MyTheme.offWhite,
        backgroundPicker: MyTheme.offWhite,
        decorationDateSelected: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MyTheme.lightPurple
        ),
      ),
    );

    viewModel.changeDate(newDateTime);
  }

}
