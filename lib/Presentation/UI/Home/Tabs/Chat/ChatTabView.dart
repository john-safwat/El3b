import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Chat/ChatTabNavigator.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Chat/ChatTabViewModel.dart';
import 'package:flutter/material.dart';

class ChatTabView extends StatefulWidget {
  const ChatTabView({super.key});

  @override
  State<ChatTabView> createState() => _ChatTabViewState();
}

class _ChatTabViewState extends BaseState<ChatTabView , ChatTabViewModel > implements ChatTabNavigator {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }

  @override
  ChatTabViewModel initViewModel() {
    return ChatTabViewModel();
  }
}
