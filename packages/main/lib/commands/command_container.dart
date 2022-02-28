part of 'commands_view.dart';

class CommandContainer extends StatefulWidget {
  final List<int> index;
  final GroupCommand command;
  final bool root;

  const CommandContainer({required this.command, this.root = false, this.index = const [], Key? key}) : super(key: key);

  @override
  _CommandContainerState createState() => _CommandContainerState();
}

class _CommandContainerState extends State<CommandContainer> {
  List<int> get index => widget.index;
  late final Key key;

  _CommandsViewState? _commandsState;

  @override
  void initState() {
    //key = GlobalKey();
    key = ObjectKey(this);

    activate();
    super.initState();
  }

  @override
  void activate() {
    super.activate();
  }

  @override
  void deactivate() {
    _commandsState?.unregisterContainer(this);
    _commandsState = null;
    super.deactivate();
  }

  HashMap<Key, _CommandItemState> get items => _items;
  final _items = HashMap<Key, _CommandItemState>();

  void registerItem(_CommandItemState item) {
    _items[item.key] = item;
  }

  void unregisterItem(_CommandItemState item) {
    if (_items[item.key] == item) {
      _items.remove(item.key);
    }
  }

  GroupCommand get command => widget.command;

  @override
  Widget build(BuildContext context) {
    _commandsState = _CommandsViewState.of(context);
    _commandsState!.registerContainer(this);

    final boxDecoration = BoxDecoration(
      border: Border(
        left: BorderSide(width: widget.root ? 0 : 10, color: Colors.blue),
      ),
    );

    return Container(
      decoration: widget.root ? null : boxDecoration,
      constraints: const BoxConstraints(minHeight: 50),
      child: _buildContainer(),
    );
  }

  Widget _buildContainer() {
    final items = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < command.commands.length; i++) _buildCommandItem(index, i),
      ],
    );

    if (widget.root) {
      return items;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 12, right: 24, bottom: 12),
      child: items,
    );
  }

  Widget _buildCommandItem(List<int> index, int i) {
    final List<int> list = List.from(index);
    list.add(i);
    return CommandItem(
      key: ObjectKey(command.commands[i]),
      command: command.commands[i],
      index: list,
    );
  }

  static _CommandContainerState? of(BuildContext context) {
    return context.findAncestorStateOfType<_CommandContainerState>();
  }

  bool _isChildOfItem(Key itemKey) {
    if (command is RootCommand) {
      print("root");
      return false;
    }

    print("container $itemKey vs ");
    return _CommandItemState.of(context)?.key == itemKey ||
        (_CommandContainerState.of(context)?._isChildOfItem(itemKey) ?? false);
  }
}
