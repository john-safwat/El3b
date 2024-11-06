class Constants {

  Constants._();
  static Constants? instance;
  static getInstance(){
    return instance??= Constants._();
  }

  final String userCollection = "Users";
  final String imagesFolderName = "images";
  final String feedbacksCollection = "Feedback";
  final String roomsCollection = "Rooms";
  final String messagesCollection = "Messages";
  final String freeToPlayImageTag = "FreeToPlayGamesImageTag";
  final String giveawayGamesImageTag = "GiveawayGamesImageTag";
  final String rawgGamesImageTag = "RAWGGamesImageTag";

}