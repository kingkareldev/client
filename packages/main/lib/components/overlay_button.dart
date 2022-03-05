import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class OverlayButton extends StatefulWidget {
  final Widget child;
  final Widget? overlay;
  final void Function()? onPressed;
  final double overlayWidth;

  const OverlayButton({required this.child, this.overlay, this.onPressed, this.overlayWidth = 150, Key? key})
      : super(key: key);

  @override
  _OverlayButtonState createState() => _OverlayButtonState();
}

class _OverlayButtonState extends State<OverlayButton> {
  bool isChildHovered = false;
  bool isOverlayHovered = false;

  Timer? timer;

  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Size size = renderBox.size;

    final double windowWidth = MediaQuery.of(context).size.width;
    final buttonRenderPosition = renderBox.localToGlobal(Offset.zero);
    const double spacing = 8;

    // By default align with center.
    Offset offset = Offset(size.width / 2 - widget.overlayWidth / 2, size.height);

    // Check right side overflow.
    if (buttonRenderPosition.dx + size.width / 2 + widget.overlayWidth / 2 > windowWidth - spacing) {
      offset = Offset(-widget.overlayWidth + size.width, size.height);
    }

    // Check left side overflow.
    if (buttonRenderPosition.dx + size.width / 2 - widget.overlayWidth / 2 < spacing) {
      offset = Offset(buttonRenderPosition.dx - spacing, size.height);
    }

    return OverlayEntry(
      builder: (context) {
        return Positioned(
          width: widget.overlayWidth,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: offset,
            child: MouseRegion(
              onEnter: onOverlayEnter,
              onExit: onOverlayExit,
              child: Material(
                elevation: 1,
                color: Colors.white,
                child: widget.overlay,
              ),
            ),
          ),
        );
      },
    );
  }

  void onHoverEnter(PointerEnterEvent event) {
    setState(() {
      isChildHovered = true;
    });

    if (_overlayEntry != null) {
      return;
    }

    if (widget.overlay == null) {
      return;
    }

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context)!.insert(_overlayEntry!);
  }

  void onHoverExit(PointerExitEvent event) {
    setState(() {
      isChildHovered = false;
    });

    removeOverlayIntention();
  }

  void onOverlayEnter(PointerEnterEvent event) {
    setState(() {
      isOverlayHovered = true;
    });
  }

  void onOverlayExit(PointerExitEvent event) {
    setState(() {
      isOverlayHovered = false;
    });
    removeOverlayIntention();
  }

  void removeOverlayIntention() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }

    timer = Timer(
      const Duration(milliseconds: 20),
      () => removeOverlay(),
    );
  }

  void removeOverlay() {
    if (!isChildHovered && !isOverlayHovered) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: MouseRegion(
        cursor: widget.onPressed != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onEnter: onHoverEnter,
        onExit: onHoverExit,
        child: CompositedTransformTarget(
          link: _layerLink,
          child: Opacity(
            opacity: (isChildHovered || isOverlayHovered) ? 1 : 0.5,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
