import 'package:core/Base/base_state.dart';
import 'package:domain/Models/Room/room.dart';
import 'package:domain/UseCase/get_general_rooms_use_case.dart';
import 'package:domain/UseCase/get_user_rooms_use_case.dart';
import 'package:presentation/UI/ChatRoom/chat_room_view.dart';
import 'package:presentation/UI/CreateRoom/create_room_view.dart';
import 'package:presentation/UI/Home/Tabs/Chat/chat_tab_navigator.dart';
import 'package:presentation/UI/Home/Tabs/Chat/chat_tab_view_model.dart';
import 'package:presentation/UI/Home/Tabs/Chat/Widgets/public_rooms_widget.dart';
import 'package:presentation/UI/Home/Tabs/Chat/Widgets/user_room_widget.dart';
import 'package:presentation/UI/JoinRoom/join_room_view.dart';
import 'package:presentation/UI/Widgets/custom_search_bar_button.dart';
import 'package:presentation/UI/Widgets/error_message_widget.dart';
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
      create: (context) => viewModel,
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
                  stream: viewModel.getUserRooms(),
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
                      viewModel.userRooms = snapshot.data!.docs.map((e) => e.data().toDomain()).toList();
                      if(viewModel.userRooms.isNotEmpty){
                        return SizedBox(
                          height: 140,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            padding:const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => UserRoomWidget(room: viewModel.userRooms[index] , onPress: viewModel.goToChatRoomScreen),
                            itemCount: viewModel.userRooms.length,
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
                  child: Text(viewModel.local!.publicRooms,style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold),),
                ),
                StreamBuilder(
                  stream: viewModel.getPublicRooms(),
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
                      viewModel.rooms = snapshot.data!.docs.map((e) => e.data().toDomain()).toList();
                      viewModel.filterRooms();
                      return Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          padding:const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                          itemBuilder: (context, index) => PublicRoomsWidget(room: viewModel.rooms[index] , onPress: viewModel.goToJoinRoomScree),
                          itemCount: viewModel.rooms.length,
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
                viewModel.goToCreateRoomScreen();
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
