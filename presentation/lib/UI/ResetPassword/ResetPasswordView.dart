import 'package:core/Base/base_state.dart';
import 'package:domain/UseCase/update_user_password_use_case.dart';
import 'package:presentation/UI/ResetPassword/ResetPasswordNavigator.dart';
import 'package:presentation/UI/ResetPassword/ResetPasswordViewModel.dart';
import 'package:presentation/UI/Widgets/CustomPasswordTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ResetPasswordView extends StatefulWidget {
  static const String routeName  = "resetPassword";
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends BaseState<ResetPasswordView , ResetPasswordViewModel> implements ResetPasswordNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(title: Text(viewModel.local!.changePassword),),
        body: Form(
          key: viewModel.formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Lottie.asset("Assets/Animations/resetPassword.json"),
              const SizedBox(height: 30,),
              // Password Text Filed
              CustomPasswordTextFormField(
                  label: viewModel.local!.password,
                  controller: viewModel.passwordController,
                  inputType: TextInputType.visiblePassword,
                  validator: viewModel.passwordValidation,
                  icon: EvaIcons.lock),
              const SizedBox(height: 20,),
              // Password Text Filed
              CustomPasswordTextFormField(
                  label: viewModel.local!.newPassword,
                  controller: viewModel.newPasswordController,
                  inputType: TextInputType.visiblePassword,
                  validator: viewModel.passwordValidation,
                  icon: EvaIcons.lock),
              const SizedBox(height: 20,),
              // Password Text Filed
              CustomPasswordTextFormField(
                  label: viewModel.local!.newPasswordConfirmation,
                  controller: viewModel.newPasswordConfirmationController,
                  inputType: TextInputType.visiblePassword,
                  validator: viewModel.passwordConfirmationValidation,
                  icon: EvaIcons.lock),
              const SizedBox(height: 30,),
              ElevatedButton(
                  onPressed: (){
                    viewModel.updatePassword();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(viewModel.local!.save),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  ResetPasswordViewModel initViewModel() {
    return ResetPasswordViewModel(
      useCase: injectUpdateUserPasswordUseCase()
    );
  }
}
