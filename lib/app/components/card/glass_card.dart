import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:ovolutter/core/utils/my_color.dart';

class CustomGlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double blur;
  final bool hasColor;
  final double height;
  final double? width;
  final double opacity;
  Color borderColor;
  final double borderWidth;

  CustomGlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 12,
    this.height = 36,
    this.padding = const EdgeInsets.all(8),
    this.margin,
    this.width,
    this.hasColor = false,
    this.blur = 3,
    this.opacity = 0.15,
    this.borderColor = Colors.white30,
    this.borderWidth = 1.2,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Stack(
        children: [
          GlassContainer(
            height: height,
            width: width,
            color: hasColor ? MyColor.plateBgColor : null,
            blur: blur,
            opacity: opacity,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderColor,
              width: borderWidth,
            ),
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
          if (hasColor)
            Positioned.fill(
              child: CustomPaint(
                painter: InnerShadowPainter(
                  borderRadius: borderRadius,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class InnerShadowPainter extends CustomPainter {
  final double borderRadius;

  InnerShadowPainter({required this.borderRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rRect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(borderRadius),
    );

    final shadowPaint = Paint()..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final topGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        MyColor.black.withValues(alpha: .2),
        MyColor.transparent,
      ],
      stops: const [0.0, 0.15],
    );

    final topRect = Rect.fromLTWH(0, 0, size.width, size.height * 0.3);
    shadowPaint.shader = topGradient.createShader(topRect);
    canvas.drawRRect(rRect, shadowPaint);

    final bottomGradient = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        Colors.black.withValues(alpha: 0.2),
        Colors.transparent,
      ],
      stops: const [0.0, 0.1],
    );

    final bottomRect = Rect.fromLTWH(0, size.height * 0.7, size.width, size.height * 0.3);
    shadowPaint.shader = bottomGradient.createShader(bottomRect);
    canvas.drawRRect(rRect, shadowPaint);

    // Left shadow
    final leftGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Colors.black.withValues(alpha: 0.2),
        Colors.transparent,
      ],
      stops: const [0.0, 0.1],
    );

    final leftRect = Rect.fromLTWH(0, 0, size.width * 0.2, size.height);
    shadowPaint.shader = leftGradient.createShader(leftRect);
    canvas.drawRRect(rRect, shadowPaint);

    final rightGradient = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [
        Colors.black.withValues(alpha: 0.2),
        Colors.transparent,
      ],
      stops: const [0.0, 0.1],
    );

    final rightRect = Rect.fromLTWH(size.width * 0.8, 0, size.width * 0.2, size.height);
    shadowPaint.shader = rightGradient.createShader(rightRect);
    canvas.drawRRect(rRect, shadowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
