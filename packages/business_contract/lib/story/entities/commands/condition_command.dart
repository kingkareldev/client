import '../common/condition.dart';

abstract class ConditionCommand {
  Condition? condition;

  static Condition? conditionFromJson(String? condition) {
    switch (condition) {
      case 'canMoveUp':
        return Condition.canMoveUp;
      case 'canMoveRight':
        return Condition.canMoveRight;
      case 'canMoveDown':
        return Condition.canMoveDown;
      case 'canMoveLeft':
        return Condition.canMoveLeft;
      case 'canPutMark':
        return Condition.canPutMark;
      case 'canGrabMark':
        return Condition.canGrabMark;
      default:
        return null;
    }
  }

  static String? conditionToJson(Condition? condition) {
    switch (condition) {
      case Condition.canMoveUp:
        return 'canMoveUp';
      case Condition.canMoveRight:
        return 'canMoveRight';
      case Condition.canMoveDown:
        return 'canMoveDown';
      case Condition.canMoveLeft:
        return 'canMoveLeft';
      case Condition.canPutMark:
        return 'canPutMark';
      case Condition.canGrabMark:
        return 'canGrabMark';
      default:
        return null;
    }
  }
}
