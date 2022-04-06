import 'package:business_contract/story/entities/commands/condition_command.dart';

import '../../common/condition.dart';
import '../command.dart';
import '../group_command.dart';

class IfCommand extends GroupCommand implements ConditionCommand {
  @override
  Condition? condition;

  IfCommand({
    this.condition,
    required List<Command> commands,
  }) : super(name: 'if', color: 0xFF00FFAA, commands: commands);

  @override
  Command clone() {
    return IfCommand(condition: condition, commands: List.from(commands));
  }

  @override
  bool isValid() {
    return condition != null && commands.every((element) => element.isValid());
  }

  factory IfCommand.fromJson(Map<String, dynamic> json) {
    List<Command> commands = [];

    for (var command in json['children']) {
      commands.add(Command.fromJson(command));
    }

    return IfCommand(
      condition: ConditionCommand.conditionFromJson(json['condition']),
      commands: commands,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": "if",
      "condition": ConditionCommand.conditionToJson(condition),
      "children": commands,
    };
  }
}
