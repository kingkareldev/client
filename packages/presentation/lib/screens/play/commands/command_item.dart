part of 'commands_view.dart';

class CommandItem extends StatefulWidget {
  final Command command;
  final List<int> index;
  final bool isPalette;

  const CommandItem({required this.command, this.index = const [], this.isPalette = false, Key? key}) : super(key: key);

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

  static _CommandItemState? of(BuildContext context) {
    return context.findAncestorStateOfType<_CommandItemState>();
  }

  @override
  Widget build(BuildContext context) {
    _commandsState = _CommandsViewState.of(context);
    _commandsState!.registerItem(this);
    _containerState = _CommandContainerState.of(context);
    _containerState?.registerItem(this);

    if (widget.command is RootCommand) {
      return Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20, left: 16),
        child: CommandContainer(
          //key: ObjectKey(command),
          command: widget.command as GroupCommand,
          root: true,
          index: index,
        ),
      );
    }

    double opacity = 1;
    if (!widget.isPalette) {
      opacity = key == _commandsState?.dragging ? (_commandsState?.willRemove ?? false ? 0.1 : 0.4) : 1;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Opacity(
        opacity: opacity,
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (widget.command is GroupCommand) {
      return IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: _buildCodeBlock("Group ${(widget.command as GroupCommand).name}"),
            ),
            CommandContainer(
              command: widget.command as GroupCommand,
              index: index,
            ),
          ],
        ),
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
          decoration: BoxDecoration(
            color: Color(widget.command.color),
          ),
          child: Text(
            name,
            // "$index $name state:${key}, widget:${widget.key}, command:${widget.command.hashCode}",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
