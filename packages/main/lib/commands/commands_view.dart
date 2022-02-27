import 'dart:collection';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:main/commands/model/command.dart';

part 'command_container.dart';

part 'command_item.dart';

part 'drag_proxy.dart';

class CommandsView extends StatefulWidget {
  const CommandsView({Key? key}) : super(key: key);

  @override
  _CommandsViewState createState() => _CommandsViewState();
}

class _CommandsViewState extends State<CommandsView> {
  Key? get dragging => _dragging;
  Key? _dragging;
  Key? _draggingWidgetKey;

  Key? _willDrag;

  bool _canUpdate = true;

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

  GroupCommand rootCommand = RootCommand([
    SingleCommand('a'),
    SingleCommand('b'),
    SingleCommand('c'),
    SingleCommand('d'),
    SingleCommand('e'),
  ]);

  // GroupCommand rootCommand = RootCommand([
  //   SingleCommand('a'),
  //   GroupCommand('1', [
  //     SingleCommand('2'),
  //     SingleCommand('3'),
  //     SingleCommand('4'),
  //   ]),
  //   SingleCommand('b'),
  //   GroupCommand('c', [
  //     SingleCommand('d'),
  //     SingleCommand('e'),
  //     GroupCommand('f', [
  //       SingleCommand('g'),
  //       SingleCommand('h'),
  //       GroupCommand('i', [
  //         SingleCommand('j1'),
  //         SingleCommand('j2'),
  //         SingleCommand('j3'),
  //       ]),
  //     ]),
  //     SingleCommand('k'),
  //   ]),
  //   SingleCommand('l'),
  //   SingleCommand('m'),
  // ]);

  void _appendItem(List<int> itemIndex, List<int> containerIndex) {
    print("append item $itemIndex to container $containerIndex");
    if (itemIndex.isEmpty) {
      return;
    }

    final Command? item = rootCommand.removeAt(itemIndex);
    print("item $item");
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
    print("container $container");
    if (container is GroupCommand) {
      final int length = container.commands.length;
      List<int> newIndex = List<int>.from(containerIndex)..add(length);

      setState(() {
        print("yooo append item $itemIndex to container $containerIndex");
        rootCommand.insertAt(newIndex, item);
      });
    } else {
      print("container is ${container.runtimeType}");
    }
  }

  void _removeItem(List<int> itemIndex) {
    print("remove item $itemIndex");
    if (itemIndex.isEmpty) return;

    setState(() {
      final Command? item = rootCommand.removeAt(itemIndex);
      print("item $item");
    });
  }

  void _insertItemBefore(List<int> itemIndex, List<int> afterItemIndex) {
    if (itemIndex.isEmpty || afterItemIndex.isEmpty) return;

    print("a ${itemIndex.length} = ${afterItemIndex.length}");
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
      print("b $isTheSame");
      if (isTheSame) {
        return;
      }
    }

