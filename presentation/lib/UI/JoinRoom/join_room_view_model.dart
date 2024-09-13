import 'package:core/Base/base_view_model.dart';
import 'package:domain/Models/Room/room.dart';
import 'package:domain/UseCase/add_user_to_room_use_case.dart';
import 'package:presentation/UI/JoinRoom/join_room_navigator.dart';

class JoinRoomViewModel extends BaseViewModel<JoinRoomNavigator> {

  AddUserToRoomUseCase addUserToRoomUseCase ;
  JoinRoomViewModel({required this.addUserToRoomUseCase});


  late Room room;


  joinRoom()async{
    navigator!.showLoading(message: local!.loading);
    try{
      await addUserToRoomUseCase.invoke(room, appConfigProvider!.user!);
      navigator!.goBack();
      navigator!.showSuccessMessage(
        message: local!.youJoinedRoom,
        posActionTitle: local!.continueTitle,
        posAction: goToChatRoomScreen
      );
    }catch(e){
      navigator!.goBack();
      navigator!.showFailMessage(
        message: handleExceptions(e as Exception),
        posActionTitle: local!.tryAgain,
      );
    }
  }


  goToChatRoomScreen(){
    navigator!.goToRoomChatScreen(room);
  }

}