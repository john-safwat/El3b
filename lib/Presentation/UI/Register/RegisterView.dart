import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Core/Utils/DialogUtils.dart';
import 'package:El3b/Presentation/UI/Login/LoginView.dart';
import 'package:El3b/Presentation/UI/Register/RegisterNavigator.dart';
import 'package:El3b/Presentation/UI/Register/RegisterViewModel.dart';
import 'package:El3b/Presentation/UI/Register/Widgets/BottomSheetImagePicker.dart';
import 'package:El3b/Presentation/UI/Widgets/CustomTextFormField.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterView extends StatefulWidget {
  static const String routeName = 'Register';
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends BaseState<RegisterView, RegisterViewModel>
    implements RegisterNavigator {
  @override
  RegisterViewModel initViewModel() {
    return RegisterViewModel();
  }

  @override
  Widget build(BuildContext context) {
    viewModel!.themeProvider = Provider.of<ThemeProvider>(context);
    viewModel!.local = AppLocalizations.of(context)!;
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      builder: (context, child) => Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
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
                        Image.asset(
                          viewModel!.themeProvider!.isDark()
                              ? "Assets/Images/DarkLogo2.png"
                              : "Assets/Images/LightLogo2.png",
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                // Name Text Filed
                CustomTextFormField(
                  label: viewModel!.local!.name,
                  controller: viewModel!.nameController,
                  validator: viewModel!.nameValidation,
                  inputType: TextInputType.name,
                  icon: EvaIcons.file,
                ),
                const SizedBox(
                  height: 20,
                ),
                // Email Text Filed
                CustomTextFormField(
                  label: viewModel!.local!.email,
                  controller: viewModel!.emailController,
                  inputType: TextInputType.emailAddress,
                  validator: viewModel!.emailValidation,
                  icon: EvaIcons.email,
                ),
                const SizedBox(
                  height: 20,
                ),
                // Password Text Filed
                CustomPasswordTextFormField(
                    label: viewModel!.local!.password,
                    controller: viewModel!.passwordController,
                    inputType: TextInputType.visiblePassword,
                    validator: viewModel!.passwordValidation,
                    icon: EvaIcons.lock),
                const SizedBox(height: 20),
                // Password Confirmation Text Filed
                CustomPasswordTextFormField(
                    label: viewModel!.local!.passwordConfirmation,
                    controller: viewModel!.passwordConfirmationController,
                    inputType: TextInputType.visiblePassword,
                    validator: viewModel!.passwordConfirmationValidation,
                    icon: EvaIcons.lock),
                const SizedBox(height: 30),
                // Create Account Button
                ElevatedButton(
                    onPressed: () {
                      viewModel!.navigator!.showFailMessage(
                          context: context,
                          message: "Error Loading Data From Sever" ,
                          posActionTitle: "Ok",
                          negativeActionTitle: "Cancel",
                          backgroundColor: viewModel!.themeProvider!.isDark()?MyTheme.purple : MyTheme.offWhite
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(viewModel!.local!.createNewAccount),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),

                // if you have account login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      viewModel!.local!.alreadyHaveAccount,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              color: viewModel!.themeProvider!.isDark()
                                  ? MyTheme.offWhite
                                  : MyTheme.darkPurple),
                    ),
                    TextButton(
                      onPressed: viewModel!.goToLoginScreen,
                      child: Text(
                        viewModel!.local!.login,
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: MyTheme.lightPurple,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                AnimatedToggleSwitch.rolling(
                  current: viewModel!.localProvider!.currentLocal,
                  values: const ["en", "ar"],
                  height: 40,
                  colorBuilder: (value) => MyTheme.lightPurple,
                  iconBuilder: (value, size, foreground) {
                    if (value == "en") {
                      return Flag(Flags.united_kingdom);
                    } else {
                      return Flag(Flags.egypt);
                    }
                  },
                  onChanged: (p0) => viewModel!.changeLocal(),
                  transitionType: ForegroundIndicatorTransitionType.fading,
                  borderRadius: BorderRadius.circular(12),
                  borderColor: MyTheme.lightPurple,
                  borderWidth: 1,
                  dif: 10,
                ),
                AnimatedToggleSwitch.rolling(
                  current: viewModel!.themeProvider!.theme,
                  values: const [ThemeMode.dark, ThemeMode.light],
                  height: 40,
                  colorBuilder: (value) => MyTheme.lightPurple,
                  iconBuilder: (value, size, foreground) {
                    if (value == ThemeMode.dark) {
                      return const Icon(EvaIcons.moon);
                    } else {
                      return const Icon(EvaIcons.sun);
                    }
                  },
                  onChanged: (p0) => viewModel!.changeTheme(),
                  transitionType: ForegroundIndicatorTransitionType.fading,
                  borderRadius: BorderRadius.circular(12),
                  borderColor: MyTheme.lightPurple,
                  borderWidth: 1,
                  dif: 10,
                ),
              ],
            ),
          ),
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
              cameraTitle: viewModel!.local!.camera,
              galleryTitle: viewModel!.local!.gallery,
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
  goToLoginScreen() {
    Navigator.pushReplacementNamed(context, LoginView.routeName);
  }
}