    setState(() {
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
      } else {
        print("item was null");
      }
    });
  }

  void _freeUpdate() {
    print("free start");
    SchedulerBinding.instance!.addPostFrameCallback((Duration timeStamp) {
      setState(() {
        _canUpdate = true;
        print("free done");
      });
    });
    if (_items.containsKey(_dragging)) {
      setState(() {
        _items[_dragging]!.update();
      });
    }
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
            // Container(
            //   color: Colors.redAccent,
            //   child: Text("aaa"),
            // )
            ElevatedButton(
              onPressed: () {
                _appendItem([0], [1]);
              },
              child: const Text("press me"),
            ),
            ElevatedButton(
              onPressed: () {
                _removeItem([2]);
              },
              child: const Text("remove"),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: CommandItem(command: rootCommand),
            ),
            Text("$rootCommand"),
            Text("${_draggingWidgetKey}"),
            Text("${_items.containsKey(_dragging) ? _items[_dragging]!.index : null}"),
            Text("${_canUpdate}"),
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
    _dragProxy?.updateOffset(event.delta);

    if (!_canUpdate) {
      return;
    }
    _canUpdate = false;
    print("LOCK 1 $_dragging");
    print("THIS ${event.delta}, ${event.localPosition}, ${event.globalPosition}");

    if (_dragging == null) {
      _freeUpdate();
      return;
    }

    print("yoo UPDATE $event ${_items[_dragging]!.index}");

    final Offset position = event.globalPosition;
    _CommandContainerState? closestContainer = _findClosestContainer(position: position);

    if (closestContainer == null) {
      print("the drag is out, will be removed");
      _freeUpdate();
      return;
    }

    /// FIND CLOSEST ITEM (REPLACE INDEX) INSIDE THAT CONTAINER
    print("closest container = ${closestContainer.index}");

    // print("--> position ${position}");
    final render = _items[_dragging]!.context.findRenderObject() as RenderBox;
    _CommandItemState? afterItemDrag;
    double smallestOffset = double.negativeInfinity;
    closestContainer.items.forEach((itemKey, _CommandItemState item) {
      final itemRender = item.context.findRenderObject() as RenderBox;
      // TODO maybe use keys? -- not sure if they will change on changed position
      if (_dragging == itemKey) {
        print("this one ${item.index}");
      }

      // Except the current item.
      if (!render.size.contains(itemRender.localToGlobal(Offset.zero) - render.localToGlobal(Offset.zero))) {
        double offsetToItem = position.dy - itemRender.localToGlobal(Offset.zero).dy - itemRender.size.height / 2;
        if (offsetToItem < 0 && offsetToItem > smallestOffset) {
          smallestOffset = offsetToItem;
          afterItemDrag = item;
        }
      } else {
        print("yes this one");
      }
    });

    if (afterItemDrag == null) {
      print("append to container");
      _appendItem(_items[_dragging]!.index, closestContainer.index);
    } else {
      print("insert ${_items[_dragging]!.index} before ${afterItemDrag!.index}");
      _insertItemBefore(_items[_dragging]!.index, afterItemDrag!.index);
    }

    _items[dragging]?.update();

    _freeUpdate();
  }

  void _endDragging([DragEndDetails? event]) {
    while (_canUpdate == false) {
    }
    _canUpdate = false;
    print("yoo END $event");
    // TODO: for the 1st element ([0]) it says on update 'insert [0] before [1]', but for this drag offset it cannot find a closest container.
    _CommandContainerState? closestContainer = _findClosestContainer(position: _dragProxy!._offset);
    print(_dragProxy!._offset);
    print("closes end container: ${closestContainer?.index}");

    _dragProxy?.hide();
    _draggingWidgetKey = null;

    if (_dragging != null) {
      if (closestContainer == null) {
        _removeItem(_items[_dragging]!.index);
      }

      final current = _items[_dragging];
      _dragging = null;
      current?.update();
    }

    _freeUpdate();
  }

  _CommandContainerState? _findClosestContainer({required Offset position}) {
    print("== from ${_items[_dragging]!.index}");
    final render = _items[_dragging]!.context.findRenderObject() as RenderBox;
    print("ltg ${render.localToGlobal(Offset.zero)}, pos $position");
    int maxIndexes = -1;
    _CommandContainerState? closestContainer;
    _CommandsViewState.of(_items[_dragging]!.context)!.containers.forEach(
      (containerKey, _CommandContainerState container) {
        final containerRender = container.context.findRenderObject() as RenderBox;
        print("AA");
        // The drag position is inside target area.
        // if (container.key == _CommandContainerState.of(_items[_dragging]!.context)!.key) {
        if (containerRender.size.contains(position - containerRender.localToGlobal(Offset.zero))) {
          // print("x 2 --- ${render.localToGlobal(Offset.zero)} ... ${containerRender.localToGlobal(Offset.zero)}");
          // But it is not subtree of original item.
          print("A");
          if (!render.size.contains(
              containerRender.localToGlobal(Offset.zero) - render.localToGlobal(Offset.zero) - Offset(2, 2))) {
            print("B");
            // print("x 3");
            // print("... ${containerRender.localToGlobal(Offset.zero)}");
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
