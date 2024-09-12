import 'package:core/Base/base_state.dart';
import 'package:core/Theme/theme.dart';
import 'package:domain/Models/Room/room.dart';
import 'package:domain/UseCase/get_messages_use_case.dart';
import 'package:domain/UseCase/send_message_use_case.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:presentation/UI/ChatRoom/ChatRoomNavigator.dart';
import 'package:presentation/UI/ChatRoom/ChatRoomViewModel.dart';
import 'package:presentation/UI/ChatRoom/Widgets/MessageWidget.dart';
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
    viewModel.room = widget.room;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<ChatRoomViewModel>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: Text(widget.room.name),
            actions: [
              PopupMenuButton<Widget>(
                color: Theme.of(context).scaffoldBackgroundColor,
                itemBuilder: (BuildContext context) => <PopupMenuEntry<Widget>>[
                  PopupMenuItem<Widget>(
                    onTap: () => value.onMoreInfoPress(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          value.local!.info,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<Widget>(
                    onTap: () => value.onExitPress(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          value.local!.exit,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
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
                        stream: viewModel.getMessages(),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }else if (snapshot.hasError){
                            return ErrorWidget(viewModel.handleExceptions(snapshot.error! as Exception));
                          } else {
                            viewModel.messages =  snapshot.data!.docs.map((e) => e.data().toDomain()).toList();
                            if(viewModel.messages.isEmpty){
                              return Center(
                                child: Lottie.asset("Assets/Animations/messages.json"),
                              );
                            }
                            return ListView.builder(
                              reverse: true,
                              itemBuilder: (context, index) => MessageWidget(message: viewModel.messages[index]),
                              itemCount: viewModel.messages.length,
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
                              controller: viewModel.controller,
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  overlayColor:
                                      WidgetStateProperty.all(Colors.transparent),
                                  onTap: viewModel.sendMessage,
                                  child:  Padding(
                                    padding:const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20),
                                    child: Icon(
                                      EvaIcons.paper_plane,
                                      color: viewModel.themeProvider!.isDark()?MyTheme.offWhite:MyTheme.lightPurple,
                                    ),
                                  ),
                                ),
                                prefixIcon: InkWell(
                                  overlayColor:
                                      WidgetStateProperty.all(Colors.transparent),
                                  onTap: () {
                                  },
                                  child:  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10),
                                    child: Icon(
                                      EvaIcons.smiling_face_outline,
                                      color: viewModel.themeProvider!.isDark()?MyTheme.offWhite:MyTheme.lightPurple,
                                    ),
                                  ),
                                ),
                                contentPadding: const EdgeInsets.all(20),
                                hintText: viewModel.local!.message,
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
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                                )
                              )
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 18.0),
                              child: Icon(EvaIcons.mic_outline,color: MyTheme.offWhite,),
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
