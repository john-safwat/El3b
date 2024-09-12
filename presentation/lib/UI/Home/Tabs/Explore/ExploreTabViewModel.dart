import 'package:core/Base/base_view_model.dart';
import 'package:domain/Models/Genres/genre.dart';
import 'package:domain/UseCase/get_genres_use_case.dart';
import 'package:presentation/UI/Home/Tabs/Explore/ExploreTabNavigator.dart';

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