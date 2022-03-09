import 'dart:ui';

abstract class Command {
  Color get color;
  Command clone();
}

class SingleCommand extends Command {
  final String name;

  SingleCommand(this.name);

  @override
  String toString() {
    return name;
  }

  @override
  SingleCommand clone() {
    return SingleCommand(name);
  }

  @override
  Color get color => const Color(0xFF0000FF);
}

class GroupCommand extends Command {
  final String name;
  final List<Command> commands;

  GroupCommand(this.name, this.commands);

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
  GroupCommand clone() {
    return GroupCommand(name, List.from(commands));
  }

  @override
  Color get color => const Color(0xFFFF0000);
}

class RootCommand extends GroupCommand {
  RootCommand(List<Command> commands) : super('root', commands);

  @override
  Color get color => const Color(0xFF00FF00);

  @override
  RootCommand clone() {
    return RootCommand(List.from(commands));
  }
}
