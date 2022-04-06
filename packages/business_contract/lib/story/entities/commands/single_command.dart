import 'package:business_contract/story/entities/commands/single/grab_mark_command.dart';
import 'package:business_contract/story/entities/commands/single/move_command.dart';
import 'package:business_contract/story/entities/commands/single/put_mark_command.dart';

import 'command.dart';

abstract class SingleCommand extends Command {
  SingleCommand({required String name, required int color}): super(name: name, color: color);

  @override
  String toString() {
    return name;
  }

  @override
  bool isValid() {
    return true;
  }

  @override
  int countSize() {
    return 1;
  }

  factory SingleCommand.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'move':
        return MoveCommand.fromJson(json);
      case 'grab_mark':
        return GrabMarkCommand.fromJson(json);
      case 'put_mark':
        return PutMarkCommand.fromJson(json);
      default:
        throw ArgumentError();
    }
  }
}
