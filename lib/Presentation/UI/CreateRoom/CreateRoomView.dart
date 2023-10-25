import 'dart:io';

import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Domain/UseCase/AddRoomUseCase.dart';
import 'package:El3b/Presentation/Models/RoomType.dart';
import 'package:El3b/Presentation/UI/CreateRoom/CreateRoomNavigator.dart';
import 'package:El3b/Presentation/UI/CreateRoom/CreateRoomViewModel.dart';
import 'package:El3b/Presentation/UI/CreateRoom/Widgets/TypeDropdownButtonWidget.dart';
import 'package:El3b/Presentation/UI/Widgets/CustomLongTextFormField.dart';
import 'package:El3b/Presentation/UI/Widgets/CustomTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class CreateRoomView extends StatefulWidget {

  static const String routeName = "CreateRoom";

  const CreateRoomView({super.key});

  @override
  State<CreateRoomView> createState() => _CreateRoomViewState();
}

class _CreateRoomViewState extends BaseState<CreateRoomView , CreateRoomViewModel> implements CreateRoomNavigator  {

  @override
  void initState() {
    super.initState();
    viewModel!.selectedType = viewModel!.types.first;
  }

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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
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
                  const SizedBox(height: 20,),
                  Form(
                    key: viewModel!.formKey,
                    child: Column(
                      children: [
                        // text from e
                        CustomTextFormField(
                          label: viewModel!.local!.name,
                          controller: viewModel!.nameController,
                          inputType: TextInputType.name,
                          validator: viewModel!.nameValidation,
                          icon: EvaIcons.file
                        ),
                        const SizedBox(height: 20,),
                        // the text area
                        CustomLongTextFormField(
                          label: viewModel!.local!.description,
                          controller: viewModel!.descriptionController,
                          inputType: TextInputType.text,
                          validator: viewModel!.descriptionValidation
                        ),
                        const SizedBox(height: 20,),
                        // the room type dropdown
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: viewModel!.themeProvider!.isDark()? MyTheme.darkPurple : MyTheme.offWhite,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(width: 2 ,color: MyTheme.lightPurple),
                          ),
                          child: DropdownButton<RoomType>(
                            isExpanded: true,
                            underline: Container(),
                            value: viewModel!.selectedType,
                            borderRadius: BorderRadius.circular(20),
                            dropdownColor: viewModel!.themeProvider!.isDark()? MyTheme.darkPurple : MyTheme.offWhite,
                            icon: Icon(EvaIcons.arrow_down , color: viewModel!.themeProvider!.isDark()? MyTheme.offWhite : MyTheme.darkPurple),
                            iconEnabledColor: viewModel!.themeProvider!.isDark()? MyTheme.darkPurple : MyTheme.lightPurple,
                            items: viewModel!.types.map<DropdownMenuItem<RoomType>>(
                                    (e) => DropdownMenuItem<RoomType>(
                                  value: e,
                                  child: TypeDropdownButtonWidget(roomType: e,),
                                )
                            ).toList(),
                            onChanged: (value) => viewModel!.changeSelectedType(value!),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        // Button
                        ElevatedButton(
                          onPressed: viewModel!.createRoom,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(viewModel!.local!.createGroup),
                              ],
                            ),
                          )
                        )
                      ],
                    )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  CreateRoomViewModel initViewModel() {
    return CreateRoomViewModel(
      addRoomUseCase: injectAddRoomUseCase()
    );
  }
}

