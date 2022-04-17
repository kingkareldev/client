import 'package:business_contract/story/entities/commands/condition_command.dart';

import '../../common/condition.dart';
import '../command.dart';
import '../group_command.dart';

class WhileCommand extends GroupCommand implements ConditionCommand {
  @override
  Condition? condition;

  WhileCommand({
    this.condition,
    required List<Command> commands,
  }) : super(name: 'while', commands: commands);

  @override
  Command clone() {
    return WhileCommand(condition: condition, commands: List.from(commands));
  }

  @override
  bool isValid() {
    return condition != null && commands.every((element) => element.isValid());
  }

  factory WhileCommand.fromJson(Map<String, dynamic> json) {
    List<Command> commands = [];

    for (var command in json['children']) {
      commands.add(Command.fromJson(command));
    }

    return WhileCommand(
      condition: ConditionCommand.conditionFromJson(json['condition']),
      commands: commands,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": "while",
      "condition": ConditionCommand.conditionToJson(condition),
      "children": commands,
    };
  }
}
