import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class InnerShadow extends SingleChildRenderObjectWidget {
  const InnerShadow({
    super.key,
    required Widget child,
    this.blur = 8,
    this.color = const Color(0x55000000),
    this.offset = const Offset(2, 2),
    this.borderRadius = 12,
  }) : super(child: child);

  final double blur;
  final Color color;
  final Offset offset;
  final double borderRadius;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderInnerShadow()
      ..blur = blur
      ..color = color
      ..dx = offset.dx
      ..dy = offset.dy
      ..borderRadius = borderRadius;
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _RenderInnerShadow renderObject,
  ) {
    renderObject
      ..blur = blur
      ..color = color
      ..dx = offset.dx
      ..dy = offset.dy
      ..borderRadius = borderRadius;
  }
}

class _RenderInnerShadow extends RenderProxyBox {
  double _blur = 8;
  Color _color = const Color(0x55000000);
  double _dx = 2;
  double _dy = 2;
  double _borderRadius = 12;

  double get blur => _blur;
  set blur(double value) {
    if (_blur == value) return;
    _blur = value;
    markNeedsPaint();
  }

  Color get color => _color;
  set color(Color value) {
    if (_color == value) return;
    _color = value;
    markNeedsPaint();
  }

  double get dx => _dx;
  set dx(double value) {
    if (_dx == value) return;
    _dx = value;
    markNeedsPaint();
  }

  double get dy => _dy;
  set dy(double value) {
    if (_dy == value) return;
    _dy = value;
    markNeedsPaint();
  }

  double get borderRadius => _borderRadius;
  set borderRadius(double value) {
    if (_borderRadius == value) return;
    _borderRadius = value;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) return;

    final Canvas canvas = context.canvas;
    final Rect rect = offset & size;
    final rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(borderRadius),
    );

    // Save canvas state
    canvas.saveLayer(rect, Paint());

    // Clip to rounded rectangle
    canvas.clipRRect(rrect);

    // Paint child first
    context.paintChild(child!, offset);

    // Draw inner shadow effect using multiple semi-transparent layers
    // This simulates blur without using MaskFilter
    final shadowRect = rect.shift(Offset(dx, dy));

    for (int i = 0; i < blur.toInt(); i++) {
      final opacity = color.opacity * (1 - (i / blur)) * 0.3;
      final shadowPaint = Paint()
        ..color = color.withOpacity(opacity)
        ..blendMode = BlendMode.multiply;

      final inset = i.toDouble();
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          shadowRect.deflate(inset),
          Radius.circular(borderRadius - inset),
        ),
        shadowPaint,
      );
    }

    canvas.restore();
  }
}
