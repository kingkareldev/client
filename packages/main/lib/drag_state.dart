import 'dart:collection';

import 'package:flutter/material.dart';

import 'drag_container.dart';

class DragState extends StatefulWidget {
  final Widget child;

  DragState({Key? key, required this.child}) : super(key: key);

  @override
  DragStateState createState() => DragStateState();
}

class DragStateState extends State<DragState> {
  Widget? dragging;

  HashMap<Key, DragContainerState> get items => _items;
  final HashMap<Key, DragContainerState> _items = HashMap<Key, DragContainerState>();

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void registerItem(DragContainerState item) {
    _items[item.key] = item;
  }

  void unregisterItem(DragContainerState item) {
    if (_items[item.key] == item) {
      _items.remove(item.key);
    }
  }
}
