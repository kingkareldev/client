import 'package:business_contract/story/entities/commands/group/if_command.dart';

import 'command.dart';
import 'group/root_command.dart';
import 'group/while_command.dart';
import 'single_command.dart';

abstract class GroupCommand extends Command {
  final List<Command> commands;

  GroupCommand({required String name, int color = 0xFFFFDB0F, required this.commands}): super(name: name, color: color);

  @override
  String toString() {
    return "'$name' + $commands";
  }

  void insertAt(List<int> index, Command command) {
    if (index.isEmpty) {
      return;
    }

    if (index.length == 1) {
      commands.insert(index.first, command);
      return;
    }

    Command child = commands[index.first];
    if (child is GroupCommand) {
      child.insertAt(index.sublist(1), command);
    }
  }

  Command? removeAt(List<int> index) {
    // print("removeAt ${index}");
    if (index.length == 1) {
      // print("removeAt == 1, ${index.first} / ${commands.length}");
      // print("commands $commands");
      if (index.first >= commands.length) {
        return null;
      }
      return commands.removeAt(index.first);
    }

    Command child = commands[index.first];
    if (child is GroupCommand) {
      // print("removeAt is GroupCommand, ${index.sublist(1)}");
      return child.removeAt(index.sublist(1));
    }

    return null;
  }

  Command? commandAt(List<int> index) {
    // print("commandAt ${index}");
    if (index.isEmpty) {
      return this;
    }

    if (index.length == 1) {
      if (index.first >= commands.length) {
        return null;
      }

      return commands.elementAt(index.first);
    }

    Command child = commands[index.first];
    if (child is GroupCommand) {
      return child.commandAt(index.sublist(1));
    } else if (child is SingleCommand) {
      return child;
    }

    return null;
  }

  @override
  int countSize() {
    int subcommandsSize = 0;

    for (var value in commands) {
      subcommandsSize += value.countSize();
    }

    return 1 + subcommandsSize;
  }

  factory GroupCommand.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'root':
        return RootCommand.fromJson(json);
      case 'if':
        return IfCommand.fromJson(json);
      case 'while':
        return WhileCommand.fromJson(json);
      default:
        throw ArgumentError();
    }
  }
}
