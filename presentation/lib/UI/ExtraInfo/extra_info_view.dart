import 'package:core/Base/base_state.dart';
import 'package:core/Theme/theme.dart';
import 'package:domain/UseCase/update_user_data_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:presentation/UI/ExtraInfo/extra_info_navigator.dart';
import 'package:presentation/UI/ExtraInfo/extra_info_view_model.dart';
import 'package:presentation/UI/Login/login_view.dart';
import 'package:presentation/UI/Widgets/custom_long_text_form_field.dart';
import 'package:presentation/UI/Widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class ExtraInfoView extends StatefulWidget {
  static const String routeName = "ExtraInfo";
  const ExtraInfoView({super.key});

  @override
  State<ExtraInfoView> createState() => _ExtraInfoViewState();
}

class _ExtraInfoViewState extends BaseState<ExtraInfoView , ExtraInfoViewModel> implements ExtraInfoNavigator {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Consumer<ExtraInfoViewModel>(
          builder: (context, value, child) => SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  // image in the top
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
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
                            viewModel.appConfigProvider!.getUser()!.photoURL == null?
                            Image.asset(
                              viewModel.themeProvider!.isDark()
                                  ? "Assets/Images/DarkLogo2.png"
                                  : "Assets/Images/LightLogo2.png",
                            ):Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(viewModel.appConfigProvider!.getUser()!.photoURL!),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  // welcome message
                  Text(
                    "${viewModel.local!.welcome} ${viewModel.appConfigProvider!.getUser()!.displayName!.split(" ")[0]}",
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20,),
                  Text(
                    viewModel.local!.weNeedSomeAdditionalInfo,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 30,),
                  // data form
                  Form(
                    key: viewModel.formKey,
                    child: Column(
                      children: [
                        // phone number text form field
                        CustomTextFormField(
                          label: viewModel.local!.phone,
                          controller: viewModel.phoneController,
                          inputType: TextInputType.phone,
                          validator: viewModel.phoneValidation,
                          icon: EvaIcons.smartphone
                        ),
                        const SizedBox(height: 20,),
                        // date piker button
                        InkWell(
                          onTap: (){
                            viewModel.showDatePicker();
                          },
                          child: Container(
                            padding:const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
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
                        // bio text field
                        CustomLongTextFormField(
                          label: viewModel.local!.bio,
                          controller: viewModel.bioController,
                          inputType: TextInputType.text,
                          validator: viewModel.bioValidation
                        ),
                        const SizedBox(height: 30,),
                        // confirm button
                        ElevatedButton(
                          onPressed: viewModel.updateUserData,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(viewModel.local!.gj),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  ExtraInfoViewModel initViewModel() {
    return ExtraInfoViewModel(useCase: injectUpdateUserDataUseCase());
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

  @override
  goToLoginScreen() {
    Navigator.pushReplacementNamed(context, LoginView.routeName);
  }


}
