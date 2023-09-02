import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Presentation/UI/ExtraInfo/ExtraInfoNavigator.dart';
import 'package:El3b/Presentation/UI/ExtraInfo/ExtraInfoViewModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // image in the top
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        color: viewModel!.themeProvider!.isDark()
                            ? MyTheme.lightPurple
                            : MyTheme.offWhite,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          )
                        ]),
                    child: Column(
                      children: [
                        viewModel!.appConfigProvider!.user!.photoURL == null?
                        Image.asset(
                          viewModel!.themeProvider!.isDark()
                              ? "Assets/Images/DarkLogo2.png"
                              : "Assets/Images/LightLogo2.png",
                        ):Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(viewModel!.appConfigProvider!.user!.photoURL!),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  @override
  ExtraInfoViewModel initViewModel() {
    return ExtraInfoViewModel();
  }
}
