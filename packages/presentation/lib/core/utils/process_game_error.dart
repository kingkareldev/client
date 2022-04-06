import 'package:business_contract/story/services/game_service/process_game_error.dart';

import '../l10n/gen/app_localizations.dart';

String convertProcessGameErrorToString({required ProcessGameError? error, required AppLocalizations localization}) {
  if (error == null) {
    return localization.gameConditionUnknown;
  }

  switch (error) {
    case ProcessGameError.hasInvalidCommands:
      return localization.processGameErrorHasInvalidCommands;
    case ProcessGameError.invalidMove:
      return localization.processGameErrorInvalidMove;
    case ProcessGameError.invalidPutMark:
      return localization.processGameErrorInvalidPutMark;
    case ProcessGameError.invalidGrabMark:
      return localization.processGameErrorInvalidGrabMark;
    case ProcessGameError.exceededSpeedLimit:
      return localization.processGameErrorExceededSpeedLimit;
  }
}
