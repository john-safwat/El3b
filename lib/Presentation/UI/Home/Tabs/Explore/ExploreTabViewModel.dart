import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Domain/Exception/DioServerException.dart';
import 'package:El3b/Domain/Exception/InternetConnectionException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
import 'package:El3b/Domain/Models/Genres/Genre.dart';
import 'package:El3b/Domain/UseCase/GetGenresUseCase.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Explore/ExploreTabNavigator.dart';

class ExploreTabViewModel extends BaseViewModel <ExploreTabNavigator> {

  GetGenresUseCase getGenresUseCase;
  ExploreTabViewModel({required this.getGenresUseCase });

  String? errorMessage;
  List<Genre> genres =[];

  // function to load all genres from server
  void getGenres()async{
    errorMessage = null;
    genres = [];
    try {
      genres = await getGenresUseCase.invoke();
      notifyListeners();
    }catch(e){
      if (e is DioServerException) {
        errorMessage = e.errorMessage;
      } else if (e is TimeOutOperationsException) {
        errorMessage = local!.operationTimedOut;
      } else if (e is InternetConnectionException) {
        errorMessage = local!.checkYourInternetConnection;
      } else if (e is UnknownException) {
        errorMessage = e.errorMessage;
      } else {
        errorMessage = e.toString();
      }
      notifyListeners();
    }
  }


  goToGameListScreen(String id){
    navigator!.goToGameListScreen(id);
  }

}