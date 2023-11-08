import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Domain/Models/Room/Room.dart';
import 'package:El3b/Domain/UseCase/GetGeneralRoomsUseCase.dart';
import 'package:El3b/Domain/UseCase/GetUserRoomsUseCase.dart';
import 'package:El3b/Presentation/UI/ChatRoom/ChatRoomView.dart';
import 'package:El3b/Presentation/UI/CreateRoom/CreateRoomView.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Chat/ChatTabNavigator.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Chat/ChatTabViewModel.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Chat/Widgets/PublicRoomsWidget.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Chat/Widgets/UserRoomWidget.dart';
import 'package:El3b/Presentation/UI/JoinRoom/JoinRoomView.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder(
                  stream: viewModel!.getUserRooms(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Row(
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
                      viewModel!.userRooms = snapshot.data!.docs.map((e) => e.data().toDomain()).toList();
                      if(viewModel!.userRooms.isNotEmpty){
                        return SizedBox(
                          height: 140,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            padding:const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => UserRoomWidget(room: viewModel!.userRooms[index] , onPress: viewModel!.goToChatRoomScreen),
                            itemCount: viewModel!.userRooms.length,
                            separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 15,) ,
                          ),
                        );
                      }else {
                        return const SizedBox();
                      }
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0 , vertical: 10),
                  child: Text(viewModel!.local!.publicRooms,style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold),),
                ),
                StreamBuilder(
                  stream: viewModel!.getPublicRooms(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: value.themeProvider!.isDark()
                              ? Lottie.asset("Assets/Animations/loading2.json",
                              width: 150, height: 120)
                              : Lottie.asset("Assets/Animations/loading3.json",
                              width: 300, height: 300),
                        ),
                      );
                    }else if (snapshot.hasError){
                      return Expanded(
                        child: ErrorMessageWidget(
                            errorMessage: value.errorMessage!,
                            fixErrorFunction: (){}),
                      );
                    }else {
                      viewModel!.rooms = snapshot.data!.docs.map((e) => e.data().toDomain()).toList();
                      viewModel!.filterRooms();
                      return Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          padding:const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                          itemBuilder: (context, index) => PublicRoomsWidget(room: viewModel!.rooms[index] , onPress: viewModel!.goToJoinRoomScree),
                          itemCount: viewModel!.rooms.length,
                          separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 15,) ,
                        ),
                      );
                    }
                  },
                ),
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
      getUserRoomsUseCase: injectGetUserRoomsUseCase(),
      getGeneralRoomsUseCase: injectGetGeneralRoomsUseCase()
    );
  }

  @override
  goToCreateRoomScreen() {
    Navigator.pushNamed(context, CreateRoomView.routeName);
  }

  @override
  goToJoinRoomView(Room room) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => JoinRoomView(room: room,)));
  }

  @override
  goToChatRoomScreen(Room room) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoomView(room: room,)));
  }
}
