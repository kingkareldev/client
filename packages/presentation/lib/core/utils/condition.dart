import 'package:business_contract/mission/game/entities/common/condition.dart';

import '../l10n/gen/app_localizations.dart';

String convertConditionToString({required Condition? condition, required AppLocalizations localization}) {
  if (condition == null) {
    return localization.gameConditionUnknown;
  }

  switch (condition) {
    case Condition.canMoveUp:
      return localization.gameConditionCanMoveUp;
    case Condition.canMoveRight:
      return localization.gameConditionCanMoveRight;
    case Condition.canMoveDown:
      return localization.gameConditionCanMoveDown;
    case Condition.canMoveLeft:
      return localization.gameConditionCanMoveLeft;
    case Condition.canPutMark:
      return localization.gameConditionCanPlaceMark;
    case Condition.canGrabMark:
      return localization.gameConditionCanGrabMark;
  }
}
