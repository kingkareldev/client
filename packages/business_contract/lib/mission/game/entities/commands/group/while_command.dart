import 'package:business_contract/mission/game/entities/commands/condition_command.dart';

import '../../common/condition.dart';
import '../command.dart';
import '../group_command.dart';

class WhileCommand extends GroupCommand implements ConditionCommand {
  @override
  Condition? condition;

  WhileCommand({
    this.condition,
    required List<Command> commands,
  }) : super(name: 'while', color: 0xFFAAFFAA, commands: commands);

  @override
  Command clone() {
    return WhileCommand(condition: condition, commands: List.from(commands));
  }

  @override
  bool isValid() {
    return condition != null && commands.every((element) => element.isValid());
  }
}
