import 'package:flutter/material.dart';

class ReorderableTreeView extends StatefulWidget {
  final Widget child;

  Key? get dragging => _dragging;
  Key? _dragging;

  ReorderableTreeView({Key? key, required this.child}) : super(key: key);

  @override
  _ReorderableTreeViewState createState() => _ReorderableTreeViewState();
}

class _ReorderableTreeViewState extends State<ReorderableTreeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Listener(
        onPointerDown: (PointerEvent event) => _routePointer(event, context),
        child: widget.child,
      ),
    );
  }

  void _routePointer(PointerEvent event, BuildContext context) {
    _startDragging(context: context, event: event);
  }

  void _startDragging({required BuildContext context, PointerEvent? event}) {
    // _ReorderableItemState? state =
    //     context.findAncestorStateOfType<_ReorderableItemState>();

    // final scrollable = Scrollable.of(context);
    //
    // final listState = _ReorderableListState.of(context)!;
    //
    // if (listState.dragging == null) {
    //   listState._startDragging(
    //     key: state!.key,
    //     event: event!,
    //     scrollable: scrollable,
    //     recognizer: createRecognizer(
    //       debugOwner: this,
    //       supportedDevices: {
    //         PointerDeviceKind.touch,
    //         PointerDeviceKind.mouse,
    //       },
    //     ),
    //   );
    // }
  }
}

// TODO: ReorderableItemState
// class _ReorderableItemState extends State<ReorderableItem> {
//   get key => widget.key;
//
//   @override
//   Widget build(BuildContext context) {
//     // super.build(context);
//     _listState = _ReorderableListState.of(context);
//
//     _listState!.registerItem(this);
//     bool dragging = _listState!.dragging == key;
//     double translation = _listState!.itemTranslation(key);
//     return Transform(
//       transform: Matrix4.translationValues(0.0, translation, 0.0),
//       child: widget.childBuilder(
//           context,
//           dragging
//               ? ReorderableItemState.placeholder
//               : ReorderableItemState.normal),
//     );
//   }



// void update() {
//     if (mounted) {
//       setState(() {});
//     }
//   }


// final HashMap<Key?, _ReorderableItemState> _items =
//   HashMap<Key, _ReorderableItemState>();
//
// void registerItem(_ReorderableItemState item) {
//     _items[item.key] = item;
//   }
//
// void unregisterItem(_ReorderableItemState item) {
//     if (_items[item.key] == item) _items.remove(item.key);
//   }


// TODO: ReorderableListState

// double _itemOffset(_ReorderableItemState item) {
//     final topRenderBox = context.findRenderObject() as RenderBox;
//     return (item.context.findRenderObject() as RenderBox)
//         .localToGlobal(Offset.zero, ancestor: topRenderBox)
//         .dy;
//   }

// static _ReorderableListState? of(BuildContext context) {
//     return context.findAncestorStateOfType<_ReorderableListState>();
//   }

// final draggingTop = _itemOffset(draggingState);
// final draggingHeight = draggingState.context.size!.height;
// _ReorderableItemState? closest;
// double closestDistance = 0.0;
//
// if (_dragProxy!.offset < draggingTop) {
//       for (_ReorderableItemState item in _items.values) {
//         if (item.key == _dragging) continue;
//         final itemTop = _itemOffset(item);
//         if (itemTop > draggingTop) continue;
//         final itemBottom = itemTop +
//             (item.context.findRenderObject() as RenderBox).size.height / 2;
//
//         if (_dragProxy!.offset < itemBottom) {
//           onReorderApproved.add(() {
//             _adjustItemTranslation(item.key, -draggingHeight, draggingHeight);
//           });
//           if (closest == null ||
//               closestDistance > (itemBottom - _dragProxy!.offset)) {
//             closest = item;
//             closestDistance = (itemBottom - _dragProxy!.offset);
//           }
//         }
//       }
//     } else {
//       double draggingBottom = _dragProxy!.offset + draggingHeight;
//
//       for (_ReorderableItemState item in _items.values) {
//         if (item.key == _dragging) continue;
//         final itemTop = _itemOffset(item);
//         if (itemTop < draggingTop) continue;
//
//         final itemBottom = itemTop +
//             (item.context.findRenderObject() as RenderBox).size.height / 2;
//         if (draggingBottom > itemBottom) {
//           onReorderApproved.add(() {
//             _adjustItemTranslation(item.key, draggingHeight, draggingHeight);
//           });
//           if (closest == null ||
//               closestDistance > (draggingBottom - itemBottom)) {
//             closest = item;
//             closestDistance = draggingBottom - itemBottom;
//           }
//         }
//       }
//     }
//
// // _lastReportedKey check is to ensure we don't keep spamming the callback when reorder
//     // was rejected for this key;
//     if (closest != null &&
//         closest.key != _dragging &&
//         closest.key != _lastReportedKey) {
//       SchedulerBinding.instance!.addPostFrameCallback((Duration timeStamp) {
//         _scheduledRebuild = false;
//       });
//       _scheduledRebuild = true;
//       _lastReportedKey = closest.key;
//
//       if (widget.onReorder(_dragging!, closest.key)) {
//         bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
//
//         if (isIOS) {
//           _hapticFeedback();
//         }
//         for (final f in onReorderApproved) {
//           f();
//         }
//         _lastReportedKey = null;
//       }
//     }


// TODO: DragProxyState
//   @override
//   Widget build(BuildContext context) {
//     final state = _ReorderableListState.of(context)!;
//     state._dragProxy = this;

