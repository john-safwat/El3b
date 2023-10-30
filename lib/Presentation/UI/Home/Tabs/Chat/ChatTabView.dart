import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Domain/UseCase/GetUserRoomsUseCase.dart';
import 'package:El3b/Presentation/UI/CreateRoom/CreateRoomView.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Chat/ChatTabNavigator.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Chat/ChatTabViewModel.dart';
import 'package:El3b/Presentation/UI/Widgets/CustomSearchBarButton.dart';
import 'package:El3b/Presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
              children: [
                StreamBuilder(
                  stream: viewModel!.getUserRooms(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: value.themeProvider!.isDark()
                                ? Lottie.asset("Assets/Animations/loading2.json",
                                width: 150, height: 120)
                                : Lottie.asset("Assets/Animations/loading3.json",
                                width: 300, height: 300),
                          ),
                        ],
                      );
                    }else if (snapshot.hasError){
                      return ErrorMessageWidget(
                          errorMessage: value.errorMessage!,
                          fixErrorFunction: (){});
                    }else {
                      return Container(

                      );
                    }
                  },
                )
              ],
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
