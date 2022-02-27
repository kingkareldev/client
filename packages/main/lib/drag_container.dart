import 'package:flutter/material.dart';

import 'drag_state.dart';

class DragContainer extends StatefulWidget {
  List<int> items;

  DragContainer({required this.items, Key? key}) : super(key: key);

  @override
  DragContainerState createState() => DragContainerState();
}

class DragContainerState extends State<DragContainer> {
  int? dragging;
  List<int> items = [];
  late ObjectKey key;

  @override
  void initState() {
    items = List.from(widget.items);
    key = ObjectKey(this);
    print("x");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DragStateState? _dragState = context.findAncestorStateOfType<DragStateState>();
    _dragState!.registerItem(this);

    return Listener(
      onPointerUp: (event) {
        print("container ${key.toString()} up");

        if (dragging != null) {
          print("up ${event.position}");
          _dragState.items.forEach((Key key, DragContainerState otherState) {
            RenderBox render = otherState.context.findRenderObject() as RenderBox;

            print("xxx ${render.paintBounds}");
            // if is inside the other
            if (render.paintBounds.contains(event.position - render.localToGlobal(Offset.zero))) {
              print("yep");
              otherState.setState(() {
                if (!otherState.items.contains(dragging!)) {
                  otherState.items.add(dragging!);
                }
              });
            }
          });

          setState(() {
            dragging = null;
          });
        }
      },
      onPointerMove: (event) {
        // print("container ${key.toString()} move");

        if (dragging != null) {
          RenderBox render = context.findRenderObject() as RenderBox;

          // is not inside current
          if (!render.paintBounds.contains(event.position - render.localToGlobal(Offset.zero))) {
            setState(() {
              items.remove(dragging);
            });
          }
        }
      },
      child: Container(
        color: Colors.blue[200],
        child: Column(
          children: [
            Text(dragging == null ? "-" : dragging.toString()),
            for (var item in items)
              Listener(
                onPointerHover: (event) {
                  //print("hover over item");
                },
                onPointerDown: (event) {
                  setState(() {
                    dragging = item;
                  });
                  print("item $item down");
                },
                child: Text("item $item" + (dragging == item ? " + being dragged" : "")),
              )
          ],
        ),
      ),
    );
  }
}
