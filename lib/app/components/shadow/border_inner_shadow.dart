import 'package:flutter/material.dart';

class BorderInnerShadow extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final Color shadowColor;

  const BorderInnerShadow({
    super.key,
    required this.child,
    this.borderRadius = 12,
    required this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 1,
              spreadRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
