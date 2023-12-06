import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Domain/UseCase/SignUserOutUseCase.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Profile/ProfileTabNavigator.dart';

class ProfileTabViewModel extends BaseViewModel <ProfileTabNavigator> {

  SignUserOutUseCase useCase ;
  ProfileTabViewModel({required this.useCase});

  // function to navigate to Edit Profile Screen
  goToEditProfileScreen(){
    navigator!.goToEditProfileScreen();
  }

  // function to go to History Screen
  goToHistoryScreen(){
    navigator!.goToHistoryScreen();
  }
  // function to go to feedback screen
  goToFeedbackScreen(){
    navigator!.goToFeedbackScreen();
  }
  // function to to about us Screen
  goToAboutUsScreen(){
    navigator!.goToAboutUsScreen();
  }


  // Function to sign out user
  onSignOutPress(){
    navigator!.showQuestionMessage(message: local!.areYouSureToExit , negativeActionTitle: local!.cancel , posActionTitle:local!.ok , posAction: signOut);
  }

  signOut()async{
    navigator!.showLoading(message: local!.loading);
    try{
      await useCase.invoke();
      navigator!.goBack();
      navigator!.goToLoginScreen();
    }catch(e) {
      navigator!.goBack();
      navigator!.showFailMessage(
        message: handleExceptions(e as Exception),
        posActionTitle: local!.tryAgain,
      );
    }
  }

}