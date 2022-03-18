import 'package:business_contract/mission/game/entities/commands/command.dart';

import '../single_command.dart';

class GrabMarkCommand extends SingleCommand {
  GrabMarkCommand() : super(name: 'grab mark', color: 0xFF00AAFF);

  @override
  Command clone() {
    return GrabMarkCommand();
  }
}
