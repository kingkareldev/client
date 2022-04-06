import 'package:business_contract/story/entities/commands/single_command.dart';

import 'group_command.dart';

abstract class Command {
  final String name;
  final int color;

  Command({required this.name, required this.color});

  Command clone();

  int countSize();

  bool isValid();

  factory Command.fromJson(Map<String, dynamic> json) {
    if (json['children'] != null) {
      return GroupCommand.fromJson(json);
    }

    return SingleCommand.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}
