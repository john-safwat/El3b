import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Domain/Models/Developers/Developers.dart';
import 'package:El3b/Domain/UseCase/GetGameDeveloperDetailsUseCase.dart';
import 'package:El3b/Presentation/UI/DeveloperProfile/DeveloperProfileNavigator.dart';

class DeveloperProfileViewModel extends BaseViewModel<DeveloperProfileNavigator>{

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