import 'package:flutter/material.dart';

class HoverButton extends StatefulWidget {
  final bool isActive;
  final void Function()? onPressed;
  final Widget child;
  final bool withBorder;

  const HoverButton({this.isActive = false, this.onPressed, required this.child, this.withBorder = true, Key? key})
      : super(key: key);

  @override
  _HoverButtonState createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final Border border = Border(
      bottom: BorderSide(width: 4, color: (widget.isActive || isHovered) ? Colors.blue : Colors.transparent),
    );

    return GestureDetector(
      onTap: () => widget.onPressed?.call(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => hoverUpdate(true),
        onExit: (_) => hoverUpdate(false),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          decoration: BoxDecoration(
            border: widget.withBorder ? border : null,
          ),
          child: DefaultTextStyle(
            style: ((widget.isActive || isHovered)
                    ? const TextStyle(color: Colors.blue)
                    : Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey))
                .copyWith(fontWeight: FontWeight.w600, fontSize: 18),
            child: widget.child,
          ),
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
