
class RequirementsEnDTO {
  String? minimum;
  String? recommended;

  RequirementsEnDTO({this.minimum, this.recommended});

  RequirementsEnDTO.fromJson(Map<String, dynamic> json) {
    minimum = json['minimum'];
    recommended = json['recommended'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['minimum'] = minimum;
    data['recommended'] = recommended;
    return data;
  }
}