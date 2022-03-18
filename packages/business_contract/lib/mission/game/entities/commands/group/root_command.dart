import '../command.dart';
import '../group_command.dart';

class RootCommand extends GroupCommand {
  RootCommand(List<Command> commands) : super(name: 'root', color: 0x00000000, commands: commands);

  @override
  RootCommand clone() {
    return RootCommand(List.from(commands));
  }

  @override
  bool isValid() {
    return commands.every((element) => element.isValid());
  }

  @override
  int countSize() {
    int subcommandsSize = 0;

    for (var value in commands) {
      subcommandsSize += value.countSize();
    }

    return subcommandsSize;
  }
}
