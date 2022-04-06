import 'package:business_contract/story/entities/commands/command.dart';

import '../single_command.dart';

class PutMarkCommand extends SingleCommand {
  PutMarkCommand() : super(name: 'put mark', color: 0xFFFF00FF);

  @override
  Command clone() {
    return PutMarkCommand();
  }

  factory PutMarkCommand.fromJson(Map<String, dynamic> json) {
    return PutMarkCommand();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": "put_mark",
    };
  }
}
