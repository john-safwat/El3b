import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Presentation/UI/About/AboutNavigator.dart';
import 'package:El3b/Presentation/UI/About/AboutViewModel.dart';
import 'package:flutter/material.dart';

class AboutView extends StatefulWidget {
  static const String routeName = "About";
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends BaseState<AboutView , AboutViewModel> implements AboutNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel!.local!.aboutUs),
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: Column(
          children: [
            Expanded(child: ListView(
              padding:const EdgeInsets.all(20),
              children: [
                Text(viewModel!.local!.aboutUsMessage , style: Theme.of(context).textTheme.displayMedium,)
              ],
            ))
          ],
        ),
      ),
    );
  }

  @override
  AboutViewModel initViewModel() {
    return AboutViewModel();
  }
}
