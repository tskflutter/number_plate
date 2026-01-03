import 'package:flutter/material.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';

class CustomAppCard extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final double? borderWidth;
  final Color backgroundColor;
  final Color borderColor;
  final double radius;
  final VoidCallback? onPressed;
  final Widget child;
  final BoxBorder? boxBorder;
  final bool showBorder;

  final List<BoxShadow>? boxShadow;
  final bool showShadow;

  /// Gradient
  final Gradient? gradient;
  final bool useGradient;

  const CustomAppCard({
    super.key,
    this.width,
    this.height,
    this.borderWidth = 1,
    this.backgroundColor = MyColor.white,
    this.borderColor = MyColor.lightBorder,
    this.radius = Dimensions.cardRadius,
    this.onPressed,
    required this.child,
    this.padding,
    this.margin,
    this.boxBorder,
    this.showBorder = true,
    this.boxShadow,
    this.showShadow = true,
    this.gradient,
    this.useGradient = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding ?? EdgeInsets.all(16.w),
        margin: margin,
        decoration: BoxDecoration(
          color: useGradient ? null : backgroundColor,
          gradient: useGradient
              ? (gradient ??
                  const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.1, 1.0],
                    colors: [
                      Color(0xFFFDFCFB),
                      Color(0xFFFDFCFB),
                      Color(0xFFE2D1C3),
                    ],
                  ))
              : null,
          borderRadius: BorderRadius.circular(radius),
          border: showBorder ? Border.all(color: borderColor, width: borderWidth ?? 1) : null,
          boxShadow: showShadow
              ? (boxShadow ??
                  [
                    BoxShadow(
                      color: MyColor.black.withValues(alpha: .08),
                      blurRadius: 3,
                      spreadRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ])
              : null,
        ),
        child: child,
      ),
    );
  }
}
