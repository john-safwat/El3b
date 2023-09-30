import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Domain/Exception/DioServerException.dart';
import 'package:El3b/Domain/Exception/InternetConnectionException.dart';
import 'package:El3b/Domain/Exception/TimeOutOperationsException.dart';
import 'package:El3b/Domain/Exception/UnknownException.dart';
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


}