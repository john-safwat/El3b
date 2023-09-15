import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Domain/UseCase/AddUserUseCase.dart';
import 'package:El3b/Domain/UseCase/CheckIfUserExistUseCase.dart';
import 'package:El3b/Domain/UseCase/SignInUserWithEmailAndPasswordUseCase.dart';
import 'package:El3b/Domain/UseCase/SignInWithFacebookUseCase.dart';
import 'package:El3b/Domain/UseCase/SignInWithGoogleUseCase.dart';
import 'package:El3b/Presentation/UI/ExtraInfo/ExtraInfoView.dart';
import 'package:El3b/Presentation/UI/ForgetPassword/ForgetPasswordView.dart';
import 'package:El3b/Presentation/UI/Home/HomeView.dart';
import 'package:El3b/Presentation/UI/Login/LoginNavigator.dart';
import 'package:El3b/Presentation/UI/Login/LoginViewModel.dart';
import 'package:El3b/Presentation/UI/Login/Widgets/DirectPlatformLogin.dart';
import 'package:El3b/Presentation/UI/Register/RegisterView.dart';
import 'package:El3b/Presentation/UI/Widgets/CustomPasswordTextFormField.dart';
import 'package:El3b/Presentation/UI/Widgets/CustomTextFormField.dart';
import 'package:El3b/Presentation/UI/Widgets/LanguageSwitch.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  static const String routeName = "Login";
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends BaseState<LoginView, LoginViewModel>
    implements LoginNavigator {
  @override
  LoginViewModel initViewModel() {
    return LoginViewModel(
      singInUserWithEmailAndPasswordUseCase: injectSignInUserWithEmailAndPasswordUseCase(),
      signInWithGoogleUseCase: injectSignInWithGoogleUseCase(),
      checkIfUserExistUseCase: injectCheckIfUserExistUseCase(),
      addUserUseCase: injectAddUserUseCase(),
      signInWithFacebookUseCase: injectSignInWithFacebookUseCase()
    );
  }

  @override
  Widget build(BuildContext context) {
    if(viewModel!.themeProvider == null){
      super.build(context);
    }
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      child: Consumer<LoginViewModel>(
        builder:(context, value, child) =>  Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // El3b logo
                  InkWell(
                    onTap: viewModel!.changeTheme,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    child: Image.asset(
                      viewModel!.themeProvider!.isDark()
                          ? "Assets/Images/DarkLogo2.png"
                          : "Assets/Images/LightLogo2.png",
                      height: 200,
                    ),
                  ),
                  // Input Form
                  Form(
                      key: viewModel!.formKey,
                      child: Column(
                        children: [
                          // Email Text From Field
                          CustomTextFormField(
                            controller: viewModel!.emailController,
                            inputType: TextInputType.emailAddress,
                            label: viewModel!.local!.email,
                            validator: viewModel!.emailValidation,
                            icon: EvaIcons.email,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Password Text From Field
                          CustomPasswordTextFormField(
                            controller: viewModel!.passwordController,
                            inputType: TextInputType.visiblePassword,
                            label: viewModel!.local!.password,
                            validator: viewModel!.passwordValidation,
                            icon: EvaIcons.lock,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // Forget Password Text Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: viewModel!.goToForgetPasswordScreen,
                                  child: Text(
                                    viewModel!.local!.forgetPassword,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                            color:
                                                viewModel!.themeProvider!.isDark()
                                                    ? MyTheme.offWhite
                                                    : MyTheme.lightPurple,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w500),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // Login Button
                          ElevatedButton(
                              onPressed: viewModel!.signInWithEmailAndPassword,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(viewModel!.local!.login),
                                  ),
                                ],
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          // Create Account Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                viewModel!.local!.doNotHaveAccount,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                        color: viewModel!.themeProvider!.isDark()
                                            ? MyTheme.offWhite
                                            : MyTheme.darkPurple),
                              ),
                              TextButton(
                                  onPressed: viewModel!.goToRegistrationScreen,
                                  child: Text(
                                    viewModel!.local!.createAccount,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: MyTheme.lightPurple,
                                        ),
                                  ))
                            ],
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  // or divider
                  Row(
                    children: [
                      const SizedBox(width: 30),
                      const Expanded(
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(viewModel!.local!.or,
                          style: Theme.of(context).textTheme.displayMedium),
                      const SizedBox(width: 15),
                      const Expanded(
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                      const SizedBox(width: 30),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // login with google button
                  DirectPlatformLogin(
                    darkImage: "Assets/SVG/google_Dark.svg",
                    lightImage: "Assets/SVG/google_Light.svg",
                    title: viewModel!.local!.googleLogin,
                    login: viewModel!.loginWithGoogle,
                    loading: viewModel!.googleLogin,
                  ),
                  const SizedBox(height: 20),
                  DirectPlatformLogin(
                    darkImage: "Assets/SVG/facebook_Dark.svg",
                    lightImage: "Assets/SVG/facebook_Light.svg",
                    title: viewModel!.local!.facebookLogin,
                    login: viewModel!.loginWithFacebook,
                    loading: viewModel!.facebookLogin,
                  ),
                  const SizedBox(height: 20),
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
  goToRegistrationScreen() {
    Navigator.pushReplacementNamed(context, RegisterView.routeName);
  }

  @override
  goToHomeScreen() {
    Navigator.pushReplacementNamed(context, HomeView.routeName);
  }

  @override
  goToForgetPasswordScreen() {
    Navigator.pushNamed(context, ForgetPasswordView.routeName);
  }

  @override
  goToExtraInfoScreen() {
    Navigator.pushReplacementNamed(context, ExtraInfoView.routeName);
  }
}
