import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Presentation/UI/CreateRoom/CreateRoomNavigator.dart';
import 'package:El3b/Presentation/UI/CreateRoom/CreateRoomViewModel.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel!.local!.createGroup),
      ),
    );
  }

  @override
  CreateRoomViewModel initViewModel() {
    return CreateRoomViewModel();
  }
}
