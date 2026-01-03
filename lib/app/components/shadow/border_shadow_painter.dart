import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class InnerShadowPainter extends CustomPainter {
  final double borderRadius;
  final double shadowSize;
  final Color shadowColor;

  InnerShadowPainter({
    required this.borderRadius,
    this.shadowSize = 10,
    required this.shadowColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(borderRadius),
    );

    // Clip to the rounded rectangle
    canvas.saveLayer(rect, Paint());
    canvas.clipRRect(rrect);

    // Draw the inner shadow
    final shadowPaint = Paint()
      ..color = shadowColor
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowSize);

    final shadowRect = rect.inflate(shadowSize * 2);
    final shadowRRect = RRect.fromRectAndRadius(
      shadowRect,
      Radius.circular(borderRadius + shadowSize * 2),
    );

    // Draw shadow by drawing outside and clipping
    canvas.drawRRect(shadowRRect, shadowPaint);

    // Cut out the inner part to leave only the shadow
    canvas.clipRect(rect);

    final innerPaint = Paint()
      ..color = Colors.black
      ..blendMode = BlendMode.dstOut;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        rect.deflate(shadowSize / 2),
        Radius.circular(borderRadius),
      ),
      innerPaint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
