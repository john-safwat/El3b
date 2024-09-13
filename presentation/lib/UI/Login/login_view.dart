import 'package:core/Base/base_state.dart';
import 'package:core/Theme/theme.dart';
import 'package:domain/UseCase/add_user_use_case.dart';
import 'package:domain/UseCase/check_if_user_exist_use_case.dart';
import 'package:domain/UseCase/sign_in_user_with_email_and_password_use_case.dart';
import 'package:domain/UseCase/sign_in_with_facebook_use_case.dart';
import 'package:domain/UseCase/sign_in_with_google_use_case.dart';
import 'package:presentation/UI/ExtraInfo/extra_info_view.dart';
import 'package:presentation/UI/ForgetPassword/forget_password_view.dart';
import 'package:presentation/UI/Home/home_view.dart';
import 'package:presentation/UI/Login/login_navigator.dart';
import 'package:presentation/UI/Login/login_view_model.dart';
import 'package:presentation/UI/Login/Widgets/direct_platform_login.dart';
import 'package:presentation/UI/Register/register_view.dart';
import 'package:presentation/UI/Widgets/custom_password_text_form_field.dart';
import 'package:presentation/UI/Widgets/custom_text_form_field.dart';
import 'package:presentation/UI/Widgets/language_switch.dart';
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
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<LoginViewModel>(
        builder:(context, value, child) =>  Scaffold(
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // El3b logo
                  InkWell(
                    onTap: viewModel.changeTheme,
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    child: Image.asset(
                      viewModel.themeProvider!.isDark()
                          ? "Assets/Images/DarkLogo2.png"
                          : "Assets/Images/LightLogo2.png",
                      height: 200,
                    ),
                  ),
                  // Input Form
                  Form(
                      key: viewModel.formKey,
                      child: Column(
                        children: [
                          // Email Text From Field
                          CustomTextFormField(
                            controller: viewModel.emailController,
                            inputType: TextInputType.emailAddress,
                            label: viewModel.local!.email,
                            validator: viewModel.emailValidation,
                            icon: EvaIcons.email,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Password Text From Field
                          CustomPasswordTextFormField(
                            controller: viewModel.passwordController,
                            inputType: TextInputType.visiblePassword,
                            label: viewModel.local!.password,
                            validator: viewModel.passwordValidation,
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
                                  onPressed: viewModel.goToForgetPasswordScreen,
                                  child: Text(
                                    viewModel.local!.forgetPassword,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                            color:
                                                viewModel.themeProvider!.isDark()
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
                              onPressed: viewModel.signInWithEmailAndPassword,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(viewModel.local!.login),
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
                                viewModel.local!.doNotHaveAccount,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                        color: viewModel.themeProvider!.isDark()
                                            ? MyTheme.offWhite
                                            : MyTheme.darkPurple),
                              ),
                              TextButton(
                                  onPressed: viewModel.goToRegistrationScreen,
                                  child: Text(
                                    viewModel.local!.createAccount,
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
                      Text(viewModel.local!.or,
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
                    title: viewModel.local!.googleLogin,
                    login: viewModel.loginWithGoogle,
                    loading: viewModel.googleLogin,
                  ),
                  const SizedBox(height: 20),
                  DirectPlatformLogin(
                    darkImage: "Assets/SVG/facebook_Dark.svg",
                    lightImage: "Assets/SVG/facebook_Light.svg",
                    title: viewModel.local!.facebookLogin,
                    login: (){},
                    loading: viewModel.facebookLogin,
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
