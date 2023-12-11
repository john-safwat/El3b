import 'package:El3b/Core/Base/BaseState.dart';
import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Data/Models/Messages/MessageDTO.dart';
import 'package:El3b/Domain/Models/Room/Room.dart';
import 'package:El3b/Domain/UseCase/GetMessagesUseCase.dart';
import 'package:El3b/Domain/UseCase/SendMessageUseCase.dart';
import 'package:El3b/Presentation/UI/ChatRoom/ChatRoomNavigator.dart';
import 'package:El3b/Presentation/UI/ChatRoom/ChatRoomViewModel.dart';
import 'package:El3b/Presentation/UI/ChatRoom/Widgets/MessageWidget.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class ChatRoomView extends StatefulWidget {
  Room room;
  ChatRoomView({required this.room, super.key});

  @override
  State<ChatRoomView> createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends BaseState<ChatRoomView, ChatRoomViewModel>
    implements ChatRoomNavigator {
  @override
  void initState() {
    super.initState();
    viewModel!.room = widget.room;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      child: Consumer<ChatRoomViewModel>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: Text(widget.room.name),
          ),
          body: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child:
                      StreamBuilder(
                        stream: viewModel!.getMessages(),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }else if (snapshot.hasError){
                            return ErrorWidget(viewModel!.handleExceptions(snapshot.error! as Exception));
                          } else {
                            viewModel!.messages =  snapshot.data!.docs.map((e) => e.data().toDomain()).toList();
                            return ListView.builder(
                              reverse: true,
                              itemBuilder: (context, index) => MessageWidget(message: viewModel!.messages[index]),
                              itemCount: viewModel!.messages.length,
                            );
                          }
                        },
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              cursorHeight: 20,
                              style: Theme.of(context).textTheme.displayMedium,
                              cursorColor: MyTheme.lightPurple,
                              keyboardType: TextInputType.text,
                              controller: viewModel!.controller,
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  overlayColor:
                                      MaterialStateProperty.all(Colors.transparent),
                                  onTap: viewModel!.sendMessage,
                                  child:  Padding(
                                    padding:const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20),
                                    child: Icon(
                                      EvaIcons.paper_plane,
                                      color: viewModel!.themeProvider!.isDark()?MyTheme.offWhite:MyTheme.lightPurple,
                                    ),
                                  ),
                                ),
                                prefixIcon: InkWell(
                                  overlayColor:
                                      MaterialStateProperty.all(Colors.transparent),
                                  onTap: () {
                                  },
                                  child:  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10),
                                    child: Icon(
                                      Bootstrap.emoji_smile,
                                      color: viewModel!.themeProvider!.isDark()?MyTheme.offWhite:MyTheme.lightPurple,
                                    ),
                                  ),
                                ),
                                contentPadding: const EdgeInsets.all(20),
                                hintText: viewModel!.local!.message,
                                hintStyle: Theme.of(context).textTheme.displayMedium,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      width: 2,
                                      color: MyTheme.lightPurple,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    width: 2,
                                    color: MyTheme.lightPurple,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      width: 2,
                                      color: MyTheme.lightPurple,
                                    )),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      width: 2,
                                      color: Colors.red,
                                    )),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      width: 2,
                                      color: Colors.red,
                                    )),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10,),
                          ElevatedButton(
                            onPressed: (){},
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                                )
                              )
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 18.0),
                              child: Icon(Bootstrap.mic_fill,color: MyTheme.offWhite,),
                            )
                          )
                        ],
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  ChatRoomViewModel initViewModel() {
    return ChatRoomViewModel(
      getMessagesUseCase: injectGetMessagesUseCase(),
      sendMessageUseCase: injectSendMessageUseCase()
    );
  }
}
