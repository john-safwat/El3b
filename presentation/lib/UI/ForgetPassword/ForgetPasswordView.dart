
import 'package:core/Base/base_state.dart';
import 'package:domain/UseCase/ResetPasswordUseCase.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:presentation/UI/ForgetPassword/ForgetPasswordNavigator.dart';
import 'package:presentation/UI/ForgetPassword/ForgetPasswordViewModel.dart';
import 'package:presentation/UI/Widgets/CustomTextFormField.dart';

class ForgetPasswordView extends StatefulWidget {
  static const String routeName = "ForgetPassword";
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState
    extends BaseState<ForgetPasswordView, ForgetPasswordViewModel>
    implements ForgetPasswordNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.local!.forgetPassword),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Lottie.asset(
                  viewModel.themeProvider!.isDark()
                      ? "Assets/Animations/forgetMail.json"
                      : "Assets/Animations/forgetMail2.json",
                  width: double.infinity,
                  fit: BoxFit.cover),
              const SizedBox(
                height: 20,
              ),
              Form(
                  key: viewModel.formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                          label: viewModel.local!.email,
                          controller: viewModel.emailController,
                          inputType: TextInputType.emailAddress,
                          validator: viewModel.emailValidation,
                          icon: HeroIcons.envelope),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: viewModel.resetPassword,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(viewModel.local!.sendMail),
                              ],
                            ),
                          ))
                    ],
                  )),
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
