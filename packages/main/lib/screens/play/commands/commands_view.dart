import 'dart:collection';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:main/screens/play/commands/model/command.dart';

part 'command_container.dart';

part 'command_item.dart';

part 'drag_proxy.dart';

class CommandsView extends StatefulWidget {
  const CommandsView({Key? key}) : super(key: key);

  @override
  _CommandsViewState createState() => _CommandsViewState();
}

class _CommandsViewState extends State<CommandsView> {
  Key? _dragging;

  Key? get dragging => _dragging;
  Key? _draggingWidgetKey;

  Key? _willBeDraggedFromPalette;

  bool _canUpdate = true;

  bool _willRemove = false;

  bool get willRemove => _willRemove;

  _DragProxyState? _dragProxy;

  DragGestureRecognizer? _recognizer;

  late List<Command> _commandPalette;

  HashMap<Key, _CommandItemState> get items => _items;
  final _items = HashMap<Key, _CommandItemState>();

  @override
  void initState() {
    _commandPalette = [
      SingleCommand('move'),
      SingleCommand('grab'),
      SingleCommand('put'),
      GroupCommand('if', []),
    ];
    super.initState();
  }

  void registerItem(_CommandItemState item) {
    _items[item.key] = item;

    if (_dragging == null) {
      return;
    }

    // Update dragging key after the palette item moved to the tree view.
    if (_willBeDraggedFromPalette != null && _willBeDraggedFromPalette == item.widget.key) {
      _dragging = item.key;
    }

    // Update dragging key after the dragged item moved across the different tree levels.
    if (_draggingWidgetKey == item.widget.key && _dragging != item.key) {
      _dragging = item.key;
    }
  }

  void unregisterItem(_CommandItemState item) {
    if (_items[item.key] == item) {
      _items.remove(item.key);
    }
  }

  HashMap<Key, _CommandContainerState> get containers => _containers;
  final _containers = HashMap<Key, _CommandContainerState>();

  void registerContainer(_CommandContainerState container) {
    _containers[container.key] = container;
  }

  void unregisterContainer(_CommandContainerState container) {
    if (_containers[container.key] == container) {
      _containers.remove(container.key);
    }
  }

  @override
  void dispose() {
    _recognizer?.dispose();
    super.dispose();
  }

  static _CommandsViewState? of(BuildContext context) {
    return context.findAncestorStateOfType<_CommandsViewState>();
  }

  // GroupCommand rootCommand = RootCommand([
  //   SingleCommand('a'),
  //   SingleCommand('b'),
  //   SingleCommand('c'),
  //   SingleCommand('d'),
  //   SingleCommand('e'),
  //   GroupCommand('lol', []),
  //   GroupCommand('lol2', []),
  //   GroupCommand('lol3', []),
  // ]);

  GroupCommand rootCommand = RootCommand([
    SingleCommand('a'),
    GroupCommand('1', [
      SingleCommand('2'),
      SingleCommand('3'),
      SingleCommand('4'),
    ]),
    SingleCommand('b'),
    GroupCommand('c', [
      SingleCommand('d'),
      SingleCommand('e'),
      GroupCommand('f', [
        SingleCommand('g'),
        SingleCommand('h'),
        GroupCommand('i', [
          SingleCommand('j1'),
          SingleCommand('j2'),
          SingleCommand('j3'),
        ]),
      ]),
      SingleCommand('k'),
    ]),
    SingleCommand('l'),
    SingleCommand('m'),
  ]);

  void _appendItem(List<int> itemIndex, List<int> containerIndex) {
    if (itemIndex.isEmpty) {
      return;
    }
    // print("append item $itemIndex to container $containerIndex");

    if (itemIndex.length == containerIndex.length) {
      bool isTheSame = true;
      for (int i = 0; i < itemIndex.length; i++) {
        if (itemIndex[i] != containerIndex[i]) {
          isTheSame = false;
          break;
        }
      }
      if (isTheSame) {
        return;
      }
    }

    final Command? item = rootCommand.removeAt(itemIndex);
    if (item == null) {
      return;
    }

    // If the current item was before the place we want to insert,
    // update the place so it's -1 from it previous position,
    // because we removed the element before.
    if (containerIndex.length >= itemIndex.length &&
        itemIndex[itemIndex.length - 1] < containerIndex[itemIndex.length - 1]) {
      containerIndex[itemIndex.length - 1]--;
    }

    final Command? container = rootCommand.commandAt(containerIndex);
    if (container is GroupCommand) {
      final int length = container.commands.length;
      List<int> newIndex = List<int>.from(containerIndex)..add(length);

      // print("yooo append item $itemIndex to container $containerIndex");
      rootCommand.insertAt(newIndex, item);
    }
  }

