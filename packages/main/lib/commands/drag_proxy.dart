part of 'commands_view.dart';

class DragProxy extends StatefulWidget {
  const DragProxy({Key? key}) : super(key: key);

  @override
  _DragProxyState createState() => _DragProxyState();
}

class _DragProxyState extends State<DragProxy> {
  Widget? _widget;
  Size _size = Size.zero;
  Offset _offset = Offset.zero;

  void setWidget(Widget widget, RenderBox position) {
    setState(() {
      //_decorationOpacity = 1.0;
      _widget = widget;
      final state = _CommandsViewState.of(context)!;
      RenderBox renderBox = state.context.findRenderObject() as RenderBox;
      _offset = position.localToGlobal(Offset.zero, ancestor: renderBox);
      _size = position.size;
    });
  }

  void updateOffset(Offset offset) {
    setState(() {
      _offset += offset;
    });
  }

  void hide() {
    setState(() {
      _widget = null;
    });
  }

  @override
  void initState() {
    activate();
    super.initState();
  }

  @override
  void activate() {
    final state = _CommandsViewState.of(context)!;
    state._dragProxy = this;
    super.activate();
  }

  @override
  void deactivate() {
    _CommandsViewState.of(context)?._dragProxy = null;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    if (_widget != null) {
      final w = MouseRegion(
        cursor: SystemMouseCursors.grabbing,
        child: IgnorePointer(
          child: MediaQuery.removePadding(
            context: context,
            child: _widget!,
            removeTop: true,
            removeBottom: true,
          ),
        ),
      );

      return Positioned(
        child: MouseRegion(
          cursor: SystemMouseCursors.grabbing,
          child: w,
        ),
        top: _offset.dy,
        left: _offset.dx,
        width: _size.width,
      );
    } else {
      return const SizedBox(width: 0.0, height: 0.0);
    }
  }
}
