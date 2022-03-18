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
}
