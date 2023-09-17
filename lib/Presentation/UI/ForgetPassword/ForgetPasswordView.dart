import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Domain/UseCase/ResetPasswordUseCase.dart';
import 'package:El3b/Presentation/UI/ForgetPassword/ForgetPasswordNavigator.dart';
import 'package:El3b/Presentation/UI/ForgetPassword/ForgetPasswordViewModel.dart';
import 'package:El3b/Presentation/UI/Widgets/CustomTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';

class ForgetPasswordView extends StatefulWidget {
  static const String routeName = "ForgetPassword";
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends BaseState <ForgetPasswordView , ForgetPasswordViewModel> implements ForgetPasswordNavigator{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar:  AppBar(
        title: Text(viewModel!.local!.forgetPassword),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SvgPicture.asset(
                  viewModel!.themeProvider!.isDark()?
                    "Assets/SVG/DarkForgetPassword.svg":
                    "Assets/SVG/LightForgetPassword.svg",
              ),
              Form(
                  key: viewModel!.formKey,
                  child:Column(
                    children: [
                      CustomTextFormField(
                        label: viewModel!.local!.email,
                        controller: viewModel!.emailController,
                        inputType: TextInputType.emailAddress,
                        validator: viewModel!.emailValidation,
                        icon: HeroIcons.envelope
                      ),
                      const SizedBox(height:20,),
                      ElevatedButton(
                        onPressed: viewModel!.resetPassword,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(viewModel!.local!.sendMail),
                            ],
                          ),
                        )
                      )
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  ForgetPasswordViewModel initViewModel() {
    return ForgetPasswordViewModel(useCase: injectResetPasswordUseCase());
  }
}
