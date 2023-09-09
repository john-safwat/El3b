import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Domain/Exception/DioServerException.dart';
import 'package:El3b/Domain/Exception/InternetConnectionException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/URLLauncherException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
import 'package:El3b/Domain/Models/Games/GiveawayGames/GiveawayGames.dart';
import 'package:El3b/Domain/UseCase/GetAllGiveGamesUseCase.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/HomeTabNavigator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeTabViewModel extends BaseViewModel <HomeTabNavigator>{

  GetAllGiveGamesUseCase getAllGiveGamesUseCase ;
  HomeTabViewModel({required this.getAllGiveGamesUseCase});

  // error message and list of games
  String? errorMessage ;
  List<GiveawayGames> listGiveawayGames= [];

  // games selected flags
  bool giveawayGameSelected = false;
  late GiveawayGames giveawaySelectedGames ;
  bool freeToPlayGameSelected = false;
  bool gameSelected = false;

  // function to call games apis using use case
  void getGames()async{
    errorMessage = null ;
    listGiveawayGames = [];
    notifyListeners();
    try {
      listGiveawayGames = await getAllGiveGamesUseCase.invoke();
      giveawaySelectedGames = listGiveawayGames[0];
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

  // openGameURL
  openURL(String url)async{
    // parse the url string to uri
    Uri uri = Uri.parse(url);
    try{
      // check if the uri can be launched then it will launch else it will throw and show notification
      if (await canLaunchUrl(uri)){
        await launchUrl(
          uri,
          mode: LaunchMode.inAppWebView
        );
      }else {
        throw URLLauncherException(errorMessage: local!.urlLaunchingError);
      }
    }catch(e){
      if(e is URLLauncherException){
        navigator!.showErrorNotification(message: e.errorMessage);
      }
    }
  }

  // change state functions
  // select game
  selectGiveawayGame( GiveawayGames game){
    giveawayGameSelected = true;
    giveawaySelectedGames = game;
    notifyListeners();
  }
  // unselect game
  unselectGame(){
    giveawayGameSelected = false;
    notifyListeners();
  }

}