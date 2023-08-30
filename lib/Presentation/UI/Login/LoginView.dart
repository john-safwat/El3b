import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Core/Providers/LocalProvider.dart';
import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Presentation/UI/Login/LoginNavigator.dart';
import 'package:El3b/Presentation/UI/Login/LoginViewModel.dart';
import 'package:El3b/Presentation/UI/Widgets/CustomTextFormField.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    viewModel!.localProvider = Provider.of<LocalProvider>(context);
    viewModel!.local = AppLocalizations.of(context)!;
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      child: Consumer<LoginViewModel>(
        builder: (context, value, child) => Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // El3b logo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        viewModel!.themeProvider!.isDark()
                            ? "Assets/Images/DarkLogo2.png"
                            : "Assets/Images/LightLogo2.png",
                        height: 150,
                      ),
                    ],
                  ),
                  // Input Form
                  Form(
                    child: Column(
                      children: [
                        //
                        CustomTextFormField(
                          controller: viewModel!.emailController,
                          inputType: TextInputType.emailAddress,
                          label: viewModel!.local!.email,
                          validator: viewModel!.emailValidation,
                          icon: EvaIcons.email,
                        ),
                        const SizedBox(height: 20,),
                        CustomPasswordTextFormField(
                          controller: viewModel!.passwordController,
                          inputType: TextInputType.visiblePassword,
                          label: viewModel!.local!.password,
                          validator: viewModel!.passwordValidation,
                          icon: EvaIcons.lock,
                        ),
                        const SizedBox(height: 10,),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(viewModel!.local!.doNotHaveAccount , style: Theme.of(context).textTheme.displayMedium,),
                            TextButton(
                                onPressed: () {},
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
                  const SizedBox(height: 15,),

                  ElevatedButton(
                    onPressed: () {
                      viewModel!.themeProvider!.changeTheme(
                          viewModel!.themeProvider!.isDark()
                              ? ThemeMode.light
                              : ThemeMode.dark);
                    },
                    child: Text(viewModel!.local!.theme),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      viewModel!.localProvider!.changeLocal(
                          viewModel!.localProvider!.currentLocal == 'en'
                              ? "ar"
                              : 'en');
                    },
                    child: Text(viewModel!.local!.language),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
