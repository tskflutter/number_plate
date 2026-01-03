import 'package:flutter/material.dart';

class CustomRangeSlider extends StatelessWidget {
  final double minValue;
  final double maxValue;
  final RangeValues currentValues;
  final ValueChanged<RangeValues> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final Color thumbColor;
  final double height;
  final double thumbRadius;

  const CustomRangeSlider({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.currentValues,
    required this.onChanged,
    this.activeColor = Colors.blue,
    this.inactiveColor = const Color(0xFFE0E0E0),
    this.thumbColor = Colors.black,
    this.height = 2,
    this.thumbRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: height,
        activeTrackColor: activeColor,
        inactiveTrackColor: inactiveColor,
        thumbColor: thumbColor,
        overlayColor: thumbColor.withOpacity(0.1),
        thumbShape: RoundSliderThumbShape(
          enabledThumbRadius: thumbRadius,
        ),
        overlayShape: RoundSliderOverlayShape(
          overlayRadius: thumbRadius * 1.8,
        ),
        rangeThumbShape: RoundRangeSliderThumbShape(
          enabledThumbRadius: thumbRadius,
        ),
        rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
        valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
        valueIndicatorColor: thumbColor,
        valueIndicatorTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      child: RangeSlider(
        min: minValue,
        max: maxValue,
        values: currentValues,
        onChanged: onChanged,
        labels: RangeLabels(
          currentValues.start.round().toString(),
          currentValues.end.round().toString(),
        ),
      ),
    );
  }
}
