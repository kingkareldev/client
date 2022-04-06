import 'package:business_contract/story/entities/commands/command.dart';
import 'package:business_contract/story/entities/commands/direction_command.dart';

import '../../common/direction.dart';
import '../single_command.dart';

class MoveCommand extends SingleCommand implements DirectionCommand {
  @override
  Direction? direction;

  MoveCommand({this.direction}) : super(name: 'move', color: 0xFF0000FF);

  @override
  Command clone() {
    return MoveCommand(direction: direction);
  }

  @override
  bool isValid() {
    return direction != null;
  }

  factory MoveCommand.fromJson(Map<String, dynamic> json) {
    return MoveCommand(
      direction: DirectionCommand.directionFromJson(json['direction']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": "move",
      "direction": DirectionCommand.directionToJson(direction),
    };
  }
}
