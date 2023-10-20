import 'dart:io';

import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Presentation/UI/CreateRoom/CreateRoomNavigator.dart';
import 'package:El3b/Presentation/UI/CreateRoom/CreateRoomViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateRoomView extends StatefulWidget {

  static const String routeName = "CreateRoom";

  const CreateRoomView({super.key});

  @override
  State<CreateRoomView> createState() => _CreateRoomViewState();
}

class _CreateRoomViewState extends BaseState<CreateRoomView , CreateRoomViewModel> implements CreateRoomNavigator  {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      child: Consumer<CreateRoomViewModel>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: Text(viewModel!.local!.createGroup),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Row(),
                //Image Picker
                InkWell(
                  onTap: viewModel!.showMyModalBottomSheet,
                  child: Container(
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
                        viewModel!.image == null?
                        Image.asset(
                          viewModel!.themeProvider!.isDark()
                              ? "Assets/Images/DarkLogo2.png"
                              : "Assets/Images/LightLogo2.png",
                        ):Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(File(viewModel!.image!.path)),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  CreateRoomViewModel initViewModel() {
    return CreateRoomViewModel();
  }
}
