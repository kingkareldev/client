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

  bool _canUpdate = true;

  bool _willRemove = false;

  bool get willRemove => _willRemove;

  _DragProxyState? _dragProxy;

  DragGestureRecognizer? _recognizer;

  HashMap<Key, _CommandItemState> get items => _items;
  final _items = HashMap<Key, _CommandItemState>();

  void registerItem(_CommandItemState item) {
    _items[item.key] = item;

    // Update dragging key after the dragged item moved across the different tree levels.
    if (_dragging != null && _draggingWidgetKey == item.widget.key && _dragging != item.key) {
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

  void _freeUpdate() {
    print("free start");
    SchedulerBinding.instance!.addPostFrameCallback((Duration timeStamp) {
      print("free scheduler");
      setState(() {
        _canUpdate = true;
        print("free done");
      });
    });
    // setState(() {
    //   // _canUpdate = true;
    //   print("free setstate");
    //   if (_items.containsKey(_dragging)) {
    //     _items[_dragging]!.update();
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    Container(
      padding: const EdgeInsets.all(30),
      color: Colors.blue,
      child: IconButton(
        icon: const Icon(Icons.arrow_left),
        onPressed: () {},
      ),
    );
    return Stack(
      fit: StackFit.passthrough,
      children: [
        ListView(
          shrinkWrap: true,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: CommandItem(command: rootCommand),
            ),
            Text("$rootCommand"),
            // Text("${_draggingWidgetKey}"),
            // Text("${_items.containsKey(_dragging) ? _items[_dragging]!.index : null}"),
            // Text("${_canUpdate}"),
            // Text("$_containers"),
          ],
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
      print("WTF");
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
    print("yoo RECOGNIZER ok");

    // _freeUpdate();
  }

  void _updateDragging(DragUpdateDetails event) {
    print(event);
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

    if (afterItemDrag == null) {
      //print("append ${_items[_dragging]!.index} to container ${closestContainer.index}");
      _appendItem(_items[_dragging]!.index, closestContainer.index);
    } else {
      //print("insert ${_items[_dragging]!.index} before ${afterItemDrag!.index}");
      _insertItemBefore(_items[_dragging]!.index, afterItemDrag!.index);
    }

    _items[_dragging]?.update();

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
        if (containerRender.size.contains(position - containerRender.localToGlobal(Offset.zero) + Offset(2, 2))) {
          // print("container: ${containerRender.localToGlobal(Offset.zero)} vs self: ${render.localToGlobal(Offset.zero)} == ${containerRender.localToGlobal(Offset.zero) - render.localToGlobal(Offset.zero)} ... ${render.size}");
          // print("x 2 --- ${render.localToGlobal(Offset.zero)} ... ${containerRender.localToGlobal(Offset.zero)}");
          // print(
          //     "keys self: ${_items[_dragging]!.key} or $_dragging, container item state: ${_CommandItemState.of(container.context)?.key}");
          // print("yoo is self recursive? ${container._isChildOfItem(_dragging!)}");

          // print(
          //     "__!!__ ${!render.size.contains(containerRender.localToGlobal(Offset.zero) - render.localToGlobal(Offset.zero) + Offset(2, 2)) == !container._isChildOfItem(_dragging!)}");

          // But it is not subtree of original item.
          if (!container._isChildOfItem(_dragging!)) {
            // if (!render.size.contains(
            //    containerRender.localToGlobal(Offset.zero) - render.localToGlobal(Offset.zero) - Offset(2, 2))) {

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
