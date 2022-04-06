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

  void _processPointer(BuildContext context, PointerDownEvent event) {
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
      if (key == _commandsState?.dragging) {
        if (_commandsState?.willRemove ?? false) {
          opacity = 0.1;
        } else {
          opacity = 0.4;
        }
      }
      //opacity = key == _commandsState?.dragging ? (_commandsState?.willRemove ?? false ? 0.1 : 0.4) : 1;
    }

    final Widget content = _buildContent(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Opacity(
        opacity: opacity,
        child: content,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final GameBloc gameBloc = BlocProvider.of<GameBloc>(context);

    if (widget.command is GroupCommand) {
      return IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: CommandBlock(
                isRunningActive: _compareLists((gameBloc.state as GameInProgress).commandIndex, widget.index),
                name: widget.command.name,
                color: widget.command.color,
                onPointerDown: _processPointer,
                command: widget.command,
                isPalette: widget.isPalette,
              ),
            ),
            CommandContainer(
              command: widget.command as GroupCommand,
              index: index,
            ),
          ],
        ),
      );
    } else if (widget.command is SingleCommand) {
      return CommandBlock(
        isRunningActive: _compareLists((gameBloc.state as GameInProgress).commandIndex, widget.index),
        name: widget.command.name,
        color: widget.command.color,
        onPointerDown: _processPointer,
        command: widget.command,
        isPalette: widget.isPalette,
      );
    }

    return Container();
  }

  bool _compareLists(List<int>? first, List<int>? second) {
    if (first == null || second == null) {
      return false;
    }

    if (first.length != second.length) {
      return false;
    }

    for (var i = 0; i < first.length; i++) {
      if (first[i] != second[i]) {
        return false;
      }
    }

    return true;
  }
}
