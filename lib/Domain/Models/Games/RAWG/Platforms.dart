import 'package:El3b/Domain/Models/Games/RAWG/Platform.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RequirementsEn.dart';

class Platforms {
  Platform? platform;
  String? releasedAt;
  RequirementsEn? requirementsEn;
  RequirementsEn? requirementsRu;

  Platforms(
      { this.platform,
        this.releasedAt,
        this.requirementsEn,
        this.requirementsRu});

}
