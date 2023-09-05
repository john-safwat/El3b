import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Domain/Exception/DioServerException.dart';
import 'package:El3b/Domain/Exception/InternetConnectionException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
import 'package:El3b/Domain/Models/Games/GiveawayGames/GiveawayGames.dart';
import 'package:El3b/Domain/UseCase/GetAllGiveGamesUseCase.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/HomeTabNavigator.dart';

class HomeTabViewModel extends BaseViewModel <HomeTabNavigator>{

  GetAllGiveGamesUseCase getAllGiveGamesUseCase ;
  HomeTabViewModel({required this.getAllGiveGamesUseCase});

  // error message and list of games
  String? errorMessage ;
  List<GiveawayGames> listGiveawayGames= [];

  // function to call games apis using use case
  void getGames()async{
    errorMessage = null ;
    listGiveawayGames = [];
    notifyListeners();
    try {
      listGiveawayGames = await getAllGiveGamesUseCase.invoke();
    }catch(e){
      if (e is DioServerException) {
        errorMessage = e.errorMessage;
      } else if (e is TimeOutOperationsException) {
        errorMessage = local!.operationTimedOut;
      } else if (e is InternetConnectionException) {
        errorMessage = local!.checkYourInternetConnection;
      } else if (e is UnknownException) {
        errorMessage = e.errorMessage;
      } else{
        errorMessage = e.toString();
      }
    }
    notifyListeners();
  }


}