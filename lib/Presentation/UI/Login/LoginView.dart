import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Core/Providers/LocalProvider.dart';
import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Presentation/UI/Login/LoginNavigator.dart';
import 'package:El3b/Presentation/UI/Login/LoginViewModel.dart';
import 'package:El3b/Presentation/UI/Login/Widgets/DirectPlatformLogin.dart';
import 'package:El3b/Presentation/UI/Register/RegisterView.dart';
import 'package:El3b/Presentation/UI/Widgets/CustomTextFormField.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    return LoginViewModel();
  }

  @override
  Widget build(BuildContext context) {
    viewModel!.themeProvider = Provider.of<ThemeProvider>(context);
    // viewModel!.localProvider = Provider.of<LocalProvider>(context);
    viewModel!.local = AppLocalizations.of(context)!;
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      child:Scaffold(
        body: SingleChildScrollView(
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
                        const SizedBox(height: 20,),
                        // Password Text From Field
                        CustomPasswordTextFormField(
                          controller: viewModel!.passwordController,
                          inputType: TextInputType.visiblePassword,
                          label: viewModel!.local!.password,
                          validator: viewModel!.passwordValidation,
                          icon: EvaIcons.lock,
                        ),
                        const SizedBox(height: 10,),
                        // Forget Password Text Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  viewModel!.local!.forgetPassword,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                      color:viewModel!.themeProvider!.isDark()?MyTheme.offWhite:MyTheme.lightPurple,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w500
                                  ),
                                ))
                          ],
                        ),
                        const SizedBox(height: 10,),
                        // Login Button
                        ElevatedButton(
                            onPressed: (){},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:const EdgeInsets.all(10),
                                  child: Text(viewModel!.local!.login),
                                ),
                              ],
                            )
                        ),
                        const SizedBox(height: 10,),
                        // Create Account Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(viewModel!.local!.doNotHaveAccount ,
                              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: viewModel!.themeProvider!.isDark()? MyTheme.offWhite : MyTheme.darkPurple
                              ),),
                            TextButton(
                                onPressed: viewModel!.goToRegistrationScreen,
                                child: Text(
                                  viewModel!.local!.createAccount,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color:MyTheme.lightPurple,
                                  ),
                                )
                            )
                          ],
                        ),
                      ],
                    )
                ),
                const SizedBox(height: 10,),
                // or divider
                Row(
                  children: [
                    const SizedBox(width: 30),
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: viewModel!.themeProvider!.isDark()? MyTheme.offWhite :MyTheme.lightPurple,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Text(viewModel!.local!.or , style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: viewModel!.themeProvider!.isDark()? MyTheme.offWhite :MyTheme.lightPurple,
                    ),),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: viewModel!.themeProvider!.isDark()? MyTheme.offWhite :MyTheme.lightPurple,
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
                ),
                const SizedBox(height: 20),
                DirectPlatformLogin(
                  darkImage: "Assets/SVG/facebook_Dark.svg",
                  lightImage: "Assets/SVG/facebook_Light.svg",
                  title: viewModel!.local!.facebookLogin,
                  login: viewModel!.loginWithFacebook,
                ),
                const SizedBox(height: 20),

                AnimatedToggleSwitch.rolling(
                  current: viewModel!.localProvider!.currentLocal,
                  values: const ["en" , "ar"],
                  height: 40,
                  colorBuilder: (value) => MyTheme.lightPurple,
                  iconBuilder: (value, size, foreground) {
                    if(value == "en"){
                      return Flag(Flags.united_kingdom);
                    }else {
                      return Flag(Flags.egypt);
                    }
                  },
                  onChanged:(p0) => viewModel!.changeLocal(),
                  transitionType: ForegroundIndicatorTransitionType.fading,
                  borderRadius: BorderRadius.circular(12),
                  borderColor: MyTheme.lightPurple,
                  borderWidth: 1,
                  dif: 10,
                ),
                // AnimatedToggleSwitch.rolling(
                //   current: viewModel!.themeProvider!.theme,
                //   values: const [ThemeMode.dark , ThemeMode.light],
                //   height: 40,
                //   colorBuilder: (value) => MyTheme.lightPurple,
                //   iconBuilder: (value, size, foreground) {
                //     if(value == ThemeMode.dark){
                //       return const Icon(EvaIcons.moon);
                //     }else {
                //       return const Icon(EvaIcons.sun);
                //     }
                //   },
                //   onChanged: (p0) => viewModel!.changeTheme(),
                //   transitionType: ForegroundIndicatorTransitionType.fading,
                //   borderRadius: BorderRadius.circular(12),
                //   borderColor: MyTheme.lightPurple,
                //   borderWidth: 1,
                //   dif: 10,
                // ),
              ],
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
}
