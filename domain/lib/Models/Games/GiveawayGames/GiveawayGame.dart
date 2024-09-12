import 'package:data/Models/Games/GiveawayGame/GiveawayGameDTO.dart';

class GiveawayGame {
  GiveawayGame({
      this.title, 
      this.worth,
      this.image,
      this.instructions, 
      this.openGiveawayUrl,
      this.platforms, 
      this.endDate, });

  String? title;
  String? worth;
  String? image;
  String? instructions;
  String? openGiveawayUrl;
  String? platforms;
  String? endDate;
  List<String> icons = [];

  GiveawayGameDTO toData(){
    return GiveawayGameDTO(
        title : title,
        worth : worth,
        image : image,
        instructions : instructions,
        openGiveawayUrl : openGiveawayUrl,
        platforms : platforms,
        endDate : endDate,
    );
  }

}