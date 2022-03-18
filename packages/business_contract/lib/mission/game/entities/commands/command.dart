abstract class Command {
  final String name;
  final int color;

  Command({required this.name, required this.color});

  Command clone();

  int countSize();
  bool isValid();
}
