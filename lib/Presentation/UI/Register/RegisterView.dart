import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Core/Providers/ThemeProvider.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Presentation/UI/Login/LoginView.dart';
import 'package:El3b/Presentation/UI/Register/RegisterNavigator.dart';
import 'package:El3b/Presentation/UI/Register/RegisterViewModel.dart';
import 'package:El3b/Presentation/UI/Register/Widgets/BottomSheetImagePicker.dart';
import 'package:El3b/Presentation/UI/Widgets/CustomTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterView extends StatefulWidget {
  static const String routeName = 'Register';

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
    return ChangeNotifierProvider<RegisterViewModel>(
      create: (context) => viewModel!,
      builder: (context, child) => Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20,),
                //El3b logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        showMyModalBottomSheetWidget();
                      },
                      child: Container(
                        color: MyTheme.lightPurple,
                        width: 200,
                        height: 200,
                        child: Image.asset(
                          viewModel!.themeProvider!.isDark()
                              ? "Assets/Images/DarkLogo2.png"
                              : "Assets/Images/LightLogo.png",
                          height: 200,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                CustomTextFormField(
                  label: viewModel!.local!.name,
                  controller: viewModel!.nameController,
                  validator: viewModel!.nameValidation,
                  inputType: TextInputType.name,
                  icon: EvaIcons.person_outline,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  label: viewModel!.local!.email,
                  controller: viewModel!.EmailController,
                  inputType: TextInputType.emailAddress,
                  validator: viewModel!.emailValidation,
                  icon: EvaIcons.email,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomPasswordTextFormField(
                    label: viewModel!.local!.password,
                    controller: viewModel!.PasswordController,
                    inputType: TextInputType.visiblePassword,
                    validator: viewModel!.passwordValidation,
                    icon: EvaIcons.lock),
                const SizedBox(height: 20),
                CustomPasswordTextFormField(
                    label: viewModel!.local!.passwordConfirmation,
                    controller: viewModel!.PasswordConfirmationController,
                    inputType: TextInputType.visiblePassword,
                    validator: viewModel!.passwordConfirm,
                    icon: EvaIcons.lock),
                const SizedBox(height: 30),
                ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(viewModel!.local!.createAccount),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      viewModel!.local!.alreadyHaveAccount,
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: viewModel!.themeProvider!.isDark()
                              ? MyTheme.offWhite
                              : MyTheme.darkPurple),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginView.routeName);
                      },
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
                )
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
      builder: (context) => MyBottomSheetWidget(),
      backgroundColor: Colors.transparent,
    );
  }
}
