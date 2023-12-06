import 'package:El3b/Core/Base/BaseViewModel.dart';
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
      errorMessage = handleExceptions(e as Exception);
      notifyListeners();
    }
  }


  goToGameListScreen(String id){
    navigator!.goToGameListScreen(id);
  }

}