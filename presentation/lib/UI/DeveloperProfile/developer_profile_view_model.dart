
import 'package:core/Base/base_view_model.dart';
import 'package:domain/Models/Developers/developers.dart';
import 'package:domain/UseCase/get_game_developer_details_use_case.dart';

class DeveloperProfileViewModel extends BaseViewModel{

  Developer developer;
  GetGameDeveloperDetailsUseCase getGameDeveloperDetailsUseCase;

  DeveloperProfileViewModel({required this.developer ,required this.getGameDeveloperDetailsUseCase});


  String? errorMessage ;
  bool notLoaded = true;

  // function to load data from the api
  getDeveloperDetails()async{
    errorMessage  = null ;
    notLoaded = true;
    notifyListeners();
    try {
      developer = await getGameDeveloperDetailsUseCase.invoke(id: developer.id.toString());
      notLoaded = false;
      notifyListeners();
    }catch (e){
      errorMessage = handleExceptions(e as Exception);
      notifyListeners();
    }
  }


}