import 'package:flutter/material.dart';

class InlineHoverButton extends StatefulWidget {
  final bool isActive;
  final void Function()? onPressed;
  final Widget child;

  const InlineHoverButton({this.isActive = false, this.onPressed, required this.child, Key? key}) : super(key: key);

  @override
  _InlineHoverButtonState createState() => _InlineHoverButtonState();
}

class _InlineHoverButtonState extends State<InlineHoverButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onPressed?.call(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => hoverUpdate(true),
        onExit: (_) => hoverUpdate(false),
        child: DefaultTextStyle(
          style: ((widget.isActive || isHovered)
                  ? const TextStyle(color: Colors.blue)
                  : Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey))
              .copyWith(fontWeight: FontWeight.bold, fontSize: 15),
          child: widget.child,
        ),
      ),
    );
  }

  void hoverUpdate(bool isHovered) {
    setState(() {
      this.isHovered = isHovered;
    });
  }
}
