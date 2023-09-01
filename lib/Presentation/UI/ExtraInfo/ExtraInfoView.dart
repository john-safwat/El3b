import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Presentation/UI/ExtraInfo/ExtraInfoNavigator.dart';
import 'package:El3b/Presentation/UI/ExtraInfo/ExtraInfoViewModel.dart';
import 'package:flutter/material.dart';

class ExtraInfoView extends StatefulWidget {
  static const String routeName = "ExtraInfo";
  const ExtraInfoView({super.key});

  @override
  State<ExtraInfoView> createState() => _ExtraInfoViewState();
}

class _ExtraInfoViewState extends BaseState<ExtraInfoView , ExtraInfoViewModel> implements ExtraInfoNavigator {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("حمد لله علي السلامة"),
      ),
      body: Column(
        children: [
          Image.network(viewModel!.appConfigProvider!.user!.photoURL??""),
        ],
      ),
    );
  }

  @override
  ExtraInfoViewModel initViewModel() {
    return ExtraInfoViewModel();
  }
}
