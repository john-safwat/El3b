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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }

  @override
  ExtraInfoViewModel initViewModel() {
    return ExtraInfoViewModel();
  }
}
