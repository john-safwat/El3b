import 'package:domain/Models/Games/GameDetails/Requirements.dart';

class RequirementsDTO {
  String? minimum;
  String? recommended;

  RequirementsDTO({this.minimum, this.recommended});

  RequirementsDTO.fromJson(Map<String, dynamic> json) {
    minimum = json['minimum'];
    recommended = json['recommended'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['minimum'] = minimum;
    data['recommended'] = recommended;
    return data;
  }

  Requirements toDomain(){
    return Requirements(
        minimum : minimum ,
        recommended : recommended ,
    );
  }

}