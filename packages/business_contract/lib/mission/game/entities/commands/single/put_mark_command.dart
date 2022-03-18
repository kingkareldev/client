import 'package:business_contract/mission/game/entities/commands/command.dart';

import '../single_command.dart';

class PutMarkCommand extends SingleCommand {
  PutMarkCommand() : super(name: 'put mark', color: 0xFFFF00FF);

  @override
  Command clone() {
    return PutMarkCommand();
  }
}