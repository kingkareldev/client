part of 'commands_view.dart';

class CommandItem extends StatefulWidget {
  final Command command;
  final List<int> index;

  const CommandItem({required this.command, this.index = const [], Key? key}) : super(key: key);

  @override
  _CommandItemState createState() => _CommandItemState();
}

class _CommandItemState extends State<CommandItem> {
  late final Key key;

  List<int> get index => widget.index;

  _CommandsViewState? _commandsState;
  _CommandContainerState? _containerState;

  @override
  void initState() {
    key = ObjectKey(this);
    super.initState();
  }

  @override
  void deactivate() {
    _commandsState?.unregisterItem(this);
    _commandsState = null;
    _containerState?.unregisterItem(this);
    _containerState = null;
    super.deactivate();
  }

  void update() {
    if (mounted) {
      setState(() {});
    }
  }

  void _processPointer(BuildContext context, event) {
    _commandsState?.startDragging(
      stateKey: key,
      event: event,
    );
  }

  @override
  Widget build(BuildContext context) {
    _commandsState = _CommandsViewState.of(context);
    _commandsState!.registerItem(this);
    _containerState = _CommandContainerState.of(context);
    _containerState?.registerItem(this);

    if (widget.command is RootCommand) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: CommandContainer(
          //key: ObjectKey(command),
          command: widget.command as GroupCommand,
          root: true,
          index: index,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Opacity(
        opacity: key == _commandsState?._dragging ? 0.3 : 1,
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (widget.command is GroupCommand) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCodeBlock("Group ${(widget.command as GroupCommand).name}"),
          CommandContainer(
            command: widget.command as GroupCommand,
            index: index,
          ),
        ],
      );
    } else if (widget.command is SingleCommand) {
      return _buildCodeBlock("Item ${(widget.command as SingleCommand).name}");
    }

    return Container();
  }

  Widget _buildCodeBlock(String name) {
    return MouseRegion(
      cursor: SystemMouseCursors.grab,
      child: Listener(
        onPointerDown: (event) => _processPointer(context, event),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.blue, // TODO: use color from Command
          ),
          child: Text(
            "$index $name state:${key}, widget:${widget.key}, command:${widget.command.hashCode}",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
