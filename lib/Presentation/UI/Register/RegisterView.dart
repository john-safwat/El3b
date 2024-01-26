import 'dart:io';
import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Domain/UseCase/CreateAccountUseCase.dart';
import 'package:El3b/Presentation/UI/ExtraInfo/ExtraInfoView.dart';
import 'package:El3b/Presentation/UI/Login/LoginView.dart';
import 'package:El3b/Presentation/UI/Register/RegisterNavigator.dart';
import 'package:El3b/Presentation/UI/Register/RegisterViewModel.dart';
import 'package:El3b/Presentation/UI/Widgets/CustomPasswordTextFormField.dart';
import 'package:El3b/Presentation/UI/Widgets/CustomTextFormField.dart';
import 'package:El3b/Presentation/UI/Widgets/LanguageSwitch.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

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
    return RegisterViewModel(useCase: injectCreateAccountUseCase());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      builder: (context, child) => Consumer<RegisterViewModel>(
        builder: (context, value, child) =>  Scaffold(
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                    onTap: viewModel.showMyModalBottomSheet,
                    child: Container(
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
                          viewModel.image == null?
                          Image.asset(
                            viewModel.themeProvider!.isDark()
                                ? "Assets/Images/DarkLogo2.png"
                                : "Assets/Images/LightLogo2.png",
                          ):Container(
                            width: 200,
                            height: 200,
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
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                      key: viewModel.formKey,
                      child: Column(
                        children: [
                          // Name Text Filed
                          CustomTextFormField(
                            label: viewModel.local!.name,
                            controller: viewModel.nameController,
                            validator: viewModel.nameValidation,
                            inputType: TextInputType.name,
                            icon: EvaIcons.file,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Email Text Filed
                          CustomTextFormField(
                            label: viewModel.local!.email,
                            controller: viewModel.emailController,
                            inputType: TextInputType.emailAddress,
                            validator: viewModel.emailValidation,
                            icon: EvaIcons.email,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Password Text Filed
                          CustomPasswordTextFormField(
                              label: viewModel.local!.password,
                              controller: viewModel.passwordController,
                              inputType: TextInputType.visiblePassword,
                              validator: viewModel.passwordValidation,
                              icon: EvaIcons.lock),
                          const SizedBox(height: 20),
                          // Password Confirmation Text Filed
                          CustomPasswordTextFormField(
                              label: viewModel.local!.passwordConfirmation,
                              controller: viewModel.passwordConfirmationController,
                              inputType: TextInputType.visiblePassword,
                              validator: viewModel.passwordConfirmationValidation,
                              icon: EvaIcons.lock),
                          const SizedBox(height: 30),
                          // Create Account Button
                          ElevatedButton(
                              onPressed: () {
                                viewModel.createAccount();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(viewModel.local!.createNewAccount),
                                  ),
                                ],
                              )),
                        ],
                      )
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // if you have account login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        viewModel.local!.alreadyHaveAccount,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                            color: viewModel.themeProvider!.isDark()
                                ? MyTheme.offWhite
                                : MyTheme.darkPurple),
                      ),
                      TextButton(
                        onPressed: viewModel.goToLoginScreen,
                        child: Text(
                          viewModel.local!.login,
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
                  const LanguageSwitch(),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  goToLoginScreen() {
    Navigator.pushReplacementNamed(context, LoginView.routeName);
  }

  @override
  goToExtraInfoScreen() {
    Navigator.pushReplacementNamed(context, ExtraInfoView.routeName);
  }
}
