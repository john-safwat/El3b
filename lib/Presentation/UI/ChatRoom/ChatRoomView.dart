import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Domain/Models/Room/Room.dart';
import 'package:El3b/Presentation/UI/ChatRoom/ChatRoomNavigator.dart';
import 'package:El3b/Presentation/UI/ChatRoom/ChatRoomViewModel.dart';
import 'package:flutter/material.dart';

class ChatRoomView extends StatefulWidget {

  Room room;
  ChatRoomView({required this.room , super.key});

  @override
  State<ChatRoomView> createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends BaseState<ChatRoomView , ChatRoomViewModel> implements ChatRoomNavigator {

  @override
  void initState() {
    super.initState();
    viewModel!.room = widget.room;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.room.name),
      ),
    );
  }

  @override
  ChatRoomViewModel initViewModel() {
    return ChatRoomViewModel();
  }
}
