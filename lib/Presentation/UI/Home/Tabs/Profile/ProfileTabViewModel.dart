import 'package:El3b/Core/Base/BaseViewModel.dart';
import 'package:El3b/Presentation/UI/Home/Tabs/Profile/ProfileTabNavigator.dart';

class ProfileTabViewModel extends BaseViewModel <ProfileTabNavigator> {



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

  }
  // function to to about us Screen
  goToAboutUsScreen(){

  }


  // Function to sign out user
  signOut(){

  }

}