import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Domain/Exception/FirebaseImagesException.dart';
import 'package:El3b/Domain/Exception/FirebaseUserAuthException.dart';
import 'package:El3b/Domain/Exception/FirebaseUserDatabaseException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
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
      if (e is FirebaseImagesException) {
        navigator!.showFailMessage(
          message: e.errorMessage,
          posActionTitle: local!.tryAgain,
        );
      } else if (e is FirebaseUserAuthException) {
        navigator!.showFailMessage(
          message: e.errorMessage,
          posActionTitle: local!.tryAgain,
        );
      } else if (e is TimeOutOperationsException) {
        navigator!.showFailMessage(
          message: e.errorMessage,
          posActionTitle: local!.tryAgain,
        );
      } else if (e is UnknownException) {
        navigator!.showFailMessage(
          message: e.errorMessage,
          posActionTitle: local!.tryAgain,
        );
      }else if (e is FirebaseFireStoreDatabaseException) {
        navigator!.showFailMessage(
          message: e.errorMessage,
          posActionTitle: local!.tryAgain,
        );
      } else {
        navigator!.showFailMessage(
          message: e.toString(),
          posActionTitle: local!.tryAgain,
        );
      }
    }
  }


  goToChatRoomScreen(){
    navigator!.goToRoomChatScreen(room);
  }

}