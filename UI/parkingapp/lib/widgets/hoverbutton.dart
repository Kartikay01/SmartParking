import 'package:flutter/material.dart';

class OnHoverButton extends StatefulWidget {
  final Widget Function(bool isHovered) builder;
  const OnHoverButton({
    Key? key,
    required this.builder,
  }) : super(key: key);
  @override
  _OnHoverButtonState createState() => _OnHoverButtonState();
}

class _OnHoverButtonState extends State<OnHoverButton> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    final hoveredTransform = Matrix4.identity()..scale(1.03);
    final transform = isHovered ? hoveredTransform : Matrix4.identity();
    return MouseRegion(
        onEnter: (event) => onEntered(true),
        onExit: (event) => onEntered(false),
        child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            transform: transform,
            transformAlignment: Alignment.center,
            child: widget.builder(isHovered)));
  }

  void onEntered(bool isHovered) => setState(() {
        this.isHovered = isHovered;
      });
}
