import 'package:business_contract/story/entities/common/direction.dart';

import '../l10n/gen/app_localizations.dart';

String convertDirectionToString({required Direction? direction, required AppLocalizations localization}) {
  if (direction == null) {
    return localization.gameDirectionUnknown;
  }

  switch (direction) {
    case Direction.up:
      return localization.gameDirectionUp;
    case Direction.right:
      return localization.gameDirectionRight;
    case Direction.down:
      return localization.gameDirectionDown;
    case Direction.left:
      return localization.gameDirectionLeft;
  }
}