  void _appendItemFromPalette(Command command, List<int> containerIndex) {
    final Command? container = rootCommand.commandAt(containerIndex);
    if (container is GroupCommand) {
      final int length = container.commands.length;
      List<int> newIndex = List<int>.from(containerIndex)..add(length);

      _willBeDraggedFromPalette = ObjectKey(command);
      rootCommand.insertAt(newIndex, command);
    }
  }

  void _removeItem(List<int> itemIndex) {
    if (itemIndex.isEmpty) return;
    //print("remove item $itemIndex");

    rootCommand.removeAt(itemIndex);
  }

  void _insertItemBefore(List<int> itemIndex, List<int> afterItemIndex) {
    if (itemIndex.isEmpty || afterItemIndex.isEmpty) return;

    if (itemIndex.length == afterItemIndex.length) {
      bool isTheSame = true;
      for (int i = 0; i < itemIndex.length; i++) {
        // last one
        if (i == itemIndex.length - 1) {
          if (itemIndex[i] + 1 != afterItemIndex[i]) {
            isTheSame = false;
          }
        } else if (itemIndex[i] != afterItemIndex[i]) {
          isTheSame = false;
          break;
        }
      }
      if (isTheSame) {
        return;
      }
    }

    // print("insert x $itemIndex before $afterItemIndex");

    final item = rootCommand.removeAt(itemIndex);
    if (item != null) {
      // If the current item was before the place we want to insert,
      // update the place so it's -1 from it previous position,
      // because we removed the element before.
      if (afterItemIndex.length >= itemIndex.length &&
          itemIndex[itemIndex.length - 1] < afterItemIndex[itemIndex.length - 1]) {
        afterItemIndex[itemIndex.length - 1]--;
      }
      rootCommand.insertAt(afterItemIndex, item);
    }
  }

  void _insertItemBeforeFromPalette(Command command, List<int> afterItemIndex) {
    _willBeDraggedFromPalette = ObjectKey(command);
    rootCommand.insertAt(afterItemIndex, command);
  }

  void _freeUpdate() {
    SchedulerBinding.instance!.addPostFrameCallback((Duration timeStamp) {
      setState(() {
        _canUpdate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        ListView(
          shrinkWrap: true,
          children: [
            Text("$rootCommand"),
            Align(
              alignment: Alignment.topLeft,
              child: CommandItem(command: rootCommand),
            ),
          ],
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (final paletteCommand in _commandPalette)
                CommandItem(command: paletteCommand, isPalette: true, key: ObjectKey(paletteCommand)),
            ],
          ),
        ),
        const DragProxy(),
      ],
    );
  }

  void startDragging({required Key stateKey, required PointerDownEvent event}) {
    if (_dragging != null) {
      return;
    }

    // Clear old dragging widget.
    // if (_dragging != null) {
    //   final _CommandItemState? current = _items[_dragging];
    //   _dragging = null;
    //   current?.update();
    // }

    // Set up new dragging state, widget + it's dragging proxy.
    _dragging = stateKey;
    final _CommandItemState? dragged = _items[_dragging]!;
    if (dragged == null) {
      _freeUpdate();
      return;
    }
    dragged.update();
    _draggingWidgetKey = dragged.widget.key;

    CommandItem w = CommandItem(command: dragged.widget.command, index: List<int>.from(dragged.index));
    _dragProxy?.setWidget(w, dragged.context.findRenderObject() as RenderBox);

    // Set up pan gesture recognizer.
    _recognizer?.dispose();
    _recognizer = PanGestureRecognizer(
      supportedDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      },
    );
    _recognizer!.onUpdate = _updateDragging;
    _recognizer!.onEnd = _endDragging;
    _recognizer!.dragStartBehavior = DragStartBehavior.start;
    _recognizer!.addPointer(event);

