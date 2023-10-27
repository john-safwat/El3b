import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Domain/UseCase/GetUserRoomsUseCase.dart';
import 'package:El3b/Presentation/UI/CreateRoom/CreateRoomView.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Chat/ChatTabNavigator.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Chat/ChatTabViewModel.dart';
import 'package:El3b/Presentation/UI/Widgets/CustomSearchBarButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatTabView extends StatefulWidget {
  const ChatTabView({super.key});

  @override
  State<ChatTabView> createState() => _ChatTabViewState();
}

class _ChatTabViewState extends BaseState<ChatTabView , ChatTabViewModel > implements ChatTabNavigator {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      child: Consumer<ChatTabViewModel>(
        builder: (context, value, child) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 70,
              titleSpacing: 10,
              centerTitle: true,
              leadingWidth: 0,
              title: CustomSearchBarButton(navigation: (){},),
            ),
            body: Column(

            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                viewModel!.goToCreateRoomScreen();
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  @override
  ChatTabViewModel initViewModel() {
    return ChatTabViewModel(
      getUserRoomsUseCase: injectGetUserRoomsUseCase()
    );
  }

  @override
  goToCreateRoomScreen() {
    Navigator.pushNamed(context, CreateRoomView.routeName);
  }
}
