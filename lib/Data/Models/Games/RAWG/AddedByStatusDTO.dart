import 'package:El3b/Domain/Models/Games/RAWG/AddedByStatus.dart';

class AddedByStatusDTO {
  num? yet;
  num? owned;
  num? beaten;
  num? toplay;
  num? dropped;
  num? playing;

  AddedByStatusDTO(
      { this.yet,
        this.owned,
        this.beaten,
        this.toplay,
        this.dropped,
        this.playing});

  AddedByStatusDTO.fromJson(Map<String, dynamic> json) {
    yet = json['yet'];
    owned = json['owned'];
    beaten = json['beaten'];
    toplay = json['toplay'];
    dropped = json['dropped'];
    playing = json['playing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['yet'] = yet;
    data['owned'] = owned;
    data['beaten'] = beaten;
    data['toplay'] = toplay;
    data['dropped'] = dropped;
    data['playing'] = playing;
    return data;
  }

  AddedByStatus toDomain(){
    return AddedByStatus(
        yet : yet ,
        owned : owned ,
        beaten : beaten ,
        toplay : toplay ,
        dropped : dropped ,
        playing : playing ,
    );
  }
}