    // _freeUpdate();
  }

  void _updateDragging(DragUpdateDetails event) {
    _dragProxy?.updateOffset(event.delta);

    if (!_canUpdate) {
      return;
    }
    _canUpdate = false;

    if (_dragging == null) {
      _freeUpdate();
      return;
    }

    if (!_items.containsKey(_dragging)) {
      _freeUpdate();
      return;
    }

    // print("yoo UPDATE $event ${_items[_dragging]!.index}");

    final Offset position = event.globalPosition;
    _CommandContainerState? closestContainer = _findClosestContainer(position: position);
    // print("closest container of ${_items[_dragging]!.index} is ${closestContainer?.index}");

    if (closestContainer == null) {
      // print("the drag is out, will be removed");
      _willRemove = true;
      _freeUpdate();
      return;
    }
    _willRemove = false;

    /// FIND CLOSEST ITEM (REPLACE INDEX) INSIDE THAT CONTAINER

    final render = _items[_dragging]!.context.findRenderObject() as RenderBox;
    _CommandItemState? afterItemDrag;
    double smallestOffset = double.negativeInfinity;
    closestContainer.items.forEach((itemKey, _CommandItemState item) {
      final itemRender = item.context.findRenderObject() as RenderBox;

      // Except the current item.
      if (!render.size.contains(itemRender.localToGlobal(Offset.zero) - render.localToGlobal(Offset.zero))) {
        double offsetToItem = position.dy - itemRender.localToGlobal(Offset.zero).dy - itemRender.size.height / 2;

        if (offsetToItem < 0 && offsetToItem > smallestOffset) {
          smallestOffset = offsetToItem;
          afterItemDrag = item;
        }
      }
    });

    // Process inserting for commands items from the palette.
    if (_items[_dragging]!.widget.isPalette) {
      if (afterItemDrag == null) {
        _appendItemFromPalette(_items[_dragging]!.widget.command.clone(), closestContainer.index);
      } else {
        _insertItemBeforeFromPalette(_items[_dragging]!.widget.command.clone(), afterItemDrag!.index);
      }
    }
    // Or process reordering for command items from the tree view.
    else {
      if (afterItemDrag == null) {
        _appendItem(_items[_dragging]!.index, closestContainer.index);
      } else {
        _insertItemBefore(_items[_dragging]!.index, afterItemDrag!.index);
      }

      _items[_dragging]?.update();
    }

    _freeUpdate();
  }

  void _endDragging([DragEndDetails? event]) {
    while (_canUpdate == false) {}
    _canUpdate = false;

    _dragProxy?.hide();
    _draggingWidgetKey = null;

    if (_dragging != null) {
      final current = _items[_dragging];
      current?.update();

      if (_willRemove) {
        _willRemove = false;
        _removeItem(current!.index);
      }

      _dragging = null;
    }

    _freeUpdate();
  }

  _CommandContainerState? _findClosestContainer({required Offset position}) {
    // print("== from ${_items[_dragging]!.index}");
    final render = _items[_dragging]!.context.findRenderObject() as RenderBox;

    int maxIndexes = -1;
    _CommandContainerState? closestContainer;
    _CommandsViewState.of(_items[_dragging]!.context)!.containers.forEach(
      (containerKey, _CommandContainerState container) {
        final containerRender = container.context.findRenderObject() as RenderBox;

        // The drag position is inside target area.
        // if (container.key == _CommandContainerState.of(_items[_dragging]!.context)!.key) {
        if (containerRender.size.contains(position - containerRender.localToGlobal(Offset.zero) + const Offset(2, 2))) {
          // But it is not subtree of original item.
          if (!container._isChildOfItem(_dragging!)) {
            // Find closest one.
            if (container.index.length > maxIndexes) {
              maxIndexes = container.index.length;
              closestContainer = container;
            }
          }
        }
      },
    );

    return closestContainer;
  }
}
