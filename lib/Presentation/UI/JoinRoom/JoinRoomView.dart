import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Domain/Models/Room/Room.dart';
import 'package:El3b/Domain/UseCase/AddUserToRoomUseCase.dart';
import 'package:El3b/Presentation/UI/ChatRoom/ChatRoomView.dart';
import 'package:El3b/Presentation/UI/JoinRoom/JoinRoomNavigator.dart';
import 'package:El3b/Presentation/UI/JoinRoom/JoinRoomViewModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JoinRoomView extends StatefulWidget {

  Room room;
  JoinRoomView({required this.room , super.key});

  @override
  State<JoinRoomView> createState() => _JoinRoomViewState();
}

class _JoinRoomViewState extends BaseState<JoinRoomView , JoinRoomViewModel> implements JoinRoomNavigator {

  @override
  void initState() {
    super.initState();
    viewModel.room = widget.room;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text(viewModel.local!.joinRoom),
        ),

        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // The Image of room
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: viewModel.room.image,
                    imageBuilder: (context, imageProvider) => Image(
                      image: imageProvider,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => Container(
                        width: double.infinity,
                        height: 200,
                        color: MyTheme.lightPurple,
                        child: Center(child: Image.asset("Assets/Images/DarkLogo2.png"))
                    ),
                    placeholder: (context, url) => Container(
                      width: double.infinity,
                      height: 200,
                      color: MyTheme.lightPurple,
                      child:const Center(child:  CircularProgressIndicator()),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                // Room Title
                Text(viewModel.room.name , style: Theme.of(context).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.bold , fontSize: 24),),
                const SizedBox(height: 20,),
                Text(viewModel.local!.roomDescription , style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w400)),
                const SizedBox(height: 20,),
                Text(viewModel.room.description, style: Theme.of(context).textTheme.displayMedium),
                const SizedBox(height: 50,),
                ElevatedButton(
                  onPressed: (){
                    viewModel.joinRoom();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(viewModel.local!.joinRoom)
                      ],
                    ),
                  )
                )
              ],
            ),
          ),
        ),

      ),
    );
  }

  @override
  JoinRoomViewModel initViewModel() {
    return JoinRoomViewModel(addUserToRoomUseCase: injectAddUserToRoomUseCase());
  }

  @override
  goToRoomChatScreen(Room room) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatRoomView(room: room,)));
  }
}
