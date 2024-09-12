import 'package:core/Base/base_state.dart';
import 'package:core/Base/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:presentation/UI/About/Widgets/list_points.dart';
import 'package:presentation/UI/About/Widgets/text_card.dart';

class AboutView extends StatefulWidget {
  static const String routeName = "About";

  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends BaseState<AboutView, BaseViewModel> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.local!.aboutUs),
      ),
      body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                "El3b",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                viewModel.local!.aboutUsMessage1,
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Image.asset("Assets/Images/aboutUs.png"),
              const SizedBox(height: 50),
              Text(
                viewModel.local!.aboutUsMessage2,
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextCard(content: viewModel.local!.mainFeatures),
              const SizedBox(height: 30),
              ListPoints(content: viewModel.local!.aboutUsMessage3),
              ListPoints(content: viewModel.local!.aboutUsMessage4),
              Lottie.asset("Assets/Animations/aboutUs2.json"),
              ListPoints(content: viewModel.local!.aboutUsMessage5),
              ListPoints(content: viewModel.local!.aboutUsMessage6),
              ListPoints(content: viewModel.local!.aboutUsMessage7),
              const SizedBox(height: 10),
              Lottie.asset("Assets/Animations/aboutUs5.json"),
              const SizedBox(height: 10),
              Text(
                viewModel.local!.aboutUsMessage8,
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Lottie.asset("Assets/Animations/aboutUs4.json"),
              const SizedBox(height: 30),
              TextCard(content: viewModel.local!.appVersion),
            ],
          )),
    );
  }

  @override
  BaseViewModel initViewModel() {
    return BaseViewModel();
  }
}
