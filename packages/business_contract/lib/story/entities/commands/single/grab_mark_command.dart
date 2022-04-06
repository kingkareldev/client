import 'package:business_contract/story/entities/commands/command.dart';

import '../single_command.dart';

class GrabMarkCommand extends SingleCommand {
  GrabMarkCommand() : super(name: 'grab mark', color: 0xFF00AAFF);

  @override
  Command clone() {
    return GrabMarkCommand();
  }

  factory GrabMarkCommand.fromJson(Map<String, dynamic> json) {
    return GrabMarkCommand();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": "grab_mark",
    };
  }
}
