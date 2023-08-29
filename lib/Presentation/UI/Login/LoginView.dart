import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Core/Providers/LocalProvider.dart';
import 'package:El3b/Core/Providers/ThemeProvider.dart';
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

class _LoginViewState extends BaseState<LoginView, LoginViewModel> implements LoginNavigator {

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
      child: Consumer<LoginViewModel >(
        builder: (context, value, child) => Scaffold(
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(viewModel!.themeProvider!.isDark()?"Assets/Images/DarkLogo2.png":"Assets/Images/LightLogo2.png" , height: 150,),
                ],
              ),
              Form(
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: viewModel!.emailController,
                      inputType: TextInputType.emailAddress,
                      label: viewModel!.local!.email,
                      validator: viewModel!.emailValidation,
                      icon: EvaIcons.email,
                    ),
                    CustomPasswordTextFormField(
                      controller: viewModel!.passwordController,
                      inputType: TextInputType.visiblePassword,
                      label: viewModel!.local!.password,
                      validator: viewModel!.passwordValidation,
                      icon: EvaIcons.lock,
                    ),
                  ],
                )
              ),
              ElevatedButton(
                onPressed: () {
                  viewModel!.themeProvider!.changeTheme(
                      viewModel!.themeProvider!.isDark()
                          ? ThemeMode.light
                          : ThemeMode.dark);
                },
                child: Text(viewModel!.local!.theme),
              ),ElevatedButton(
                onPressed: () {
                  viewModel!.localProvider!.changeLocal(viewModel!.localProvider!.currentLocal == 'en'? "ar" : 'en');
                },
                child: Text(viewModel!.local!.language),
              )
            ],
          ),
        ),
      ),
    );
  }
}
