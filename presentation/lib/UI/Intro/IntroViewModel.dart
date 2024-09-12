import 'package:core/Base/BaseViewModel.dart';
import 'package:presentation/UI/Intro/IntroNavigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroViewModel extends BaseViewModel<IntroNavigator> {

  Future<void> onDonePress()async{

    navigator!.showLoading(message: local!.loading);
    try{
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool("firstTime", false);
      navigator!.goBack();
      navigator!.goToLoginScreen();
    }catch(e){
      navigator!.goBack();
      navigator!.showFailMessage(message: local!.someThingWentWrong);
    }

  }

}