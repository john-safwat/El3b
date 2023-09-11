import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Domain/Exception/DioServerException.dart';
import 'package:El3b/Domain/Exception/InternetConnectionException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/URLLauncherException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
import 'package:El3b/Domain/Models/Games/FreeToPlayGame/FreeToPlayGame.dart';
import 'package:El3b/Domain/Models/Games/GiveawayGames/GiveawayGame.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:El3b/Domain/UseCase/GetAllGiveGamesUseCase.dart';
import 'package:El3b/Domain/UseCase/GetFreeToPlayGamesUseCase.dart';
import 'package:El3b/Domain/UseCase/GetRAWGGeneralGamesUseCase.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Home/HomeTabNavigator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeTabViewModel extends BaseViewModel <HomeTabNavigator>{

  GetAllGiveGamesUseCase getAllGiveGamesUseCase ;
  GetFreeToPlayGamesUseCase getFreeToPlayGamesUseCase;
  GetRAWGGeneralGamesUseCase getRAWGGeneralGamesUseCase;
  HomeTabViewModel({
    required this.getAllGiveGamesUseCase ,
    required this.getFreeToPlayGamesUseCase,
    required this.getRAWGGeneralGamesUseCase
  });

  // error message and list of games
  String? errorMessage ;
  List<GiveawayGame> listGiveawayGames= [];
  List<FreeToPlayGame> listFreeToPLayGames = [];
  List<RAWGGame> listRAWGGames = [];

  // games selected flags
  bool giveawayGameSelected = false;
  late GiveawayGame giveawaySelectedGame ;
  bool freeToPlayGameSelected = false;
  late FreeToPlayGame freeToPlayGameSelectedGame ;
  bool rawgGameSelected = false;
  late RAWGGame rawgGameSelectedGame ;

  // function to call games apis using use case
  void getGames()async{
    errorMessage = null ;
    listGiveawayGames = [];
    notifyListeners();
    try {
      listGiveawayGames = await getAllGiveGamesUseCase.invoke();
      listFreeToPLayGames = await getFreeToPlayGamesUseCase.invoke();
      listRAWGGames = await getRAWGGeneralGamesUseCase.invoke();
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
      if (await launchUrl(uri, mode: LaunchMode.inAppWebView)){
        navigator!.showSuccessNotification(message: local!.weHopeThatYouLoveIt);
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
  selectGiveawayGame( GiveawayGame game){
    giveawayGameSelected = true;
    giveawaySelectedGame = game;
    notifyListeners();
  }
  // unselect game
  unselectGiveawayGame(){
    giveawayGameSelected = false;
    notifyListeners();
  }

  // select game
  selectFreeToPlayGame( FreeToPlayGame game){
    freeToPlayGameSelected = true;
    freeToPlayGameSelectedGame = game;
    notifyListeners();
  }
  // unselect game
  unselectFreeToPlayGame(){
    freeToPlayGameSelected = false;
    notifyListeners();
  }

}