import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Domain/Models/Room/Room.dart';
import 'package:El3b/Domain/UseCase/AddUserToRoomUseCase.dart';
import 'package:El3b/Presentation/UI/JoinRoom/JoinRoomNavigator.dart';

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