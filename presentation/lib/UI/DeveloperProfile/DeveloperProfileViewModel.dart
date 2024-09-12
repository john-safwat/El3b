
import 'package:core/Base/BaseViewModel.dart';
import 'package:domain/Models/Developers/Developers.dart';
import 'package:domain/UseCase/GetGameDeveloperDetailsUseCase.dart';
import 'package:presentation/UI/DeveloperProfile/DeveloperProfileNavigator.dart';

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