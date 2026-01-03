// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:ovolutter/core/utils/my_images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/my_color.dart';

class AnimatedTextField extends StatefulWidget {
  final bool needOutline;
  final String? labelText;
  final String? hintText;
  final Function? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final FormFieldValidator? validator;
  final TextInputType? textInputType;
  final bool isEnable;
  final bool isPassword;
  final TextInputAction inputAction;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;
  final int maxLines;
  final bool isRequired;
  final double radius;
  final EdgeInsetsGeometry contentPadding;
  final Color fillColor;
  final Color labelTextColor;
  final Color hintTextColor;

  const AnimatedTextField({
    super.key,
    this.needOutline = true,
    this.labelText,
    this.readOnly = false,
    required this.onChanged,
    this.hintText,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.validator,
    this.textInputType,
    this.isEnable = true,
    this.isPassword = false,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.isRequired = false,
    this.radius = Dimensions.defaultRadius,
    this.suffixIcon,
    this.prefixIcon,
    this.contentPadding = const EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
    this.fillColor = MyColor.transparent,
    this.hintTextColor = MyColor.lightBodyText,
    this.labelTextColor = MyColor.lightBodyText,
  });

  @override
  State<AnimatedTextField> createState() => _AnimatedTextFieldState();
}

class _AnimatedTextFieldState extends State<AnimatedTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return widget.needOutline
        ? TextFormField(
            maxLines: widget.maxLines,
            readOnly: widget.readOnly,
            style: theme.textTheme.labelMedium?.copyWith(color: MyColor.getBodyTextColor()),
            cursorColor: MyColor.getBodyTextColor(),
            controller: widget.controller,
            autofocus: false,
            textInputAction: widget.inputAction,
            enabled: widget.isEnable,
            focusNode: widget.focusNode,
            validator: widget.validator,
            keyboardType: widget.textInputType,
            obscureText: widget.isPassword ? obscureText : false,
            decoration: InputDecoration(
              contentPadding: widget.contentPadding,
              labelText: widget.labelText?.tr ?? '',
              labelStyle: theme.textTheme.labelMedium?.copyWith(color: widget.labelTextColor),
              hintText: widget.hintText?.tr ?? '',
              hintStyle: theme.textTheme.labelMedium?.copyWith(color: widget.hintTextColor),
              fillColor: widget.fillColor,
              filled: true,
              border: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: MyColor.getBorderColor()), borderRadius: BorderRadius.circular(widget.radius)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: MyColor.getBorderColor()), borderRadius: BorderRadius.circular(widget.radius)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.5, color: MyColor.getBorderColor()),
                borderRadius: BorderRadius.circular(widget.radius),
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.isPassword
                  ? UnconstrainedBox(
                      child: Material(
                        color: Colors.transparent,
                        shape: const CircleBorder(),
                        child: InkWell(
                          focusColor: MyColor.getBorderColor().withValues(alpha: 0.01),
                          autofocus: false,
                          canRequestFocus: false,
                          onTap: _toggle,
                          child: Container(
                              padding: const EdgeInsets.all(Dimensions.space5),
                              decoration: const BoxDecoration(shape: BoxShape.circle),
                              height: 25,
                              width: 25,
                              child: SvgPicture.asset(
                                obscureText ? MyImages.eyeInvisibleIcon : MyImages.eyeVisibleIcon,
                                color: MyColor.getBodyTextColor(),
                                height: 18,
                                width: 18,
                              )),
                        ),
                      ),
                    )
                  : widget.suffixIcon,
            ),
            onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : null,
            onChanged: (text) => widget.onChanged!(text),
          )
        : TextFormField(
            maxLines: widget.maxLines,
            readOnly: widget.readOnly,
            style: theme.textTheme.labelMedium?.copyWith(color: MyColor.getBodyTextColor()),
            cursorColor: MyColor.getBodyTextColor(),
            controller: widget.controller,
            autofocus: false,
            textInputAction: widget.inputAction,
            enabled: widget.isEnable,
            focusNode: widget.focusNode,
            validator: widget.validator,
            keyboardType: widget.textInputType,
            obscureText: widget.isPassword ? obscureText : false,
            decoration: InputDecoration(
              contentPadding: widget.contentPadding,
              labelText: widget.labelText?.tr ?? '',
              labelStyle: theme.textTheme.labelMedium?.copyWith(color: widget.labelTextColor),
              hintText: widget.hintText?.tr ?? '',
              hintStyle: theme.textTheme.labelMedium?.copyWith(color: widget.hintTextColor),
              fillColor: widget.fillColor,
              filled: true,
              border: UnderlineInputBorder(borderSide: BorderSide(width: 0.5, color: MyColor.getBorderColor())),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 0.5, color: MyColor.getBorderColor())),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 0.5, color: MyColor.getBorderColor())),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.isPassword
                  ? UnconstrainedBox(
                      child: Material(
                        color: Colors.transparent,
                        shape: const CircleBorder(),
                        child: InkWell(
                          splashColor: MyColor.getPrimaryColor().withValues(alpha: 0.1),
                          onTap: _toggle,
                          child: Container(
                              padding: const EdgeInsets.all(Dimensions.space5),
                              decoration: const BoxDecoration(shape: BoxShape.circle),
                              height: 25,
                              width: 25,
                              child: SvgPicture.asset(
                                obscureText ? MyImages.eyeInvisibleIcon : MyImages.eyeVisibleIcon,
                                color: MyColor.getBodyTextColor(),
                                height: 18,
                                width: 18,
                              )),
                        ),
                      ),
                    )
                  : widget.suffixIcon,
            ),
            onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : null,
            onChanged: (text) => widget.onChanged!(text),
          );
  }

  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
